//
//  NTJsgfGrammar.m
//  NTSpeechGrammars
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

#import "y.tab.h"

// Added some extras to suppress warnings...
#ifndef FLEXINT_H

typedef struct yy_buffer_state* YY_BUFFER_STATE;
YY_BUFFER_STATE yy_scan_string(const char* s);

float yyparse();
void yy_delete_buffer(YY_BUFFER_STATE buf);

#endif

@implementation NTJsgfGrammar

- (NSString*)serialize
{
    NSString* value = @"#JSGF V1.0;\n\n";
    NSString* name = @"undefined";

    if (self.name != nil) {
        name = self.name;
    }

    value = [value stringByAppendingFormat:@"grammar %@;", name];

    for (NTSpeechGrammarRule* rule in self.rules) {
        value = [value stringByAppendingFormat:@"\n\n %@", [self serializeRule:rule]];
    }

    return value;
}

- (NSString*)serializeRule:(NTSpeechGrammarRule*)rule
{
    NSString* value = @"";

    if (rule.scope == RULE_SCOPE_PUBLIC) {
        value = [value stringByAppendingString:@"public "];
    }

    value = [value stringByAppendingFormat:@"<%@> = %@;", rule.name, [self serializeGrammarElement:rule.root]];

    return value;
}

- (NSString*)serializeGrammarElement:(NTSpeechGrammarElement*)element
{
    NSString* value = @"";

    if ([element isKindOfClass:[NTSpeechGrammarToken class]]) {
        value = [self serializeToken:(NTSpeechGrammarToken*)element];
    }
    else if ([element isKindOfClass:[NTSpeechGrammarRuleReference class]]) {
        value = [self serializeRuleReference:(NTSpeechGrammarRuleReference*)element];
    }
    else if ([element isKindOfClass:[NTSpeechGrammarGroup class]]) {
        value = [self serializeGroup:(NTSpeechGrammarGroup*)element];
    }
    else if ([element isKindOfClass:[NTSpeechGrammarSequence class]]) {
        value = [self serializeSequence:(NTSpeechGrammarSequence*)element];
    }
    else if ([element isKindOfClass:[NTSpeechGrammarAlternative class]]) {
        value = [self serializeAlternative:(NTSpeechGrammarAlternative*)element];
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

    if (element.weight >= 0) {
        value = [NSString stringWithFormat:@"/%g/ %@", element.weight, value];
    }

    if (element.tags.count > 0) {
        for (NSString* tag in element.tags) {
            value = [value stringByAppendingFormat:@" {%@}", tag];
        }
    }

    return value;
}

- (NSString*)serializeToken:(NTSpeechGrammarToken*)token
{
    if ([token.value rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]].location != NSNotFound) {
        return [NSString stringWithFormat:@"%@", token.value.uppercaseString];
    }
    else {
        return token.value.uppercaseString;
    }
}

- (NSString*)serializeRuleReference:(NTSpeechGrammarRuleReference*)reference
{
    return [NSString stringWithFormat:@"<%@>", reference.referencedRuleName];
}

- (NSString*)serializeGroup:(NTSpeechGrammarGroup*)group
{
    if (group.isOptional) {
        return [NSString stringWithFormat:@"[ %@ ]", [self serializeGrammarElement:group.root]];
    }
    else {
        return [NSString stringWithFormat:@"( %@ )", [self serializeGrammarElement:group.root]];
    }
}

- (NSString*)serializeSequence:(NTSpeechGrammarSequence*)sequence
{
    NSMutableArray* elements = [NSMutableArray array];

    for (NTSpeechGrammarElement* el in sequence.elements) {
        if ([el isKindOfClass:[NTSpeechGrammarAlternative class]]) {
            [elements addObject:[NSString stringWithFormat:@"(%@)", [self serializeGrammarElement:el]]];
        }
        else {
            [elements addObject:[self serializeGrammarElement:el]];
        }
    }

    return [elements componentsJoinedByString:@" "];
}

- (NSString*)serializeAlternative:(NTSpeechGrammarAlternative*)alternative
{
    NSMutableArray* elements = [NSMutableArray array];

    for (NTSpeechGrammarElement* el in alternative.elements) {
        [elements addObject:[self serializeGrammarElement:el]];
    }

    return [elements componentsJoinedByString:@" | "];
}

+ (NTJsgfGrammar*)jsgfGrammarWithRootRule:(NTSpeechGrammarRule*)rule
{
    return [[NTJsgfGrammar alloc] initWithRootRule:rule];
}

+ (NTJsgfGrammar*)jsgfGrammarFromString:(NSString*)value
{
    YY_BUFFER_STATE buf;

    buf = yy_scan_string([value cStringUsingEncoding:NSUTF8StringEncoding]);

    NTJsgfGrammar* grammar = [[NTJsgfGrammar alloc] init];

    int failed = yyparse(grammar);

    yy_delete_buffer(buf);

    if (!failed) {
        return grammar;
    }
    else {
        NSLog(@"Failed to parse grammar");

        return nil;
    }
}

+ (NTJsgfGrammar*)jsgfGrammarFromFile:(NSString*)path
{
    NSError* error = nil;

    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];

    if (error) {
        NSLog(@"Error reading file at path %@ (%@)", path, error);
        return nil;
    }
    else {
        return [NTJsgfGrammar jsgfGrammarFromString:content];
    }
}

@end
