//
//  NTSpeechGrammarElementTest.m
//  NTPad
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2015 NT. All rights reserved.
//

#import <NTSpeechGrammars/NTSpeechGrammars.h>
#import <XCTest/XCTest.h>

@interface NTSpeechGrammarElementTest : XCTestCase

@end

@implementation NTSpeechGrammarElementTest

- (void)setUp
{
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testSetMinRepeatShouldSucceed
{
    NTSpeechGrammarElement* e = [NTSpeechGrammarElement new];
    e.maxRepeat = 10;
    e.minRepeat = 9;

    XCTAssertEqual(9, e.minRepeat);
}

- (void)testSetMinRepeatGreaterThanMaxRepeat
{
    NTSpeechGrammarElement* e = [NTSpeechGrammarElement new];
    e.maxRepeat = 2;
    e.minRepeat = 3;

    XCTAssertEqual(2, e.minRepeat);
}

- (void)testSetMaxRepeatShouldSucceed
{
    NTSpeechGrammarElement* e = [NTSpeechGrammarElement new];
    e.maxRepeat = 2;

    XCTAssertEqual(2, e.maxRepeat);
}

- (void)testSetMaxRepeatSmallerThanMinRepeat
{
    NTSpeechGrammarElement* e = [NTSpeechGrammarElement new];
    e.maxRepeat = 2;
    e.minRepeat = 2;
    e.maxRepeat = 1;

    XCTAssertEqual(2, e.maxRepeat);
}

- (void)testAddTag
{
    NTSpeechGrammarElement* e = [NTSpeechGrammarElement new];

    [e addTag:@"Some"];
    [e addTag:@"Thing"];

    XCTAssertEqual(2, e.tags.count);
}

- (void)testRemoveTag
{
    NTSpeechGrammarElement* e = [NTSpeechGrammarElement new];

    [e addTag:@"Some"];
    [e addTag:@"Thing"];
    [e removeTag:@"Some"];

    XCTAssertEqual(1, e.tags.count);
}

- (void)testRemoveAllTag
{
    NTSpeechGrammarElement* e = [NTSpeechGrammarElement new];

    [e addTag:@"Some"];
    [e addTag:@"Thing"];
    [e removeAllTags];

    XCTAssertEqual(0, e.tags.count);
}

@end
