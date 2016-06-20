//
//  NTSpeechGrammarElementContainer.h
//  NTSpeechGrammars
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechGrammarElement.h"

@interface NTSpeechGrammarElementContainer : NTSpeechGrammarElement

@property (nonatomic, strong, readonly) NSArray* elements;

- (instancetype)initWithTokens:(NSArray*)tokens;

- (instancetype)initWithElements:(NSArray*)elements;

- (void)addElement:(NTSpeechGrammarElement*)element;

- (void)addFrontElement:(NTSpeechGrammarElement*)element;

- (void)removeElement:(NTSpeechGrammarElement*)element;

- (void)removeAllElements;

- (void)addToken:(NSString*)value;

@end
