//
//  NTJsgfGrammar.m
//  NTSpeechTools
//
//  Created by Matthias Büchi on 16.09.15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTJsgfGrammar.h"
#import "NTSpeechGrammarAlternative.h"
#import "NTSpeechGrammarGroup.h"
#import "NTSpeechGrammarRuleReference.h"
#import "NTSpeechGrammarSequence.h"
#import "NTSpeechGrammarToken.h"

#import "NTJsgfParser.h"

// Added some extras to suppress warnings...
#ifndef FLEXINT_H

typedef struct yy_buffer_state* YY_BUFFER_STATE;
YY_BUFFER_STATE nt_scan_string(const char* s);

float ntparse();
void nt_delete_buffer(YY_BUFFER_STATE buf);

#endif

@implementation NTJsgfGrammar

#pragma mark - Serialization
+ (NSString*)serializeGrammar:(NTSpeechGrammar*)grammar
{
    NSString* value = [NSString stringWithFormat:@"#JSGF %@ ISO8859-1 %@;\n\n", grammar.version, grammar.language];
    NSString* name = @"undefined";

    if (grammar.name != nil) {
        name = grammar.name;
    }

    value = [value stringByAppendingFormat:@"grammar %@;", name];

    for (NTSpeechGrammarRule* rule in grammar.rules) {
        value = [value stringByAppendingFormat:@"\n\n %@", [NTJsgfGrammar serializeRule:rule]];
    }

    return value;
}

+ (BOOL)writeGrammar:(NTSpeechGrammar*)grammar toFileAtPath:(NSString*)path
{
    NSError* error = nil;

    NSString* serialized = [NTJsgfGrammar serializeGrammar:grammar];
    BOOL success = [serialized writeToFile:path atomically:NO encoding:NSUTF8StringEncoding error:&error];

    if (!success) {
        NSLog(@"Error while writing grammar to file at path: %@ (%@)", path, error);
    }

    return success;
}

+ (NSString*)serializeRule:(NTSpeechGrammarRule*)rule
{
    NSString* value = @"";

    if (rule.scope == RULE_SCOPE_PUBLIC) {
        value = [value stringByAppendingString:@"public "];
    }

    value = [value stringByAppendingFormat:@"<%@> = %@;", rule.name, [NTJsgfGrammar serializeGrammarElement:rule.root]];

    return value;
}

+ (NSString*)serializeGrammarElement:(NTSpeechGrammarElement*)element
{
    NSString* value = @"";

    if ([element isKindOfClass:[NTSpeechGrammarToken class]]) {
        value = [NTJsgfGrammar serializeToken:(NTSpeechGrammarToken*)element];
    }
    else if ([element isKindOfClass:[NTSpeechGrammarRuleReference class]]) {
        value = [NTJsgfGrammar serializeRuleReference:(NTSpeechGrammarRuleReference*)element];
    }
    else if ([element isKindOfClass:[NTSpeechGrammarGroup class]]) {
        value = [NTJsgfGrammar serializeGroup:(NTSpeechGrammarGroup*)element];
    }
    else if ([element isKindOfClass:[NTSpeechGrammarSequence class]]) {
        value = [NTJsgfGrammar serializeSequence:(NTSpeechGrammarSequence*)element];
    }
    else if ([element isKindOfClass:[NTSpeechGrammarAlternative class]]) {
        value = [NTJsgfGrammar serializeAlternative:(NTSpeechGrammarAlternative*)element];
    }

    if (element.repeatMode == REPEAT_ONE_OR_MORE) {
        value = [value stringByAppendingString:@" +"];
    }
    else if (element.repeatMode == REPEAT_ZERO_OR_MORE) {
        value = [value stringByAppendingString:@" *"];
    }
    else if (element.repeatMode == REPEAT_CUSTOM) {
        if (element.minRepeat == 0) {
            value = [value stringByAppendingString:@" *"];
        }
        else {
            value = [value stringByAppendingString:@" +"];
        }
    }

    if (element.tags.count > 0) {
        for (NSString* tag in element.tags) {
            value = [value stringByAppendingFormat:@" {%@}", tag];
        }
    }

    return value;
}

+ (NSString*)serializeToken:(NTSpeechGrammarToken*)token
{
    if ([token.value rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]].location != NSNotFound) {
        return [NSString stringWithFormat:@"%@", token.value];
    }
    else {
        return token.value;
    }
}

+ (NSString*)serializeRuleReference:(NTSpeechGrammarRuleReference*)reference
{
    return [NSString stringWithFormat:@"<%@>", reference.referencedRuleName];
}

+ (NSString*)serializeGroup:(NTSpeechGrammarGroup*)group
{
    if (group.isOptional) {
        return [NSString stringWithFormat:@"[ %@ ]", [NTJsgfGrammar serializeGrammarElement:group.root]];
    }
    else {
        return [NSString stringWithFormat:@"( %@ )", [NTJsgfGrammar serializeGrammarElement:group.root]];
    }
}

+ (NSString*)serializeSequence:(NTSpeechGrammarSequence*)sequence
{
    NSMutableArray* elements = [NSMutableArray array];

    for (NTSpeechGrammarElement* el in sequence.elements) {
        if ([el isKindOfClass:[NTSpeechGrammarAlternative class]]) {
            [elements addObject:[NSString stringWithFormat:@"(%@)", [NTJsgfGrammar serializeGrammarElement:el]]];
        }
        else {
            [elements addObject:[NTJsgfGrammar serializeGrammarElement:el]];
        }
    }

    return [elements componentsJoinedByString:@" "];
}

+ (NSString*)serializeAlternative:(NTSpeechGrammarAlternative*)alternative
{
    NSMutableArray* elements = [NSMutableArray array];

    BOOL weightsNeeded = NO;
    float weight = ((NTSpeechGrammarElement*)alternative.elements[0]).weight;

    for (int i = 1; i < alternative.elements.count; i++) {
        if (((NTSpeechGrammarElement*)alternative.elements[i]).weight != weight) {
            weightsNeeded = YES;
        }
    }

    for (NTSpeechGrammarElement* el in alternative.elements) {
        NSString* serialized = [NTJsgfGrammar serializeGrammarElement:el];

        if (weightsNeeded) {
            serialized = [NSString stringWithFormat:@"/%g/ %@", el.weight, serialized];
        }

        [elements addObject:serialized];
    }

    return [elements componentsJoinedByString:@" | "];
}

#pragma mark - Parsing
+ (NTSpeechGrammar*)grammarFromString:(NSString*)value
{
    YY_BUFFER_STATE buf;

    buf = nt_scan_string([value cStringUsingEncoding:NSUTF8StringEncoding]);

    NTSpeechGrammar* grammar = [[NTSpeechGrammar alloc] init];

    int failed = ntparse(grammar);

    nt_delete_buffer(buf);

    if (!failed) {
        return grammar;
    }
    else {
        NSLog(@"Failed to parse grammar");

        return nil;
    }
}

+ (NTSpeechGrammar*)grammarFromFileAtPath:(NSString*)path
{
    NSError* error = nil;

    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];

    if (error) {
        NSLog(@"Error reading file at path %@ (%@)", path, error);
        return nil;
    }
    else {
        return [NTJsgfGrammar grammarFromString:content];
    }
}

@end
