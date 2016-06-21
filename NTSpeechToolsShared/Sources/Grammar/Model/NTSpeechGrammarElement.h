//
//  NTSpeechGrammarElement.h
//  NTSpeechTools
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    REPEAT_EXACTLY_ONCE,
    REPEAT_ONE_OR_MORE,
    REPEAT_ZERO_OR_MORE,
    REPEAT_CUSTOM // minRepeat / maxRepeat
} NTSpeechGrammarElementRepeatMode;

@interface NTSpeechGrammarElement : NSObject

/*!
 *  Defines how often this element can be spoken.
 */
@property (nonatomic) NTSpeechGrammarElementRepeatMode repeatMode;

/*!
 *  How often this element at least has to be spoken. If minRepeat is set greater than maxRepeat, it will be set equal to maxRepeat.
 *
 *  Only used if repeatMode is set to REPEAT_CUSTOM.
 */
@property (nonatomic) unsigned int minRepeat;

/*!
 *  How often this element can be spoken in maximum. If maxRepeat is set smaller than minRepeat, it will be set equal to minRepeat.
 *
 *  Only used if repeatMode is set to REPEAT_CUSTOM.
 */
@property (nonatomic) unsigned int maxRepeat;

/*!
 *  Weight of this element. Only used if this element is an element of an alternative.
 */
@property (nonatomic) float weight;

/*!
 *  Tags of this element.
 */
@property (nonatomic, strong, readonly) NSArray* tags;

- (instancetype)initWithWeight:(int)weight;

/*!
 *  Adds a tag.
 *
 *  @param tag Tag
 */
- (void)addTag:(NSString*)tag;

/*!
 *  Removes the given tag.
 *
 *  @param tag Tag
 */
- (void)removeTag:(NSString*)tag;

/*!
 *  Removes all tags.
 */
- (void)removeAllTags;

@end
