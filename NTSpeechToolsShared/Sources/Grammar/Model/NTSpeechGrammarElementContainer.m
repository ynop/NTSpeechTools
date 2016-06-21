//
//  NTSpeechGrammarElementContainer.m
//  NTSpeechTools
//
//  Created by Matthias Büchi on 05/11/15.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechGrammarElementContainer.h"
#import "NTSpeechGrammarToken.h"

@interface NTSpeechGrammarElementContainer ()

@property (nonatomic, strong) NSMutableArray* elementsInternal;

@end

@implementation NTSpeechGrammarElementContainer

- (instancetype)init
{
    return [self initWithElements:nil];
}

- (instancetype)initWithTokens:(NSArray*)tokens
{
    NSMutableArray* elements = [NSMutableArray array];

    for (NSString* token in tokens) {
        [elements addObject:[NTSpeechGrammarToken token:token]];
    }

    return [self initWithElements:elements];
}

- (instancetype)initWithElements:(NSArray*)elements
{
    self = [super init];
    if (self) {
        _elementsInternal = [NSMutableArray array];

        for (id element in elements) {
            [self addElement:element];
        }
    }
    return self;
}

- (void)addElement:(id)element
{
    if ([element isKindOfClass:[NTSpeechGrammarElement class]]) {
        [self.elementsInternal addObject:element];
    }
    else if ([element isKindOfClass:[NSString class]]) {
        [self.elementsInternal addObject:[NTSpeechGrammarToken token:element]];
    }
}

- (void)addFrontElement:(id)element
{
    if ([element isKindOfClass:[NTSpeechGrammarElement class]]) {
        [self.elementsInternal insertObject:element atIndex:0];
    }
    else if ([element isKindOfClass:[NSString class]]) {
        [self.elementsInternal insertObject:[NTSpeechGrammarToken token:element] atIndex:0];
    }
}

- (void)removeElement:(NTSpeechGrammarElement*)element
{
    if ([element isKindOfClass:[NTSpeechGrammarElement class]]) {
        [self.elementsInternal removeObject:element];
    }
    else if ([element isKindOfClass:[NSString class]]) {
        NTSpeechGrammarElement* e = nil;

        for (NTSpeechGrammarElement* containedElement in self.elementsInternal) {
            if ([containedElement isKindOfClass:[NTSpeechGrammarToken class]]) {
                NTSpeechGrammarToken* token = (NTSpeechGrammarToken*)containedElement;

                if ([token.value isEqualToString:(NSString*)element]) {
                    e = element;
                }
            }
        }

        [self removeElement:e];
    }
}

- (void)removeAllElements
{
    [self.elementsInternal removeAllObjects];
}

- (void)addToken:(NSString*)value
{
    [self.elementsInternal addObject:[NTSpeechGrammarToken token:value]];
}

- (NSArray*)elements
{
    return [NSArray arrayWithArray:self.elementsInternal];
}

@end
