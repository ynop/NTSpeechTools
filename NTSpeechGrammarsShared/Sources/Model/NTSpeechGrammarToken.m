//
//  NTSpeechGrammarToken.m
//  NTSpeechGrammars
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechGrammarToken.h"

@implementation NTSpeechGrammarToken

- (instancetype)init
{
    return [self initWithValue:@"undefined"];
}

- (instancetype)initWithValue:(NSString*)value
{
    self = [super init];
    if (self) {
        _value = value;
    }
    return self;
}

- (instancetype)initWithValue:(NSString*)value weight:(int)weight
{
    self = [super initWithWeight:weight];
    if (self) {
        _value = value;
    }
    return self;
}

+ (NTSpeechGrammarToken*)token:(NSString*)value
{
    return [[NTSpeechGrammarToken alloc] initWithValue:value];
}

+ (NTSpeechGrammarToken*)token:(NSString*)value weight:(int)weight
{
    return [[NTSpeechGrammarToken alloc] initWithValue:value weight:weight];
}

@end
