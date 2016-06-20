//
//  NTJsgfGrammar.h
//  NTSpeechGrammars
//
//  Created by Matthias Büchi on 16.09.15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "Foundation/Foundation.h"

#import "NTSpeechGrammar.h"

@interface NTJsgfGrammar : NTSpeechGrammar

@property (nonatomic, strong) NSString* version;
@property (nonatomic, strong) NSString* charset;
@property (nonatomic, strong) NSString* language;

+ (NTJsgfGrammar*)jsgfGrammarWithRootRule:(NTSpeechGrammarRule*)rule;

+ (NTJsgfGrammar*)jsgfGrammarFromString:(NSString*)value;

+ (NTJsgfGrammar*)jsgfGrammarFromFile:(NSString*)path;

@end
