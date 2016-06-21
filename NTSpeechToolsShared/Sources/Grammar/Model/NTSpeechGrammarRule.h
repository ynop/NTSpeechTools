//
//  NTSpeechGrammarRule.h
//  NTSpeechTools
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechGrammarElement.h"
#import <Foundation/Foundation.h>

typedef enum {
    RULE_SCOPE_PRIVATE,
    RULE_SCOPE_PUBLIC
} NTSpeechGrammarRuleScope;

@interface NTSpeechGrammarRule : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NTSpeechGrammarElement* root;
@property (nonatomic) NTSpeechGrammarRuleScope scope;

- (instancetype)initWithName:(NSString*)name;

- (instancetype)initWithName:(NSString*)name rootElement:(NTSpeechGrammarElement*)element;

+ (NTSpeechGrammarRule*)ruleWithName:(NSString*)name;

+ (NTSpeechGrammarRule*)ruleWithName:(NSString*)name root:(NTSpeechGrammarElement*)root;

+ (NTSpeechGrammarRule*)publicRuleWithName:(NSString*)name;

+ (NTSpeechGrammarRule*)publicRuleWithName:(NSString*)name root:(NTSpeechGrammarElement*)root;

@end
