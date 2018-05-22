//
//  MGMapSandElement.m
//  MapGenerator
//
//  Created by Emrys on 2018/5/12.
//  Copyright © 2018年 Emrys. All rights reserved.
//

#import "MGMapSandElement.h"
#import "MGMapProbability.h"

@interface MGMapSandElement ()

// 北部概率模型
@property (nonatomic, strong) MGElementProbability *northProbability;
// 南部概率模型
@property (nonatomic, strong) MGElementProbability *southProbability;
// 西部概率模型
@property (nonatomic, strong) MGElementProbability *westProbability;
// 东部概率模型
@property (nonatomic, strong) MGElementProbability *eastProbability;

@end

@implementation MGMapSandElement

+ (instancetype)elementWithProbability:(MGMapProbability *)probability {
    MGMapSandElement *sandElement = [super elementWithProbability:probability];
    
    MGElementProbability *averageProbability = [MGElementProbability elementProbability];
    averageProbability = probability.averageProbability;
    
    //    -(((x-100)/sqrt(100))^2)+100
    averageProbability.sandProbability = -(NSInteger)pow(((probability.averageProbability.sandProbability-ProbabilityMax)/sqrt(ProbabilityMax)), 2)+ProbabilityMax;
    
    if (averageProbability.sandProbability >= ProbabilityMax-1) {
        averageProbability.sandProbability = ProbabilityMax-2;
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
    averageProbability.waterProbability = (NSInteger)pow((probability.averageProbability.waterProbability/(NSInteger)sqrt(ProbabilityMax)), 2);
    if (averageProbability.waterProbability <= 2) {
        averageProbability.waterProbability = 2;
    }
    averageProbability.snowProbability = (NSInteger)pow((probability.averageProbability.snowProbability/(NSInteger)sqrt(ProbabilityMax)), 2);
    if (averageProbability.snowProbability <= 2) {
        averageProbability.snowProbability = 2;
    }
    
    if (nil == probability.northProbability) {
        sandElement.southProbability = averageProbability;
    }
    if (nil == probability.southProbability) {
        sandElement.northProbability = averageProbability;
    }
    if (nil == probability.westProbability) {
        sandElement.eastProbability = averageProbability;
    }
    if (nil == probability.eastProbability) {
        sandElement.westProbability = averageProbability;
    }
    
    return sandElement;
}

- (ElementType)elementType {
    return ElementTypeSand;
}

- (NSUInteger)colorHexValue {
    return 0XF4A460;
}
@end
