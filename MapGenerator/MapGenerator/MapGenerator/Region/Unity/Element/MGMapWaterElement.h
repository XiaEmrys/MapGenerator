//
//  MGMapWaterElement.h
//  MapGenerator
//
//  Created by Emrys on 2018/5/12.
//  Copyright © 2018年 Emrys. All rights reserved.
//

#import "MGBasicElement.h"

typedef NS_ENUM(NSUInteger, WaterElementCategory) {
    WaterElementCategoryRiver
    ,WaterElementCategoryLake
};

typedef NS_ENUM(NSUInteger, WaterElementType) {
    WaterElementTypeEdge
    ,WaterElementTypeInternal
};

@interface MGMapWaterElement : MGBasicElement

+ (instancetype)waterWithProbability:(MGMapProbability *)probability upstreamDirection:(MapDirection)upstreamDirection downstreamDirection:(MapDirection)downstreamDirection;

// 上游方向
@property (readonly) MapDirection upstreamDirection;
// 下游方向
@property (readonly) MapDirection downstreamDirection;

@end
