//
//  NTPronunciationDictionary.m
//  NTSpeechTools
//
//  Created by Matthias Büchi on 16.09.15.
//  Copyright (c) 2015 NT. All rights reserved.
//

#import "NTPronunciationDictionary.h"

@interface NTPronunciationDictionary ()

@property (nonatomic, strong) NSMutableDictionary* internalPhones;

@end

@implementation NTPronunciationDictionary

- (instancetype)init
{
    self = [super init];
    if (self) {
        _internalPhones = [NSMutableDictionary dictionary];
    }
    return self;
}

- (instancetype)initWithName:(NSString*)name
{
    NTPronunciationDictionary* dic = [self init];
    dic.name = name;

    return dic;
}

- (instancetype)initWithName:(NSString*)name fileAtPath:(NSString*)path
{
    NTPronunciationDictionary* dic = [self initWithName:name];
    [dic loadWordsFromFileAtPath:path];

    return dic;
}

- (instancetype)initWithName:(NSString*)name dictionaryString:(NSString*)dictionaryString
{
    NTPronunciationDictionary* dic = [self initWithName:name];
    [dic parseWordsFromDictionaryString:dictionaryString];

    return dic;
}

- (instancetype)initWithName:(NSString*)name words:(NSDictionary*)words
{
    NTPronunciationDictionary* dic = [self initWithName:name];
    [dic addWords:words];

    return dic;
}

- (void)addWord:(NSString*)word phones:(NSString*)phones
{
    NSMutableArray* phoneList = nil;

    if ([self.internalPhones.allKeys containsObject:word.uppercaseString]) {
        phoneList = self.internalPhones[word.uppercaseString];
    }
    else {
        phoneList = [NSMutableArray array];
        [self.internalPhones setObject:phoneList forKey:word.uppercaseString];
    }

    if (![phoneList containsObject:phones.uppercaseString]) {
        [phoneList addObject:phones.uppercaseString];
    }
}

- (void)addWord:(NSString*)word listOfPhones:(NSArray*)listOfPhones
{
    for (NSString* phones in listOfPhones) {
        [self addWord:word phones:phones];
    }
}

- (void)addWords:(NSDictionary*)words
{
    for (NSString* word in words.allKeys) {
        [self addWord:word listOfPhones:words[word]];
    }
}

- (void)addWordsFromDictionary:(NTPronunciationDictionary*)dictionary
{
    for (NSString* word in dictionary.allWords) {
        [self addWord:word listOfPhones:[dictionary phonesForWord:word]];
    }
}

- (void)removeWord:(NSString*)word
{
    [self.internalPhones removeObjectForKey:word.uppercaseString];
}

- (void)removePhones:(NSString*)phones ofWord:(NSString*)word
{
    NSMutableArray* phoneList = self.internalPhones[word.uppercaseString];

    if (phoneList) {
        [phoneList removeObject:phones.uppercaseString];
    }
}

- (void)parseWordsFromDictionaryString:(NSString*)dictionaryString
{
    NSArray* lines = [dictionaryString componentsSeparatedByString:@"\n"];

    for (NSString* line in lines) {
        NSArray* parts = nil;

        if ([line containsString:@"\t"]) {
            parts = [line componentsSeparatedByString:@"\t"];
        }
        else {
            NSRange range = [line rangeOfString:@" "];

            if (range.location != NSNotFound) {
                parts = @[
                    [line substringToIndex:range.location],
                    [line substringFromIndex:range.location + range.length]
                ];
            }
        }

        if (parts.count > 1) {
            NSArray* wordParts = [parts[0] componentsSeparatedByString:@"("];

            NSString* word = [wordParts[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].uppercaseString;

            NSString* phones = [parts[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].uppercaseString;

            [self addWord:word phones:phones];
        }
    }
}

- (NSString*)createDictionaryString
{
    NSMutableArray* lines = [NSMutableArray array];

    for (NSString* word in self.allWords) {
        NSArray* phoneList = [self phonesForWord:word];

        for (int i = 0; i < phoneList.count; i++) {
            NSString* line = nil;
            if (i == 0) {
                line = [NSString stringWithFormat:@"%@\t%@", word, phoneList[i]];
            }
            else {
                line = [NSString stringWithFormat:@"%@(%i)\t%@", word, i, phoneList[i]];
            }
            [lines addObject:line];
        }
    }

    return [lines componentsJoinedByString:@"\n"];
}

- (void)loadWordsFromFileAtPath:(NSString*)path
{
    NSError* error = nil;

    NSString* fileContent = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];

    if (error) {
        NSLog(@"Failed to open file to read words with reason %@.", error);
    }
    else {
        [self parseWordsFromDictionaryString:fileContent];
    }
}

- (void)writeToFileAtPath:(NSString*)path
{
    NSError* error = nil;

    NSString* dicString = [self createDictionaryString];
    [dicString writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];

    if (error) {
        NSLog(@"Failed to write dictionary to file with reason %@.", error);
    }
}

- (NSArray*)phonesForWord:(NSString*)word
{
    return [NSArray arrayWithArray:self.internalPhones[word.uppercaseString]];
}

- (NSDictionary*)entries
{
    return [NSDictionary dictionaryWithDictionary:self.internalPhones];
}

- (NSArray*)allWords
{
    return self.internalPhones.allKeys;
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone*)zone
{
    NTPronunciationDictionary* copy = [[NTPronunciationDictionary alloc] initWithName:self.name];

    [copy addWordsFromDictionary:self];

    return copy;
}

@end
