//
//  NTJsgfFileSearch.m
//  NTSpeechTools
//
//  Created by Matthias Büchi on 21/06/16.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTJsgfFileSearch.h"

@implementation NTJsgfFileSearch

- (instancetype)init
{
    NSAssert(NO, @"No path provided.");
    return nil;
}

- (instancetype)initWithName:(NSString*)name path:(NSString*)path
{
    self = [super initWithName:name];
    if (self) {
        _path = [path copy];
    }
    return self;
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone*)zone
{
    NTJsgfFileSearch* copy = [[NTJsgfFileSearch alloc] initWithName:self.name path:self.path];

    return copy;
}

@end
