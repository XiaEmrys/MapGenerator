//
//  MGMapGrassElement.m
//  MapGenerator
//
//  Created by Emrys on 2018/5/9.
//  Copyright © 2018年 Emrys. All rights reserved.
//

#import "MGMapGrassElement.h"
#import "MGMapProbability.h"

@interface MGMapGrassElement ()

// 北部概率模型
@property (nonatomic, strong) MGElementProbability *northProbability;
// 南部概率模型
@property (nonatomic, strong) MGElementProbability *southProbability;
// 西部概率模型
@property (nonatomic, strong) MGElementProbability *westProbability;
// 东部概率模型
@property (nonatomic, strong) MGElementProbability *eastProbability;


@end

@implementation MGMapGrassElement

+ (instancetype)elementWithProbability:(MGMapProbability *)probability {
    
    MGMapGrassElement *grassElement = [super elementWithProbability:probability];
    
    MGElementProbability *averageProbability = [MGElementProbability elementProbability];
    averageProbability = probability.averageProbability;
    
//    -(((x-100)/sqrt(100))^2)+100
    averageProbability.grassProbability = -(NSInteger)pow(((probability.averageProbability.grassProbability-ProbabilityMax)/sqrt(ProbabilityMax)), 2)+ProbabilityMax;
    
    if (averageProbability.grassProbability >= ProbabilityMax-1) {
        averageProbability.grassProbability = ProbabilityMax-2;
    }
    
//    (x/sqrt(100))^2
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
    averageProbability.snowProbability = (NSInteger)pow((probability.averageProbability.snowProbability/(NSInteger)sqrt(ProbabilityMax)), 2);
    if (averageProbability.snowProbability <= 2) {
        averageProbability.snowProbability = 2;
    }

    if (nil == probability.northProbability) {
        grassElement.southProbability = averageProbability;
    }
    if (nil == probability.southProbability) {
        grassElement.northProbability = averageProbability;
    }
    if (nil == probability.westProbability) {
        grassElement.eastProbability = averageProbability;
    }
    if (nil == probability.eastProbability) {
        grassElement.westProbability = averageProbability;
    }
    
    return grassElement;
}

- (ElementType)elementType {
    return ElementTypeGrass;
}

- (NSUInteger)colorHexValue {
    return 0X7CFC00;
}

@end
