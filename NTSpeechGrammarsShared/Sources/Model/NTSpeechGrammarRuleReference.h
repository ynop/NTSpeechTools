//
//  NTSpeechGrammarRuleReference.h
//  NTSpeechGrammars
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechGrammarElement.h"
#import "NTSpeechGrammarRule.h"

@interface NTSpeechGrammarRuleReference : NTSpeechGrammarElement

/*!
 *  Name of the referenced Rule. If referencedRule is not nil, the name of this rule is returned.
 */
@property (nonatomic, strong) NSString* referencedRuleName;
@property (nonatomic, strong) NTSpeechGrammarRule* referencedRule;

- (instancetype)initWithRuleName:(NSString*)name;

- (instancetype)initWithRule:(NTSpeechGrammarRule*)rule;

+ (NTSpeechGrammarRuleReference*)referenceWithRuleName:(NSString*)name;

+ (NTSpeechGrammarRuleReference*)referenceWithRule:(NTSpeechGrammarRule*)rule;

@end
