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
        _name = @"";
        _language = @"";
        _version = @"";

        if (rule != nil) {
            [_rulesInternal addObject:rule];
            _rootRule = rule;
        }
    }
    return self;
}

#pragma mark - Rules
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

#pragma mark - Convenience Constructors
+ (NTSpeechGrammar*)grammarWithName:(NSString*)name
{
    NTSpeechGrammar* grammar = [NTSpeechGrammar new];
    grammar.name = name;

    return grammar;
}

+ (NTSpeechGrammar*)grammarWithRootRule:(NTSpeechGrammarRule*)rule
{
    return [[NTSpeechGrammar alloc] initWithRootRule:rule];
}

@end
