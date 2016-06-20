//
//  NTSpeechGrammar.h
//  NTSpeechGrammars
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

@import Foundation;

#import "NTSpeechGrammarAlternative.h"
#import "NTSpeechGrammarElement.h"
#import "NTSpeechGrammarGroup.h"
#import "NTSpeechGrammarRule.h"
#import "NTSpeechGrammarRuleReference.h"
#import "NTSpeechGrammarSequence.h"
#import "NTSpeechGrammarToken.h"

@interface NTSpeechGrammar : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* version;
@property (nonatomic, strong) NSString* language;
@property (nonatomic, strong, readonly) NSArray* rules;
@property (nonatomic, strong) NTSpeechGrammarRule* rootRule;

- (instancetype)initWithRootRule:(NTSpeechGrammarRule*)rule;

#pragma mark - Rules
- (void)addRule:(NTSpeechGrammarRule*)rule;

- (void)removeRule:(NTSpeechGrammarRule*)rule;

- (void)removeAllRules;

- (BOOL)containsRuleWithName:(NSString*)name;

#pragma mark - Convenience Constructors
+ (NTSpeechGrammar*)grammarWithName:(NSString*)name;

+ (NTSpeechGrammar*)grammarWithRootRule:(NTSpeechGrammarRule*)rule;

@end
