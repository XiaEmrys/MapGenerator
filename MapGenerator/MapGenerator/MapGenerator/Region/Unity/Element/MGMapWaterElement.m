//
//  MGMapWaterElement.m
//  MapGenerator
//
//  Created by Emrys on 2018/5/12.
//  Copyright © 2018年 Emrys. All rights reserved.
//

#import "MGMapWaterElement.h"
#import "MGMapProbability.h"

@interface MGMapWaterElement ()

// 北部概率模型
@property (nonatomic, strong) MGElementProbability *northProbability;
// 南部概率模型
@property (nonatomic, strong) MGElementProbability *southProbability;
// 西部概率模型
@property (nonatomic, strong) MGElementProbability *westProbability;
// 东部概率模型
@property (nonatomic, strong) MGElementProbability *eastProbability;

// 上游方向
@property (nonatomic, assign) MapDirection upstreamDirection;
// 下游方向
@property (nonatomic, assign) MapDirection downstreamDirection;

@end

@implementation MGMapWaterElement

//+ (instancetype)elementWithProbability:(MGMapProbability *)probability {
//    MGMapWaterElement *waterElement = [super elementWithProbability:probability];
//    
//    MGElementProbability *averageProbability = [MGElementProbability elementProbability];
//    averageProbability = probability.averageProbability;
//    
//    //    -(((x-100)/sqrt(100))^2)+100
//    averageProbability.waterProbability = -(NSInteger)pow(((probability.averageProbability.waterProbability-ProbabilityMax)/sqrt(ProbabilityMax)), 2)+ProbabilityMax;
//    
//    if (averageProbability.waterProbability >= ProbabilityMax-1) {
//        averageProbability.waterProbability = ProbabilityMax-2;
//    }
//
//    //    (x/sqrt(100))^2
//    averageProbability.grassProbability = (NSInteger)pow((probability.averageProbability.grassProbability/(NSInteger)sqrt(ProbabilityMax)), 2);
//    if (averageProbability.grassProbability <= 2) {
//        averageProbability.grassProbability = 2;
//    }
//    averageProbability.dirtProbability = (NSInteger)pow((probability.averageProbability.dirtProbability/(NSInteger)sqrt(ProbabilityMax)), 2);
//    if (averageProbability.dirtProbability <= 2) {
//        averageProbability.dirtProbability = 2;
//    }
//    averageProbability.sandProbability = (NSInteger)pow((probability.averageProbability.sandProbability/(NSInteger)sqrt(ProbabilityMax)), 2);
//    if (averageProbability.sandProbability <= 2) {
//        averageProbability.sandProbability = 2;
//    }
//    averageProbability.snowProbability = (NSInteger)pow((probability.averageProbability.snowProbability/(NSInteger)sqrt(ProbabilityMax)), 2);
//    if (averageProbability.snowProbability <= 2) {
//        averageProbability.snowProbability = 2;
//    }
//    
//    if (nil == probability.northProbability) {
//        waterElement.southProbability = averageProbability;
//    }
//    if (nil == probability.southProbability) {
//        waterElement.northProbability = averageProbability;
//    }
//    if (nil == probability.westProbability) {
//        waterElement.eastProbability = averageProbability;
//    }
//    if (nil == probability.eastProbability) {
//        waterElement.westProbability = averageProbability;
//    }
//    
//    return waterElement;
//}

+ (instancetype)waterWithProbability:(MGMapProbability *)probability upstreamDirection:(MapDirection)upstreamDirection downstreamDirection:(MapDirection)downstreamDirection {
    
    MGMapWaterElement *waterElement = [super elementWithProbability:probability];
    
    waterElement.upstreamDirection = upstreamDirection;
    waterElement.downstreamDirection = downstreamDirection;
    
    MGElementProbability *averageProbability = [MGElementProbability elementProbability];
    averageProbability = probability.averageProbability;
    
    //    -(((x-100)/sqrt(100))^2)+100
    averageProbability.waterProbability = -(NSInteger)pow(((probability.averageProbability.waterProbability-ProbabilityMax)/sqrt(ProbabilityMax)), 2)+ProbabilityMax;
    
    if (averageProbability.waterProbability >= ProbabilityMax-1) {
        averageProbability.waterProbability = ProbabilityMax-2;
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
    averageProbability.snowProbability = (NSInteger)pow((probability.averageProbability.snowProbability/(NSInteger)sqrt(ProbabilityMax)), 2);
    if (averageProbability.snowProbability <= 2) {
        averageProbability.snowProbability = 2;
    }
    
//    if (nil == probability.northProbability) {
//        waterElement.northProbability = averageProbability;
        if ((MapDirectionNorth == upstreamDirection)
            ||(MapDirectionNorth == downstreamDirection)){
            waterElement.northProbability.waterProbability = ProbabilityMax;
            
            waterElement.northProbability.grassProbability = 0;
            waterElement.northProbability.dirtProbability = 0;
            waterElement.northProbability.sandProbability = 0;
            waterElement.northProbability.snowProbability = 0;
        }
//    }
//    if (nil == probability.southProbability) {
//        waterElement.southProbability = averageProbability;
        if ((MapDirectionSouth == upstreamDirection)
            ||(MapDirectionSouth == downstreamDirection)){
            waterElement.southProbability.waterProbability = ProbabilityMax;
            
            waterElement.southProbability.grassProbability = 0;
            waterElement.southProbability.dirtProbability = 0;
            waterElement.southProbability.sandProbability = 0;
            waterElement.southProbability.snowProbability = 0;
        }
//    }
//    if (nil == probability.westProbability) {
//        waterElement.westProbability = averageProbability;
        if ((MapDirectionWest == upstreamDirection)
            ||(MapDirectionWest == downstreamDirection)){
            waterElement.westProbability.waterProbability = ProbabilityMax;
            
            waterElement.westProbability.grassProbability = 0;
            waterElement.westProbability.dirtProbability = 0;
            waterElement.westProbability.sandProbability = 0;
            waterElement.westProbability.snowProbability = 0;
        }
//    }
//    if (nil == probability.eastProbability) {
//        waterElement.eastProbability = averageProbability;
        if ((MapDirectionEast == upstreamDirection)
            ||(MapDirectionEast == downstreamDirection)){
            waterElement.eastProbability.waterProbability = ProbabilityMax;
            
            waterElement.eastProbability.grassProbability = 0;
            waterElement.eastProbability.dirtProbability = 0;
            waterElement.eastProbability.sandProbability = 0;
            waterElement.eastProbability.snowProbability = 0;
        }
//    }
    
    return waterElement;
}

- (ElementType)elementType {
    return ElementTypeWater;
}

- (NSUInteger)colorHexValue {
    return 0X87CEEB;
}
@end
