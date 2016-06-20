//
//  NTSpeechGrammarRuleReferenceTest.m
//  NTPad
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2015 NT. All rights reserved.
//

#import <NTSpeechGrammars/NTSpeechGrammars.h>
#import <XCTest/XCTest.h>

@interface NTSpeechGrammarRuleReferenceTest : XCTestCase

@end

@implementation NTSpeechGrammarRuleReferenceTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testReferenceRuleNameWithGivenRule
{
    NTSpeechGrammarRuleReference* ref = [NTSpeechGrammarRuleReference new];
    ref.referencedRuleName = @"old";

    NTSpeechGrammarRule* rule = [NTSpeechGrammarRule new];
    rule.name = @"rulename";

    ref.referencedRule = rule;

    XCTAssertEqualObjects(@"rulename", ref.referencedRuleName);
}

- (void)testReferenceRuleNameWithoutGivenRule
{
    NTSpeechGrammarRuleReference* ref = [NTSpeechGrammarRuleReference new];
    ref.referencedRuleName = @"old";

    XCTAssertEqualObjects(@"old", ref.referencedRuleName);
}

@end
