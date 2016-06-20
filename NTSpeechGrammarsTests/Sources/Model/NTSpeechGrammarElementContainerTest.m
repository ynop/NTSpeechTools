//
//  NTSpeechGrammarElementContainerTest.m
//  NTPad
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2015 NT. All rights reserved.
//

#import <NTSpeechGrammars/NTSpeechGrammars.h>
#import <XCTest/XCTest.h>

@interface NTSpeechGrammarElementContainerTest : XCTestCase

@end

@implementation NTSpeechGrammarElementContainerTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testAddElement
{
    NTSpeechGrammarElementContainer* c = [NTSpeechGrammarElementContainer new];
    NTSpeechGrammarElement* e = [NTSpeechGrammarElement new];

    [c addElement:e];

    XCTAssertEqual(1, c.elements.count);
}

- (void)testRemoveElement
{
    NTSpeechGrammarElementContainer* c = [NTSpeechGrammarElementContainer new];
    NTSpeechGrammarElement* e = [NTSpeechGrammarElement new];

    [c addElement:e];
    XCTAssertEqual(1, c.elements.count);

    [c removeElement:e];

    XCTAssertEqual(0, c.elements.count);
}

@end
