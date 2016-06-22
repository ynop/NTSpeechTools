//
//  NTGrammarSearch.h
//  NTSpeechTools
//
//  Created by Matthias Büchi on 21/06/16.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import "NTSpeechGrammar.h"
#import "NTSpeechSearch.h"

/*!
 *  A search based on a grammar.
 */
@interface NTGrammarSearch : NTSpeechSearch

/*!
 *  Grammar
 */
@property (nonatomic, strong, readonly) NTSpeechGrammar* grammar;

/*!
 *  Create new search with name and grammar.
 *
 *  @param name    name
 *  @param grammar grammar
 *
 *  @return instance
 */
- (instancetype)initWithName:(NSString*)name grammar:(NTSpeechGrammar*)grammar;

#pragma mark - Convencience Constructors
/*!
 *  Create a search with a grammar.
 *
 *  @param name    Name
 *  @param grammar Grammar
 *
 *  @return instance
 */
+ (NTGrammarSearch*)searchWithName:(NSString*)name grammar:(NTSpeechGrammar*)grammar;

@end
