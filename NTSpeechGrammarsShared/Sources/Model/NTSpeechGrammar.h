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
@property (nonatomic, strong, readonly) NSArray* rules;
@property (nonatomic, strong) NTSpeechGrammarRule* rootRule;

- (instancetype)initWithRootRule:(NTSpeechGrammarRule*)rule;

- (void)addRule:(NTSpeechGrammarRule*)rule;

- (void)removeRule:(NTSpeechGrammarRule*)rule;

- (void)removeAllRules;

- (BOOL)containsRuleWithName:(NSString*)name;

- (NSString*)serialize;

- (void)writeToFileAtPath:(NSString*)path;

+ (NTSpeechGrammar*)grammarWithRootRule:(NTSpeechGrammarRule*)rule;

@end
