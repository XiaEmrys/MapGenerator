//
//  MGMapDirtElement.m
//  MapGenerator
//
//  Created by Emrys on 2018/5/12.
//  Copyright © 2018年 Emrys. All rights reserved.
//

#import "MGMapDirtElement.h"
#import "MGMapProbability.h"

@interface MGMapDirtElement ()

// 北部概率模型
@property (nonatomic, strong) MGElementProbability *northProbability;
// 南部概率模型
@property (nonatomic, strong) MGElementProbability *southProbability;
// 西部概率模型
@property (nonatomic, strong) MGElementProbability *westProbability;
// 东部概率模型
@property (nonatomic, strong) MGElementProbability *eastProbability;


@end

@implementation MGMapDirtElement

+ (instancetype)elementWithProbability:(MGMapProbability *)probability {
    
    MGMapDirtElement *dirtElement = [super elementWithProbability:probability];
    
    MGElementProbability *averageProbability = [MGElementProbability elementProbability];
    averageProbability = probability.averageProbability;
    
    //    -(((x-100)/sqrt(100))^2)+100
    averageProbability.dirtProbability = -(NSInteger)pow(((probability.averageProbability.dirtProbability-ProbabilityMax)/sqrt(ProbabilityMax)), 2)+ProbabilityMax;
    
    if (averageProbability.dirtProbability >= ProbabilityMax-1) {
        averageProbability.dirtProbability = ProbabilityMax-2;
    }
    
    //    (x/sqrt(100))^2
    averageProbability.grassProbability = (NSInteger)pow((probability.averageProbability.grassProbability/(NSInteger)sqrt(ProbabilityMax)), 2);
    if (averageProbability.grassProbability <= 2) {
        averageProbability.grassProbability = 2;
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
        dirtElement.southProbability = averageProbability;
    }
    if (nil == probability.southProbability) {
        dirtElement.northProbability = averageProbability;
    }
    if (nil == probability.westProbability) {
        dirtElement.eastProbability = averageProbability;
    }
    if (nil == probability.eastProbability) {
        dirtElement.westProbability = averageProbability;
    }
    
    return dirtElement;
}

- (ElementType)elementType {
    return ElementTypeDirt;
}

- (NSUInteger)colorHexValue {
    return 0X734A12;
}
@end
