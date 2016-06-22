//
//  NTNGramFileSearch.h
//  NTSpeechTools
//
//  Created by Matthias Büchi on 21/06/16.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechSearch.h"

/*!
 *  A search based on a N-Gram language model in a file.
 */
@interface NTNGramFileSearch : NTSpeechSearch

/*!
 *  Path to the n-gram file.
 */
@property (nonatomic, strong, readonly) NSString* path;

/*!
 *  Create new search with name and path to the n-gram file.
 *
 *  @param name Name
 *  @param path Path
 *
 *  @return instance
 */
- (instancetype)initWithName:(NSString*)name path:(NSString*)path;

@end
