//
//  NTSpeechGrammarTest.m
//  NTPad
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2015 NT. All rights reserved.
//

#import <NTSpeechTools/NTSpeechTools.h>
#import <XCTest/XCTest.h>

@interface NTSpeechGrammarTest : XCTestCase

@end

@implementation NTSpeechGrammarTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testAddRule
{
    NTSpeechGrammar* g = [NTSpeechGrammar new];
    NTSpeechGrammarRule* rule = [NTSpeechGrammarRule new];

    [g addRule:rule];

    XCTAssertEqual(1, g.rules.count);
}

- (void)testRemoveRule
{
    NTSpeechGrammar* g = [NTSpeechGrammar new];
    NTSpeechGrammarRule* rule = [NTSpeechGrammarRule new];

    [g addRule:rule];
    XCTAssertEqual(1, g.rules.count);

    [g removeRule:rule];

    XCTAssertEqual(0, g.rules.count);
}

@end
