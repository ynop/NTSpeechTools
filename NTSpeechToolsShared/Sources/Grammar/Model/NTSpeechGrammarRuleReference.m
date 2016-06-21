//
//  NTSpeechGrammarRuleReference.m
//  NTSpeechTools
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechGrammarRuleReference.h"

@implementation NTSpeechGrammarRuleReference

- (instancetype)initWithRuleName:(NSString*)name
{
    self = [super init];
    if (self) {
        _referencedRuleName = name;
    }
    return self;
}

- (instancetype)initWithRule:(NTSpeechGrammarRule*)rule
{
    self = [super init];
    if (self) {
        _referencedRule = rule;
    }
    return self;
}

- (NSString*)referencedRuleName
{
    if (self.referencedRule != nil) {
        return self.referencedRule.name;
    }
    else {
        return _referencedRuleName;
    }
}

+ (NTSpeechGrammarRuleReference*)referenceWithRuleName:(NSString*)name
{
    return [[NTSpeechGrammarRuleReference alloc] initWithRuleName:name];
}

+ (NTSpeechGrammarRuleReference*)referenceWithRule:(NTSpeechGrammarRule*)rule
{
    return [[NTSpeechGrammarRuleReference alloc] initWithRule:rule];
}

@end
