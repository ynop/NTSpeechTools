//
//  NTSpeechGrammarAlternative.m
//  NTSpeechTools
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechGrammarAlternative.h"

@implementation NTSpeechGrammarAlternative

+ (NTSpeechGrammarAlternative*)alternativeWithElements:(NSArray*)elements
{
    return [[NTSpeechGrammarAlternative alloc] initWithElements:elements];
}

+ (NTSpeechGrammarAlternative*)alternativeWithTokens:(NSArray*)tokens
{
    return [[NTSpeechGrammarAlternative alloc] initWithTokens:tokens];
}
@end
