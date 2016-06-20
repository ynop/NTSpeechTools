
//
//  NTSpeechGrammarSequence.m
//  NTSpeechGrammars
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechGrammarSequence.h"

@implementation NTSpeechGrammarSequence

- (void)dealloc
{
    NSLog(@"DEALLOC SEQ %@", self);
}

+ (NTSpeechGrammarSequence*)sequenceWithElements:(NSArray*)elements
{
    return [[NTSpeechGrammarSequence alloc] initWithElements:elements];
}

+ (NTSpeechGrammarSequence*)sequenceWithTokens:(NSArray*)tokens
{
    return [[NTSpeechGrammarSequence alloc] initWithTokens:tokens];
}

@end
