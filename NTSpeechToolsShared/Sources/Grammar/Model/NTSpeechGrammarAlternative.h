//
//  NTSpeechGrammarAlternative.h
//  NTSpeechTools
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechGrammarElementContainer.h"

@interface NTSpeechGrammarAlternative : NTSpeechGrammarElementContainer

+ (NTSpeechGrammarAlternative*)alternativeWithElements:(NSArray*)elements;

+ (NTSpeechGrammarAlternative*)alternativeWithTokens:(NSArray*)tokens;

@end
