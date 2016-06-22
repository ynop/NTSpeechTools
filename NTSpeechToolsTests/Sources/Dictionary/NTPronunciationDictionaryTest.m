//
//  NTPronunciationDictionaryTest.m
//  NTPad
//
//  Created by Matthias Büchi on 04/11/15.
//  Copyright © 2015 NT. All rights reserved.
//

#import <NTSpeechTools/NTSpeechTools.h>
#import <XCTest/XCTest.h>

@interface NTPronunciationDictionaryTest : XCTestCase

@end

@implementation NTPronunciationDictionaryTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

//
//  - (void)addWord:(NSString*)word phones:(NSString*)phones
//
- (void)testAddWordPhonesNonExistingWord
{

    NSString* t = @"1e-80";
    NSNumber *number = @([t doubleValue]);

    NSLog(@"%@", number);

    NTPronunciationDictionary* dic = [NTPronunciationDictionary new];

    [dic addWord:@"Flight" phones:@"F L AY T"];

    NSArray* phones = dic.entries[@"FLIGHT"];

    XCTAssertNotNil(phones);
    XCTAssertEqual(1, phones.count);
    XCTAssertEqualObjects(@"F L AY T", phones[0]);
}

- (void)testAddWordPhonesExistingWord
{
    NTPronunciationDictionary* dic = [NTPronunciationDictionary new];

    [dic addWord:@"Flight" phones:@"F L AY T"];
    [dic addWord:@"Flight" phones:@"F L EY T"];

    NSArray* phones = dic.entries[@"FLIGHT"];

    XCTAssertNotNil(phones);
    XCTAssertEqual(2, phones.count);
    XCTAssertEqualObjects(@"F L AY T", phones[0]);
    XCTAssertEqualObjects(@"F L EY T", phones[1]);
}

- (void)testAddWordPhonesExistingWordAndPhone
{
    NTPronunciationDictionary* dic = [NTPronunciationDictionary new];

    [dic addWord:@"Flight" phones:@"F L AY T"];
    [dic addWord:@"Flight" phones:@"F L aY T"];

    NSArray* phones = dic.entries[@"FLIGHT"];

    XCTAssertNotNil(phones);
    XCTAssertEqual(1, phones.count);
    XCTAssertEqualObjects(@"F L AY T", phones[0]);
}

//
//  - (void)addWord:(NSString *)word listOfPhones:(NSArray *)listOfPhones
//
- (void)testAddWordListOfPhonesNonExistingWord
{
    NTPronunciationDictionary* dic = [NTPronunciationDictionary new];

    [dic addWord:@"Flight" listOfPhones:@[ @"F L AY T", @"F L eY T" ]];

    NSArray* phones = dic.entries[@"FLIGHT"];

    XCTAssertNotNil(phones);
    XCTAssertEqual(2, phones.count);
    XCTAssertEqualObjects(@"F L AY T", phones[0]);
    XCTAssertEqualObjects(@"F L EY T", phones[1]);
}

- (void)testAddWordListOfPhonesEmptyList
{
    NTPronunciationDictionary* dic = [NTPronunciationDictionary new];

    [dic addWord:@"Flight" listOfPhones:@[]];

    NSArray* phones = dic.entries[@"FLIGHT"];

    XCTAssertNil(phones);
}

//
//  - (void)addWords:(NSDictionary*)words
//
- (void)testAddWords
{
    NTPronunciationDictionary* dic = [NTPronunciationDictionary new];

    [dic addWords:@{
        @"Flight" : @[ @"F L AY T", @"F L eY T" ],
        @"AC" : @[ @"EY S IY" ]
    }];

    NSArray* flightPhones = dic.entries[@"FLIGHT"];
    NSArray* acPhones = dic.entries[@"AC"];

    XCTAssertEqual(2, dic.entries.count);
    XCTAssertNotNil(flightPhones);
    XCTAssertNotNil(acPhones);
    XCTAssertEqual(2, flightPhones.count);
    XCTAssertEqual(1, acPhones.count);
    XCTAssertEqualObjects(@"F L AY T", flightPhones[0]);
    XCTAssertEqualObjects(@"F L EY T", flightPhones[1]);
    XCTAssertEqualObjects(@"EY S IY", acPhones[0]);
}

//
// - (void)removeWord:(NSString *)word
//
- (void)testRemoveWord
{
    NTPronunciationDictionary* dic = [NTPronunciationDictionary new];

    [dic addWords:@{
        @"Flight" : @[ @"F L AY T", @"F L eY T" ],
        @"AC" : @[ @"EY S IY" ]
    }];

    [dic removeWord:@"FlighT"];

    XCTAssertEqual(1, dic.entries.count);
}

//
// - (void)removePhones:(NSString*)phones ofWord:(NSString*)word
//
- (void)testRemovePhonesOfWord
{
    NTPronunciationDictionary* dic = [NTPronunciationDictionary new];

    [dic addWords:@{
        @"Flight" : @[ @"F L AY T", @"F L eY T" ],
        @"AC" : @[ @"EY S IY" ]
    }];

    [dic removePhones:@"F L ey t" ofWord:@"FlighT"];

    NSArray* flightPhones = dic.entries[@"FLIGHT"];

    XCTAssertEqual(1, flightPhones.count);
}

//
//  - (void)addWordsFromDictionary:(NTPronunciationDictionary*)dictionary
//
- (void)testAddWordsFromDictionary
{
    NTPronunciationDictionary* dic = [NTPronunciationDictionary new];

    [dic addWords:@{
        @"Flight" : @[ @"F L AY T", @"F L eY T" ],
        @"AC" : @[ @"EY S IY" ]
    }];

    NTPronunciationDictionary* otherDic = [NTPronunciationDictionary new];

    [otherDic addWords:@{
        @"Flight" : @[ @"F L AY Ay T" ],
        @"ATC" : @[ @"AH T IY S IY" ]
    }];

    [dic addWordsFromDictionary:otherDic];

    NSArray* flightPhones = dic.entries[@"FLIGHT"];
    NSArray* acPhones = dic.entries[@"AC"];
    NSArray* atcPhones = dic.entries[@"ATC"];

    XCTAssertEqual(3, dic.entries.count);
    XCTAssertNotNil(flightPhones);
    XCTAssertNotNil(acPhones);
    XCTAssertNotNil(atcPhones);
    XCTAssertEqual(3, flightPhones.count);
    XCTAssertEqual(1, acPhones.count);
    XCTAssertEqual(1, atcPhones.count);
    XCTAssertEqualObjects(@"F L AY T", flightPhones[0]);
    XCTAssertEqualObjects(@"F L EY T", flightPhones[1]);
    XCTAssertEqualObjects(@"F L AY AY T", flightPhones[2]);
    XCTAssertEqualObjects(@"EY S IY", acPhones[0]);
    XCTAssertEqualObjects(@"AH T IY S IY", atcPhones[0]);
}

//
//  - (void)parseWordsFromDictionaryString:(NSString*)dictionaryString
//
- (void)testParseWordsFromDictionaryString
{
    NTPronunciationDictionary* dic = [NTPronunciationDictionary new];

    NSString* dicString = @"Flight\t F L AY T\nFlight (1)\t  F L EY T";

    [dic parseWordsFromDictionaryString:dicString];

    NSArray* phones = dic.entries[@"FLIGHT"];

    XCTAssertEqual(1, dic.entries.count);
    XCTAssertNotNil(phones);
    XCTAssertEqual(2, phones.count);
    XCTAssertEqualObjects(@"F L AY T", phones[0]);
}

//
//  - (NSString*)createDictionaryString;
//
- (void)testCreateDictionaryString
{
    NTPronunciationDictionary* dic = [NTPronunciationDictionary new];

    [dic addWord:@"Flight" phones:@"F L AY T"];
    [dic addWord:@"Flight" phones:@"F L EY T"];

    NSString* dicString = [dic createDictionaryString];

    XCTAssertEqualObjects(@"FLIGHT\tF L AY T\nFLIGHT(1)\tF L EY T", dicString);
}

//
//  - (void)loadWordsFromFileAtPath:(NSString*)path
//
- (void)testLoadWordsFromFileAtPath
{
    NTPronunciationDictionary* dic = [NTPronunciationDictionary new];

    NSString* filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"test_dictionary" ofType:@"dic"];

    XCTAssertNotNil(filePath, @"Test file not found");

    [dic loadWordsFromFileAtPath:filePath];

    NSArray* phoneList = [dic phonesForWord:@"flight"];

    XCTAssertEqual(2, phoneList.count);
    XCTAssertEqualObjects(@"F L AY T", phoneList[0]);
    XCTAssertEqualObjects(@"F L EY T", phoneList[1]);
}

//
//  - (NSArray*)phonesForWord:(NSString*)word
//
- (void)testPhonesForWord
{
    NTPronunciationDictionary* dic = [NTPronunciationDictionary new];

    [dic addWords:@{
        @"Flight" : @[ @"F L AY T", @"F L eY T" ],
        @"AC" : @[ @"EY S IY" ]
    }];

    NSArray* phoneList = [dic phonesForWord:@"flight"];

    XCTAssertEqual(2, phoneList.count);
    XCTAssertEqualObjects(@"F L AY T", phoneList[0]);
    XCTAssertEqualObjects(@"F L EY T", phoneList[1]);
}

@end
