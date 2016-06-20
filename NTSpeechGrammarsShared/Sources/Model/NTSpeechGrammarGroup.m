//
//  NTSpeechGrammarGroup.m
//  NTSpeechGrammars
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechGrammarGroup.h"

@implementation NTSpeechGrammarGroup

- (instancetype)initWithRoot:(NTSpeechGrammarElement*)root
{
    return [self initWithRoot:root optional:NO];
}

- (instancetype)initWithRoot:(NTSpeechGrammarElement*)root optional:(BOOL)isOptional
{
    self = [super init];
    if (self) {
        _root = root;
        _isOptional = isOptional;
    }
    return self;
}

+ (NTSpeechGrammarGroup*)groupWithRoot:(NTSpeechGrammarElement*)root
{
    return [[NTSpeechGrammarGroup alloc] initWithRoot:root];
}

+ (NTSpeechGrammarGroup*)optionalGroupWithRoot:(NTSpeechGrammarElement*)root
{
    return [[NTSpeechGrammarGroup alloc] initWithRoot:root optional:YES];
}

@end
