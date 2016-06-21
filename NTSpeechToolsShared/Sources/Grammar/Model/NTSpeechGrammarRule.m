//
//  NTSpeechGrammarRule.m
//  NTSpeechTools
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechGrammarRule.h"

@implementation NTSpeechGrammarRule

- (instancetype)init
{
    return [self initWithName:@"unknown"];
}

- (instancetype)initWithName:(NSString*)name
{
    return [self initWithName:name rootElement:nil];
}

- (instancetype)initWithName:(NSString*)name rootElement:(NTSpeechGrammarElement*)element
{
    self = [super init];
    if (self) {
        _scope = RULE_SCOPE_PRIVATE;
        _root = element;
        _name = name;
    }
    return self;
}

+ (NTSpeechGrammarRule*)ruleWithName:(NSString*)name
{
    return [[NTSpeechGrammarRule alloc] initWithName:name];
}

+ (NTSpeechGrammarRule*)ruleWithName:(NSString*)name root:(NTSpeechGrammarElement*)root
{
    return [[NTSpeechGrammarRule alloc] initWithName:name rootElement:root];
}

+ (NTSpeechGrammarRule*)publicRuleWithName:(NSString*)name
{
    NTSpeechGrammarRule* rule = [NTSpeechGrammarRule ruleWithName:name];
    rule.scope = RULE_SCOPE_PUBLIC;
    return rule;
}

+ (NTSpeechGrammarRule*)publicRuleWithName:(NSString*)name root:(NTSpeechGrammarElement*)root
{
    NTSpeechGrammarRule* rule = [NTSpeechGrammarRule ruleWithName:name root:root];
    rule.scope = RULE_SCOPE_PUBLIC;
    return rule;
}

@end
