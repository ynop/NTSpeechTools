//
//  NTSpeechGrammarGroup.h
//  NTSpeechGrammars
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechGrammarElement.h"

@interface NTSpeechGrammarGroup : NTSpeechGrammarElement

@property (nonatomic) BOOL isOptional;
@property (nonatomic, strong) NTSpeechGrammarElement* root;

- (instancetype)initWithRoot:(NTSpeechGrammarElement*)root;

- (instancetype)initWithRoot:(NTSpeechGrammarElement*)root optional:(BOOL)isOptional;

+ (NTSpeechGrammarGroup*)groupWithRoot:(NTSpeechGrammarElement*)root;

+ (NTSpeechGrammarGroup*)optionalGroupWithRoot:(NTSpeechGrammarElement*)root;

@end
