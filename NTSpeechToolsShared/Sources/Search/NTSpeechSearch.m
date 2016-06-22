//
//  NTSpeechSearch.m
//  NTSpeechTools
//
//  Created by Matthias Büchi on 21/06/16.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechSearch.h"

@implementation NTSpeechSearch

- (instancetype)initWithName:(NSString*)name
{
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone*)zone
{
    NTSpeechSearch* copy = [[NTSpeechSearch alloc] initWithName:self.name];

    return copy;
}

@end
