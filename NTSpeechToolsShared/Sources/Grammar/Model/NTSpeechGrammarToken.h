//
//  NTSpeechGrammarToken.h
//  NTSpeechTools
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechGrammarElement.h"

@interface NTSpeechGrammarToken : NTSpeechGrammarElement

@property (nonatomic, strong) NSString* value;

- (instancetype)initWithValue:(NSString*)value;

- (instancetype)initWithValue:(NSString*)value weight:(int)weight;

+ (NTSpeechGrammarToken*)token:(NSString*)value;

+ (NTSpeechGrammarToken*)token:(NSString*)value weight:(int)weight;

@end
