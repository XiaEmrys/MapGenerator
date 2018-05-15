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

@property (readonly) NSString *elementDatasPath;

// 根据坐标点取概率模型
- (MGMapProbability *)probabilityWithCoordinate:(CGPoint)coordinate;
// 根据坐标点取海拔
- (CGFloat)averageAltitudeWithCoordinate:(CGPoint)coordinate;
// 根据坐标点取温度
- (CGFloat)averageTemperatureWithCoordinate:(CGPoint)coordinate;
// 根据坐标点取湿度
- (CGFloat)averageHumidityWithCoordinate:(CGPoint)coordinate;

@end
