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

@interface MGBasicElement ()

@property (nonatomic, assign) CGFloat latitude;     // 纬度
@property (nonatomic, assign) CGFloat longitude;    // 经度



@end

@implementation MGBasicElement

//+ (instancetype)elementWithCoordinate:(CGPoint)coordinate {
//    // 先在本地存储取数据，没有的时候创建
//    // 创建时先判断周围四个方向的元素各属性概率值，根据概率值生成当前元素概率
//    // 根据概率创建元素对象
//    return nil;
//}
//+ (instancetype)elementWithCoordinate:(CGPoint)coordinate probability:(MGMapProbability *)probability {
//    MGBasicElement *element = [[MGBasicElement alloc] init];
//
//    element.latitude = coordinate.x;
//    element.longitude = coordinate.y;
//
//    return element;
//}
+ (instancetype)mapWithCoordinate:(CGPoint)coordinate {
    
    // 先在本地存储取数据，没有的时候创建
    // 假设有，直接取出来
    
    // 假设没有
            // 取四个方向的元素的概率对象
                // 假设四个方向都没有，自定义概率对象
    MGMapProbability *mapProbability = [MGMapProbability mapProbability];
//    mapProbability.northProbability
    
    return nil;
}
+ (instancetype)mapWithCoordinate:(CGPoint)coordinate probability:(MGMapProbability *)probability {
    
    // 根据四个方向的海拔上升概率，确定当前海拔上升概率
//    probability.northProbability.altitudeRise;
    
    MGBasicElement *element = [[MGBasicElement alloc] init];

    element.latitude = coordinate.x;
    element.longitude = coordinate.y;
    
    if (nil != probability) {
        
    }
    
    return element;
}

@end
