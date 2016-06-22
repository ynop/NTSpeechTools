//
//  NTGrammarSearch.m
//  NTSpeechTools
//
//  Created by Matthias Büchi on 21/06/16.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTGrammarSearch.h"

@implementation NTGrammarSearch

- (instancetype)init
{
    NSAssert(NO, @"No grammar provided.");
    return nil;
}

- (instancetype)initWithName:(NSString*)name grammar:(NTSpeechGrammar*)grammar
{
    self = [super initWithName:name];
    if (self) {
        _grammar = grammar;
    }
    return self;
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone*)zone
{
    //TODO: make a copy of the grammar before pass
    NTGrammarSearch* copy = [[NTGrammarSearch alloc] initWithName:self.name grammar:self.grammar];

    return copy;
}

@end
