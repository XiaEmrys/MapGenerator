//
//  MGMapSnowElement.m
//  MapGenerator
//
//  Created by Emrys on 2018/5/12.
//  Copyright © 2018年 Emrys. All rights reserved.
//

#import "MGMapSnowElement.h"
#import "MGMapProbability.h"

@interface MGMapSnowElement ()

// 北部概率模型
@property (nonatomic, strong) MGElementProbability *northProbability;
// 南部概率模型
@property (nonatomic, strong) MGElementProbability *southProbability;
// 西部概率模型
@property (nonatomic, strong) MGElementProbability *westProbability;
// 东部概率模型
@property (nonatomic, strong) MGElementProbability *eastProbability;

@end

@implementation MGMapSnowElement

+ (instancetype)elementWithProbability:(MGMapProbability *)probability {
    MGMapSnowElement *snowElement = [super elementWithProbability:probability];
    
    MGElementProbability *averageProbability = [MGElementProbability elementProbability];
    averageProbability = probability.averageProbability;
    
    //    -(((x-100)/sqrt(100))^2)+100
    averageProbability.snowProbability = -(NSInteger)pow(((probability.averageProbability.snowProbability-ProbabilityMax)/sqrt(ProbabilityMax)), 2)+ProbabilityMax;
    
    if (averageProbability.snowProbability >= ProbabilityMax-1) {
        averageProbability.snowProbability = ProbabilityMax-2;
    }
    
    //    (x/sqrt(100))^2
    averageProbability.grassProbability = (NSInteger)pow((probability.averageProbability.grassProbability/(NSInteger)sqrt(ProbabilityMax)), 2);
    if (averageProbability.grassProbability <= 2) {
        averageProbability.grassProbability = 2;
    }
    averageProbability.dirtProbability = (NSInteger)pow((probability.averageProbability.dirtProbability/(NSInteger)sqrt(ProbabilityMax)), 2);
    if (averageProbability.dirtProbability <= 2) {
        averageProbability.dirtProbability = 2;
    }
    averageProbability.sandProbability = (NSInteger)pow((probability.averageProbability.sandProbability/(NSInteger)sqrt(ProbabilityMax)), 2);
    if (averageProbability.sandProbability <= 2) {
        averageProbability.sandProbability = 2;
    }
    averageProbability.waterProbability = (NSInteger)pow((probability.averageProbability.waterProbability/(NSInteger)sqrt(ProbabilityMax)), 2);
    if (averageProbability.waterProbability <= 2) {
        averageProbability.waterProbability = 2;
    }
    
    if (nil == probability.northProbability) {
        snowElement.northProbability = averageProbability;
    }
    if (nil == probability.southProbability) {
        snowElement.southProbability = averageProbability;
    }
    if (nil == probability.westProbability) {
        snowElement.westProbability = averageProbability;
    }
    if (nil == probability.eastProbability) {
        snowElement.eastProbability = averageProbability;
    }
    
    return snowElement;
}

- (ElementType)elementType {
    return ElementTypeSnow;
}

- (NSUInteger)colorHexValue {
    return 0XFFFAFA;
}
@end
