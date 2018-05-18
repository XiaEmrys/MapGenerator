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

@class MGMapUnity;
@class MGMapProbability;
@interface MGBasicElement : MGMapObject

// 取数据
+ (instancetype)elementWithCoordinate:(CGPoint)coordinate inUnity:(MGMapUnity *)unity;
// 生成数据
+ (instancetype)createWithCoordinate:(CGPoint)coordinate inUnity:(MGMapUnity *)unity;

//+ (instancetype)elementWithCoordinate:(CGPoint)coordinate inUnity:(MGMapUnity *)unity probability:(MGMapProbability *)probability;

+ (instancetype)elementWithProbability:(MGMapProbability *)probability;

// 元素所属
@property (readonly) MGMapUnity *unity;

@property (readonly) ElementType elementType;

@property (readonly) NSString *elementKey;

// 海拔
@property (readonly) CGFloat altitude;
// 温度
@property (readonly) CGFloat temperature;
// 湿度
@property (readonly) CGFloat humidity;

// 元素颜色
@property (readonly) NSUInteger colorHexValue;

@end
