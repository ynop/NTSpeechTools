//
//  NTSpeechGrammar.m
//  NTSpeechGrammars
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechGrammar.h"

@interface NTSpeechGrammar ()

@property (nonatomic, strong) NSMutableArray* rulesInternal;

@end

@implementation NTSpeechGrammar

- (instancetype)init
{
    return [self initWithRootRule:nil];
}

- (instancetype)initWithRootRule:(NTSpeechGrammarRule*)rule
{
    self = [super init];
    if (self) {
        _rulesInternal = [NSMutableArray array];

        if (rule != nil) {
            [_rulesInternal addObject:rule];
            _rootRule = rule;
        }
    }
    return self;
}

- (void)addRule:(NTSpeechGrammarRule*)rule
{
    if ([self containsRuleWithName:rule.name]) {
        NSLog(@"Grammar %@ already contains a rule with the name %@", self.name, rule.name);
    }
    else {
        [self.rulesInternal addObject:rule];
    }
}

- (void)removeRule:(NTSpeechGrammarRule*)rule
{
    [self.rulesInternal removeObject:rule];
}

- (void)removeAllRules
{
    [self.rulesInternal removeAllObjects];
}

- (BOOL)containsRuleWithName:(NSString*)name
{
    for (NTSpeechGrammarRule* rule in self.rulesInternal) {
        if ([rule.name isEqualToString:name]) {
            return YES;
        }
    }

    return NO;
}

- (NSArray*)rules
{
    return [NSArray arrayWithArray:self.rulesInternal];
}

- (NSString*)serialize
{
    NSLog(@"Not Implemented.");

    return @"";
}

- (void)writeToFileAtPath:(NSString*)path
{
    NSError* error = nil;

    NSString* dicString = [self serialize];
    [dicString writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];

    if (error) {
        NSLog(@"Failed to write grammar to file with reason %@.", error);
    }
}

+ (NTSpeechGrammar*)grammarWithRootRule:(NTSpeechGrammarRule*)rule
{
    return [[NTSpeechGrammar alloc] initWithRootRule:rule];
}

@end
