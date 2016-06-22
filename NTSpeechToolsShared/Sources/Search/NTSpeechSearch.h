//
//  NTSpeechSearch.h
//  NTSpeechTools
//
//  Created by Matthias Büchi on 21/06/16.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  A search is method a recognizer can use for speech recognition.
 */
@interface NTSpeechSearch : NSObject <NSCopying>

/*!
 *  The name of the search.
 */
@property (nonatomic, strong, readonly) NSString* name;

/*!
 *  Creates search with the given name.
 *
 *  @param name Name
 *
 *  @return Instance
 */
- (instancetype)initWithName:(NSString*)name;

@end
