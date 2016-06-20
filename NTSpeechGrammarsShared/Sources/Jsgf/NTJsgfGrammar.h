//
//  NTJsgfGrammar.h
//  NTSpeechGrammars
//
//  Created by Matthias Büchi on 16.09.15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechGrammar.h"

@interface NTJsgfGrammar : NSObject

#pragma mark - Serialization
+ (NSString*)serializeGrammar:(NTSpeechGrammar*)grammar;

+ (BOOL)writeGrammar:(NTSpeechGrammar*)grammar toFileAtPath:(NSString*)path;

#pragma mark - Parsing
+ (NTSpeechGrammar*)grammarFromString:(NSString*)value;

+ (NTSpeechGrammar*)grammarFromFileAtPath:(NSString*)path;

@end
