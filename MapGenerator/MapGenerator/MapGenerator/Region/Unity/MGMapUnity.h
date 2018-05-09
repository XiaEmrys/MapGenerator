//
//  MGMapUnity.h
//  MapGenerator
//
//  Created by Emrys on 2018/5/9.
//  Copyright © 2018年 Emrys. All rights reserved.
//

/// 每一坐标对应单位
/// 100*100 element

#import "MGMapObject.h"

@interface MGMapUnity : MGMapObject

+ (instancetype)unityWithCoordinate:(CGPoint)coordinate;


@end

@interface MGMapUnityProbability : NSObject

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

// 草地概率
// 沙地概率
// 水域概率
// 山体概率
// 雪域概率

@end
