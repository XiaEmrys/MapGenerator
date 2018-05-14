//
//  MGBasicElement.h
//  MapGenerator
//
//  Created by Emrys on 2018/5/8.
//  Copyright © 2018年 Emrys. All rights reserved.
//

/// 地图最小元素

#import "MGMapObject.h"

typedef NS_ENUM(NSUInteger, ElementType) {
    ElementTypeGrass
    ,ElementTypeDirt
    ,ElementTypeSand
    ,ElementTypeWater
    ,ElementTypeSnow
};

@class MGMapProbability;
@interface MGBasicElement : MGMapObject

//+ (instancetype)elementWithCoordinate:(CGPoint)coordinate;
//+ (instancetype)elementWithCoordinate:(CGPoint)coordinate probability:(MGMapProbability *)probability;

+ (instancetype)elementWithProbability:(MGMapProbability *)probability;

@property (readonly) ElementType elementType;

// 海拔
@property (readonly) CGFloat altitude;
// 温度
@property (readonly) CGFloat temperature;
// 湿度
@property (readonly) CGFloat humidity;

// 元素颜色
@property (readonly) NSUInteger colorHexValue;

@end
