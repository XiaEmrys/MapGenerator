//
//  MGMapUnity.m
//  MapGenerator
//
//  Created by Emrys on 2018/5/9.
//  Copyright © 2018年 Emrys. All rights reserved.
//

#import "MGMapUnity.h"

static NSString *datasFilePath = @"/Users/emrys/Documents/MapGenerator/TestDatas";

@implementation MGMapUnity

+ (instancetype)unityWithCoordinate:(CGPoint)coordinate {
    
    MGMapUnity *unity = [[MGMapUnity alloc] init];
    
    
    // 元素概率取对应到当前unity的对应方向该概率平均值相乘取平方根值
    // 先假设各个平均值均为50
    // 初始化时均无值的情况下，草地50，其他值根据情况判定
    
    for (int i = 0; i < 100*100; ++i) {
        // 先在本地存储取数据，没有的时候创建
        // 创建时先判断周围四个方向的元素各属性概率值，根据概率值生成当前元素概率
        // 根据概率创建元素对象
    }
    
    return unity;
}


// 根据坐标点取概率模型
- (MGMapProbability *)probabilityWithCoordinate:(CGPoint)coordinate {
    return nil;
}
// 根据坐标点取海拔
- (CGFloat)averageAltitudeWithCoordinate:(CGPoint)coordinate {
    return 0;
}
// 根据坐标点取温度
- (CGFloat)averageTemperatureWithCoordinate:(CGPoint)coordinate {
    return 0;
}
// 根据坐标点取湿度
- (CGFloat)averageHumidityWithCoordinate:(CGPoint)coordinate {
    return 0;
}


@end
