//
//  NTHypothesis.m
//  NTSpeechTools
//
//  Created by Matthias Büchi on 22/06/16.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTHypothesis.h"

@implementation NTHypothesis

- (instancetype)initWithValue:(NSString*)value
{
    return [self initWithValue:value score:0.0];
}

- (instancetype)initWithValue:(NSString*)value score:(double)score
{
    return [self initWithValue:value score:score probability:0.0];
}

- (instancetype)initWithValue:(NSString*)value score:(double)score probability:(double)probability
{
    self = [super init];
    if (self) {
        _value = [value copy];
        _pathScore = score;
        _posteriorProbability = probability;
    }
    return self;
}

#pragma mark - Convinience Constructors
+ (NTHypothesis*)hypothesis:(NSString*)value
{
    return [[NTHypothesis alloc] initWithValue:value];
}

+ (NTHypothesis*)hypothesis:(NSString*)value score:(double)score
{
    return [[NTHypothesis alloc] initWithValue:value score:score];
}

+ (NTHypothesis*)hypothesis:(NSString*)value score:(double)score probability:(double)probability
{
    return [[NTHypothesis alloc] initWithValue:value score:score probability:probability];
}

@end
