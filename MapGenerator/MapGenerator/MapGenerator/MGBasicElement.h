//
//  MGBasicElement.h
//  MapGenerator
//
//  Created by Emrys on 2018/5/8.
//  Copyright © 2018年 Emrys. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ElementType) {
    ElementTypeGrass
    ,ElementTypeDirt
    ,ElementTypeSand
    ,ElementTypeWater
};

@class MGElementProbability;
@interface MGBasicElement : NSObject

+ (instancetype)elementWithCoordinate:(CGPoint)coordinate;
+ (instancetype)elementWithCoordinate:(CGPoint)coordinate probability:(MGElementProbability *)probability;

@property (readonly) ElementType elementType;

// 温度
@property (readonly) CGFloat temperature;
// 海拔
@property (readonly) CGFloat altitude;
// 湿度
@property (readonly) CGFloat humidity;

// 元素颜色
@property (readonly) NSString *colorHexValue;

@end


@interface MGElementProbability : NSObject

// 温度上升概率
@property (nonatomic, assign) NSUInteger temperatureRise;
// 温度下降概率
@property (nonatomic, assign) NSUInteger temperatureDecline;

// 海拔上升概率
@property (nonatomic, assign) NSUInteger altitudeRise;
// 海拔下降概率
@property (nonatomic, assign) NSUInteger altitudeDecline;

// 温度上升概率
@property (nonatomic, assign) NSUInteger humidityRise;
// 温度下降概率
@property (nonatomic, assign) NSUInteger humidityDecline;

// 元素类型概率
// 草
@property (nonatomic, assign) NSUInteger grassProbability;
// 泥土
@property (nonatomic, assign) NSUInteger dirtProbability;
// 沙子
@property (nonatomic, assign) NSUInteger sandProbability;
// 水
@property (nonatomic, assign) NSUInteger waterProbability;

@end
