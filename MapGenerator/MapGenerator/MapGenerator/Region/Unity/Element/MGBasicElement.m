//
//  MGBasicElement.m
//  MapGenerator
//
//  Created by Emrys on 2018/5/8.
//  Copyright © 2018年 Emrys. All rights reserved.
//

#import "MGBasicElement.h"
#import "MGMapProbability.h"

#import "MGMapGrassElement.h"

static NSString *datasFilePath = @"/Users/emrys/Documents/MapGenerator/TestDatas";

@interface MGBasicElement ()

@property (nonatomic, assign) CGFloat latitude;     // 纬度
@property (nonatomic, assign) CGFloat longitude;    // 经度



@end

@implementation MGBasicElement

+ (instancetype)mapWithCoordinate:(CGPoint)coordinate {
    
    // 先在本地存储取数据，没有的时候创建
    // 假设有，直接取出来
    
    // 假设没有
            // 取四个方向的元素的概率对象
                // 假设四个方向都没有，概率对象传空
    
    return [self mapWithCoordinate:coordinate probability:nil];
    
    return nil;
}
+ (instancetype)mapWithCoordinate:(CGPoint)coordinate probability:(MGMapProbability *)probability {
    
    
    
    if (nil == probability) {
        return [MGMapGrassElement mapWithCoordinate:coordinate probability:probability];
    }
    
    ElementType curType = [self typeWithProbability:probability];

    
    MGBasicElement *element;
    
    element = [MGMapGrassElement mapWithCoordinate:coordinate probability:probability];
    // 根据四个方向的海拔上升概率，确定当前海拔上升概率
    MGProbability altitudeRiseBase = 1;
    NSUInteger altitudeRiseBaseIndexCount = 0;
    
    if (nil != probability.northProbability) {
        altitudeRiseBase *= probability.northProbability.altitudeRise;
        altitudeRiseBaseIndexCount++;
    }
    if (nil != probability.southProbability) {
        altitudeRiseBase *= probability.southProbability.altitudeRise;
        altitudeRiseBaseIndexCount++;
    }
    if (nil != probability.westProbability) {
        altitudeRiseBase *= probability.westProbability.altitudeRise;
        altitudeRiseBaseIndexCount++;
    }
    if (nil != probability.eastProbability) {
        altitudeRiseBase *= probability.eastProbability.altitudeRise;
        altitudeRiseBaseIndexCount++;
    }
    
    // 计算得出的海拔上升概率
    MGProbability altitudeRiseTarget = pow(altitudeRiseBase, altitudeRiseBaseIndexCount);
//    probability.northProbability.altitudeRise;
    
    // 计算海拔下降概率
    
    // 计算温度上升概率，如果海拔上升，概率值加1
    
    // 计算温度下降概率，如果海拔下降，概率值减1
    
    
    element.latitude = coordinate.x;
    element.longitude = coordinate.y;
    
    if (nil != probability) {
        
    }
    
    return element;
}

+ (ElementType)typeWithProbability:(MGMapProbability *)probability {
    
    // 记录共有几个方向的元素概率对象
    NSUInteger elementProbabilityCount = 0;
    // 草元素概率基数
    MGProbability grassProbabilityBase = 1;
    // 泥土元素概率基数
    MGProbability dirtProbabilityBase = 1;
    // 沙子概率基数
    MGProbability sandProbabilityBase = 1;
    // 水元素概率基数
    MGProbability waterProbabilityBase = 1;
    // 雪元素概率基数
    MGProbability snowProbabilityBase = 1;
    
    if (nil != probability.northProbability) {
        elementProbabilityCount++;
        grassProbabilityBase *= probability.northProbability.grassProbability;
        dirtProbabilityBase *= probability.northProbability.grassProbability;
        sandProbabilityBase *= probability.northProbability.grassProbability;
        waterProbabilityBase *= probability.northProbability.grassProbability;
        snowProbabilityBase *= probability.northProbability.grassProbability;
    }
    if (nil != probability.southProbability) {
        elementProbabilityCount++;
        grassProbabilityBase *= probability.southProbability.grassProbability;
        dirtProbabilityBase *= probability.southProbability.grassProbability;
        sandProbabilityBase *= probability.southProbability.grassProbability;
        waterProbabilityBase *= probability.southProbability.grassProbability;
        snowProbabilityBase *= probability.southProbability.grassProbability;
    }
    if (nil != probability.westProbability) {
        elementProbabilityCount++;
        grassProbabilityBase *= probability.westProbability.grassProbability;
        dirtProbabilityBase *= probability.westProbability.grassProbability;
        sandProbabilityBase *= probability.westProbability.grassProbability;
        waterProbabilityBase *= probability.westProbability.grassProbability;
        snowProbabilityBase *= probability.westProbability.grassProbability;
    }
    if (nil != probability.eastProbability) {
        elementProbabilityCount++;
        grassProbabilityBase *= probability.eastProbability.grassProbability;
        dirtProbabilityBase *= probability.eastProbability.grassProbability;
        sandProbabilityBase *= probability.eastProbability.grassProbability;
        waterProbabilityBase *= probability.eastProbability.grassProbability;
        snowProbabilityBase *= probability.eastProbability.grassProbability;
    }
    
    if (arc4random_uniform(100) < pow(grassProbabilityBase, elementProbabilityCount)) {
        return ElementTypeGrass;
    } else if (arc4random_uniform(100) < pow(dirtProbabilityBase, elementProbabilityCount)) {
        return ElementTypeDirt;
    } else if (arc4random_uniform(100) < pow(sandProbabilityBase, elementProbabilityCount)) {
        return ElementTypeSand;
    } else if (arc4random_uniform(100) < pow(waterProbabilityBase, elementProbabilityCount)) {
        return ElementTypeWater;
    } else if (arc4random_uniform(100) < pow(snowProbabilityBase, elementProbabilityCount)) {
        return ElementTypeSnow;
    } else {
        return [self typeWithProbability:probability];
    }
}

@end
