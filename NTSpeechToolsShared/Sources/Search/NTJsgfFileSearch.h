//
//  NTJsgfFileSearch.h
//  NTSpeechTools
//
//  Created by Matthias Büchi on 21/06/16.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechSearch.h"

/*!
 *  A search based on a jsgf grammar in a file.
 */
@interface NTJsgfFileSearch : NTSpeechSearch

/*!
 *  Path to the jsgf file.
 */
@property (nonatomic, strong, readonly) NSString* path;

/*!
 *  Create new search with name and path.
 *
 *  @param name Name
 *  @param path Path
 *
 *  @return instance
 */
- (instancetype)initWithName:(NSString*)name path:(NSString*)path;

#pragma mark - Convencience Constructors
/*!
 *  Create a search with a jsgf file.
 *
 *  @param name    Name
 *  @param path    Path to jsgf file
 *
 *  @return instance
 */
+ (NTJsgfFileSearch*)searchWithName:(NSString*)name path:(NSString*)path;

@end
