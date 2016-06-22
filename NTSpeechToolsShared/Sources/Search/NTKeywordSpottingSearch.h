//
//  NTKeywordSpottingSearch.h
//  NTSpeechTools
//
//  Created by Matthias Büchi on 21/06/16.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechSearch.h"

/*!
 *  A search for trying to recognize one of the keywords in a list.
 */
@interface NTKeywordSpottingSearch : NTSpeechSearch

/*!
 *  Keyword / Threshold pairs
 */
@property (nonatomic, strong, readonly) NSDictionary<NSString*, NSNumber*>* keywords;

/*!
 *  Creates new KWS search with the given name and the keywors.
 *
 *  @param name     Name
 *  @param keywords Keyword/Threshold pairs
 *
 *  @return instance
 */
- (instancetype)initWithName:(NSString*)name keywords:(NSDictionary<NSString*, NSNumber*>*)keywords;

/*!
 *  Adds a keyword with the default threshold 1. If the keyword already is in the list threshold 1 is set.
 *
 *  @param keyword Keyword
 */
- (void)addKeyword:(NSString*)keyword;

/*!
 *  Adds the keyword with the given threshold. If the keyword already is in the list the new threshold is set.
 *
 *  @param keyword   Keyword
 *  @param threshold Threshold
 */
- (void)addKeyword:(NSString*)keyword withThreshold:(double)threshold;

/*!
 *  Add keywords from array with default threshold 1. Same as calling addKeyword for all keywords in the array.
 *
 *  @param keywords List of keywords
 */
- (void)addKeywords:(NSArray<NSString*>*)keywords;

/*!
 *  Add keywords with thresholds from dictionary. Same as calling addKeyword:withThreshold for all pairs in the dictionary.
 *
 *  @param keywords Keyword/Threshold pairs
 */
- (void)addKeywordsFromDictionary:(NSDictionary<NSString*, NSNumber*>*)keywords;

/*!
 *  Removes the given keyword.
 *
 *  @param keyword Keyword to remove
 */
- (void)removeKeyword:(NSString*)keyword;

#pragma mark - Serialize/Parse
/*!
 *  Saves the keywords into the file at the given path.
 *
 *  @param path Path
 */
- (void)saveToFileAtPath:(NSString*)path;

/*!
 *  Add all keywords from the file at the given path.
 *
 *  @param path path
 */
- (void)addKeywordsFromFileAtPath:(NSString*)path;

/*!
 *  Parses keywords and optionaly thresholds from file
 *
 *  KEYWORD /1e-10/
 *  KEYWORD2 /1e-40/
 *
 *  @param path Path
 *
 *  @return keyword/threshold pairs
 */
+ (NSDictionary<NSString*, NSNumber*>*)parseKeywordsFromFileAtPath:(NSString*)path;

#pragma mark - Convenience Constructors
/*!
 *  Create a search with a single keyword.
 *
 *  @param keyword Keyword
 *
 *  @return instance
 */
+ (NTKeywordSpottingSearch*)searchWithName:(NSString*)name keyword:(NSString*)keyword;

/*!
 *  Create a search with a single keyword and a threshold.
 *
 *  @param keyword   Keyword
 *  @param threshold Threshold
 *
 *  @return instance
 */
+ (NTKeywordSpottingSearch*)searchWithName:(NSString*)name keyword:(NSString*)keyword threshold:(double)threshold;

/*!
 *  Create a search with keywords from an array.
 *
 *  @param keywords List of keywords
 *
 *  @return instance
 */
+ (NTKeywordSpottingSearch*)searchWithName:(NSString*)name keywords:(NSArray<NSString*>*)keywords;

/*!
 *  Create a search with keywords and thresholds from a dictionary.
 *
 *  @param keywords Keyword/Threshold pairs
 *
 *  @return instance
 */
+ (NTKeywordSpottingSearch*)searchWithName:(NSString*)name keywordsAndThresholds:(NSDictionary<NSString*, NSNumber*>*)keywords;

/*!
 *  Creates a search with the keywords from a file.
 *
 *  @param path Path to the file
 */
+ (NTKeywordSpottingSearch*)searchWithName:(NSString*)name andKeywordsFromFileAtPath:(NSString*)path;

@end
