//
//  NTKeywordSpottingSearch.m
//  NTSpeechTools
//
//  Created by Matthias Büchi on 21/06/16.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTKeywordSpottingSearch.h"

@interface NTKeywordSpottingSearch ()

@property (nonatomic, strong) NSMutableDictionary* keywordsInternal;

@end

@implementation NTKeywordSpottingSearch

- (instancetype)initWithName:(NSString*)name
{
    return [self initWithName:name keywords:@{}];
}

- (instancetype)initWithName:(NSString*)name keywords:(NSDictionary*)keywords
{
    self = [super init];
    if (self) {
        _keywordsInternal = [NSMutableDictionary dictionaryWithDictionary:keywords];
    }
    return self;
}

- (void)addKeyword:(NSString*)keyword
{
    [self addKeyword:keyword withThreshold:1.0];
}

- (void)addKeyword:(NSString*)keyword withThreshold:(double)threshold
{
    self.keywordsInternal[keyword] = @(threshold);
}

- (void)addKeywords:(NSArray<NSString*>*)keywords
{
    for (NSString* keyword in keywords) {
        [self addKeyword:keyword];
    }
}

- (void)addKeywordsFromDictionary:(NSDictionary<NSString*, NSNumber*>*)keywords
{
    for (NSString* keyword in keywords.allKeys) {
        [self addKeyword:keyword withThreshold:[keywords[keyword] doubleValue]];
    }
}

- (void)removeKeyword:(NSString*)keyword
{
    [self.keywordsInternal removeObjectForKey:keyword];
}

- (NSDictionary<NSString*, NSNumber*>*)keywords
{
    return [NSDictionary dictionaryWithDictionary:self.keywordsInternal];
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone*)zone
{
    NTKeywordSpottingSearch* copy = [[NTKeywordSpottingSearch alloc] initWithName:self.name keywords:self.keywordsInternal];

    return copy;
}

#pragma mark - Convenience Constructors
+ (NTKeywordSpottingSearch*)searchWithName:(NSString*)name keyword:(NSString*)keyword
{
    NTKeywordSpottingSearch* kws = [[NTKeywordSpottingSearch alloc] initWithName:name];
    [kws addKeyword:keyword];

    return kws;
}

+ (NTKeywordSpottingSearch*)searchWithName:(NSString*)name keyword:(NSString*)keyword threshold:(double)threshold
{
    NTKeywordSpottingSearch* kws = [[NTKeywordSpottingSearch alloc] initWithName:name];
    [kws addKeyword:keyword withThreshold:threshold];

    return kws;
}

+ (NTKeywordSpottingSearch*)searchWithName:(NSString*)name keywords:(NSArray<NSString*>*)keywords
{
    NTKeywordSpottingSearch* kws = [[NTKeywordSpottingSearch alloc] initWithName:name];
    [kws addKeywords:keywords];

    return kws;
}

+ (NTKeywordSpottingSearch*)searchWithName:(NSString*)name keywordsAndThresholds:(NSDictionary<NSString*, NSNumber*>*)keywords
{
    NTKeywordSpottingSearch* kws = [[NTKeywordSpottingSearch alloc] initWithName:name];
    [kws addKeywordsFromDictionary:keywords];

    return kws;
}

@end
