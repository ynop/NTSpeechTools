//
//  NTHypothesis.h
//  NTSpeechTools
//
//  Created by Matthias Büchi on 22/06/16.
//  Copyright © 2016 ZHAW Institute of Applied Information Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NTHypothesis : NSObject

/*!
 *  The recognized text
 */
@property (nonatomic, strong, readonly) NSString* value;

/*!
 *  The path score (def 0.0)
 */
@property (nonatomic, readonly) double pathScore;

/*!
 *  The posterior probability (def 0.0)
 */
@property (nonatomic, readonly) double posteriorProbability;

- (instancetype)initWithValue:(NSString*)value;

- (instancetype)initWithValue:(NSString*)value score:(double)score;

- (instancetype)initWithValue:(NSString*)value score:(double)score probability:(double)probability;

#pragma mark - Convinience Constructors
+ (NTHypothesis*)hypothesis:(NSString*)value;

+ (NTHypothesis*)hypothesis:(NSString*)value score:(double)score;

+ (NTHypothesis*)hypothesis:(NSString*)value score:(double)score probability:(double)probability;

@end
