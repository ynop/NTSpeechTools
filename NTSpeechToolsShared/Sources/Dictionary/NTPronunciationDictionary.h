//
//  NTPronunciationDictionary.h
//  NTSpeechTools
//
//  Created by Matthias Büchi on 16.09.15.
//  Copyright (c) 2015 NT. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  Represents a phonetic dictionary. Contains words with corresponding phones. One word can have multiple phones. Words and phones are stored in upper case.
 */
@interface NTPronunciationDictionary : NSObject <NSCopying>

/*!
 *  The name identifying this dictionary.
 */
@property (nonatomic, strong) NSString* name;

/*!
 *  The list of words with the corresponding phones. 
 *  
 *  Example:
 *
 *  @{
 *    @"word" : @[ @"phone a", @"phone b", @"phone c"],
 *    @"word b" : @[ @"phone ba", @"phone bb",]
 *  }
 */
@property (nonatomic, strong, readonly) NSDictionary* entries;

/*!
 *  A list of words contained in the entries. (entries.allKeys)
 */
@property (nonatomic, strong, readonly) NSArray* allWords;

/*!
 *  Creates a phonetic dictionary without entries.
 *
 *  @return Empty Dictionary
 */
- (instancetype)init;

/*!
 *  Creates a phonetic dictionary with a given name
 *
 *  @param name Name
 *
 *  @return Dictionary
 */
- (instancetype)initWithName:(NSString*)name;

/*!
 *  Creates a phonetic dictionary with words loaded from a file.
 *
 *  File format:
 *
 *  [word]\t[phones]
 *  [wordb]\t[phonesb]
 *  [wordb](1)\t[phonesb2]
 *
 *  @param name Name
 *  @param path The path to the file with the words to load.
 *
 *  @return Dictionary
 */
- (instancetype)initWithName:(NSString*)name fileAtPath:(NSString*)path;

/*!
 *  Creates a phonetic dictionary with words parsed from a string.
 *
 *  String format:
 *
 *  [word]\t[phones]
 *  [wordb]\t[phonesb]
 *  [wordb](1)\t[phones2]
 *
 *  @param name Name
 *  @param dictionaryString String to parse words from
 *
 *  @return Dictionary
 */
- (instancetype)initWithName:(NSString*)name dictionaryString:(NSString*)dictionaryString;

/*!
 *  Creates a dictionary with the given words.
 *
 *  @param name Name
 *  @param words Words/Phones.
 *
 *  NSDictionary Format:
 *
 *  @{
 *    @"word" : @[ @"phone a", @"phone b", @"phone c"],
 *    @"word b" : @[ @"phone ba", @"phone bb",]
 *  }
 *
 *  @return Dictionary
 */
- (instancetype)initWithName:(NSString*)name words:(NSDictionary*)words;

/*!
 *  Add the phones for the given word. Existing phones for the same words won't be deleted.
 *
 *  @param word   Word (e.g. "Flight")
 *  @param phones Phones (e.g. "F L AY T")
 */
- (void)addWord:(NSString*)word phones:(NSString*)phones;

/*!
 *  Add multiple phones for the given word. Existing phones for the same words won't be deleted.
 *
 *  @param word         Word (e.g. "Flight")
 *  @param listOfPhones Array (e.g. ["F L AY T", "F L EY T"])
 */
- (void)addWord:(NSString*)word listOfPhones:(NSArray*)listOfPhones;

/*!
 *  Adds words and phones from dictionary.
 *
 *  NSDictionary Format:
 *
 *  @{
 *    @"word" : @[ @"phone a", @"phone b", @"phone c"],
 *    @"word b" : @[ @"phone ba", @"phone bb",]
 *  }
 *
 *  @param words dictionary
 */
- (void)addWords:(NSDictionary*)words;

/*!
 *  Removes the given word with all corresponding phones.
 *
 *  @param word The word to delete.
 */
- (void)removeWord:(NSString*)word;

/*!
 *  Remove the given phones from the given word. If there are no more phones for word, it will be removed.
 *
 *  @param phones phones
 *  @param word   word
 */
- (void)removePhones:(NSString*)phones ofWord:(NSString*)word;

/*!
 *  Adds all word from a dictionary.
 *
 *  @param dictionary Words/Phones.
 *
 *  NSDictionary Format:
 *
 *  @{
 *    @"word" : @[ @"phone a", @"phone b", @"phone c"],
 *    @"word b" : @[ @"phone ba", @"phone bb",]
 *  }
 */
- (void)addWordsFromDictionary:(NTPronunciationDictionary*)dictionary;

/*!
 *  Add parsed words from dictionary string.
 *
 *  String format:
 *
 *  [word]\t[phones]
 *  [wordb]\t[phonesb]
 *  [wordb](1)\t[phones2]
 *
 *  @param dictionaryString String to parse words from
 */
- (void)parseWordsFromDictionaryString:(NSString*)dictionaryString;

/*!
 *  Creates a dictionary string with the entries.
 *
 *  String format:
 *
 *  [word]\t[phones]
 *  [wordb]\t[phonesb]
 *  [wordb](1)\t[phones2]
 *
 *  @return dictionary string
 */
- (NSString*)createDictionaryString;

/*!
 *  Add words from a phonetic dictionary file.
 *
 *  File format:
 *
 *  [word]\t[phones]
 *  [wordb]\t[phonesb]
 *  [wordb](1)\t[phonesb2]
 *
 *  @param path The path to the file with the words to load.
 */
- (void)loadWordsFromFileAtPath:(NSString*)path;

/*!
 *  Writes entries to a file.
 *
 *  File format:
 *
 *  [word]\t[phones]
 *  [wordb]\t[phonesb]
 *  [wordb](1)\t[phonesb2]
 *
 *  @param path Path to write to.
 */
- (void)writeToFileAtPath:(NSString*)path;

/*!
 *  Returns all phones for the given word.
 *
 *  @param word word
 *
 *  @return array with phones. (e.g. [@"F L AY T", @"F L EY T"])
 */
- (NSArray*)phonesForWord:(NSString*)word;

@end
