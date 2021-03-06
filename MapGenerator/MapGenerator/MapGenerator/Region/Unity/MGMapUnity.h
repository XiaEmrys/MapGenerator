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

@class MGMapRegion;
@interface MGMapUnity : MGMapObject

@property (readonly) NSString *elementDatasPath;
@property (readonly) NSData *elementDatas;

+ (instancetype)createWithCoordinate:(CGPoint)coordinate inRegion:(MGMapRegion *)region;

// 根据坐标点取概率模型
- (MGMapProbability *)probabilityWithElementCoordinate:(CGPoint)coordinate;
// 根据坐标点取海拔
- (CGFloat)averageAltitudeWithElementCoordinate:(CGPoint)coordinate;
// 根据坐标点取温度
- (CGFloat)averageTemperatureWithElementCoordinate:(CGPoint)coordinate;
// 根据坐标点取湿度
- (CGFloat)averageHumidityWithElementCoordinate:(CGPoint)coordinate;

// 河流上游方向
- (MapDirection)upstreamDirectionOfRiverWithElementCoordinate:(CGPoint)coordinate;
// 河流下游方向
- (MapDirection)downstreamDirectionOfRiverWithElementCoordinate:(CGPoint)coordinate;

@end
