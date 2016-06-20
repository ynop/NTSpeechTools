//
//  NTSpeechGrammarElement.m
//  NTSpeechGrammars
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechGrammarElement.h"

@interface NTSpeechGrammarElement ()

@property (nonatomic, strong) NSMutableArray* tagsInternal;

@end

@implementation NTSpeechGrammarElement

- (instancetype)init
{
    return [self initWithWeight:1.0f];
}

- (instancetype)initWithWeight:(int)weight
{
    self = [super init];
    if (self) {
        _tagsInternal = [NSMutableArray array];
        _weight = weight;
        _repeatMode = REPEAT_EXACTLY_ONCE;
        _minRepeat = 1;
        _maxRepeat = 1;
    }
    return self;
}

- (void)setMinRepeat:(unsigned int)minRepeat
{
    if (minRepeat > _maxRepeat) {
        _minRepeat = _maxRepeat;
    }
    else {
        _minRepeat = minRepeat;
    }
}

- (void)setMaxRepeat:(unsigned int)maxRepeat
{
    if (maxRepeat < _minRepeat) {
        _maxRepeat = _minRepeat;
    }
    else {
        _maxRepeat = maxRepeat;
    }
}

- (void)addTag:(NSString*)tag
{
    [self.tagsInternal addObject:tag];
}

- (void)removeTag:(NSString*)tag
{
    [self.tagsInternal removeObject:tag];
}

- (void)removeAllTags
{
    [self.tagsInternal removeAllObjects];
}

- (NSArray*)tags
{
    return [NSArray arrayWithArray:self.tagsInternal];
}

@end
