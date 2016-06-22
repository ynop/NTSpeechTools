//
//  NTSpeechTools.h
//  NTSpeechTools
//
//  Created by Matthias Büchi on 17/06/16.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for NTSpeechTools.
FOUNDATION_EXPORT double NTSpeechToolsVersionNumber;

//! Project version string for NTSpeechTools.
FOUNDATION_EXPORT const unsigned char NTSpeechToolsVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <NTSpeechTools/PublicHeader.h>

// ########################################################################
// DICTIONARY
// ########################################################################
#import <NTSpeechTools/NTPronunciationDictionary.h>

// ########################################################################
// GRAMMAR
// ########################################################################

// MODEL
#import <NTSpeechTools/NTSpeechGrammar.h>
#import <NTSpeechTools/NTSpeechGrammarAlternative.h>
#import <NTSpeechTools/NTSpeechGrammarElement.h>
#import <NTSpeechTools/NTSpeechGrammarElementContainer.h>
#import <NTSpeechTools/NTSpeechGrammarGroup.h>
#import <NTSpeechTools/NTSpeechGrammarRule.h>
#import <NTSpeechTools/NTSpeechGrammarRuleReference.h>
#import <NTSpeechTools/NTSpeechGrammarSequence.h>
#import <NTSpeechTools/NTSpeechGrammarToken.h>

// JSGF
#import <NTSpeechTools/NTJsgfGrammar.h>

// ########################################################################
// SEARCH
// ########################################################################
#import <NTSpeechTools/NTGrammarSearch.h>
#import <NTSpeechTools/NTJsgfFileSearch.h>
#import <NTSpeechTools/NTKeywordSpottingSearch.h>
#import <NTSpeechTools/NTNGramFileSearch.h>
#import <NTSpeechTools/NTSpeechSearch.h>
