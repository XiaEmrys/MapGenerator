//
//  MGMapUnity.m
//  MapGenerator
//
//  Created by Emrys on 2018/5/9.
//  Copyright © 2018年 Emrys. All rights reserved.
//

#import "MGMapUnity.h"
#import "MGMapProbability.h"

#import "MGBasicElement.h"

//static NSString *datasFilePath = @"/Users/emrys/Documents/MapGenerator/TestDatas/__datas_0_0.element";

//static NSString *datasFilePath = @"/Users/emrys/Library/Containers/com.Emrys.MapGenerator/Data/Documents/__datas_0_0.element";
//static NSString *datasFilePath = [[NSString stringWithFormat:@"%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]] stringByAppendingPathComponent:@"TestDatas/__datas_0_0.element"];

@implementation MGMapUnity

+ (instancetype)mapWithCoordinate:(CGPoint)coordinate {
//+ (instancetype)unityWithCoordinate:(CGPoint)coordinate {

    MGMapUnity *unity = [[MGMapUnity alloc] init];
    
    
    // 元素概率取对应到当前unity的对应方向该概率平均值相乘取平方根值
    // 先假设各个平均值均为50
    // 初始化时均无值的情况下，草地50，其他值根据情况判定
    
    for (int i = 0; i < 100*100; ++i) {
        int latitude = i%100;
        int longitude = i/100;
        
        MGBasicElement *ele = [MGBasicElement createWithCoordinate:CGPointMake(latitude, longitude) inUnity:unity];
    }

    return unity;
}

// 元素数据文件存储地址
- (NSString *)elementDatasPath {
    
//    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSSystemDomainMask, YES);
//    NSLog(@"%@", NSSearchPathForDirectoriesInDomains(NSAllLibrariesDirectory, NSAllDomainsMask, YES));
//    NSLog(@"%@", NSHomeDirectory());
//    NSLog(@"%@", NSHomeDirectoryForUser(@"emrys"));
//    NSLog(@"%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]);
//    return datasFilePath;
    return [[NSString stringWithFormat:@"%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]] stringByAppendingPathComponent:@"TestDatas"];
}

// 根据坐标点取概率模型
- (MGMapProbability *)probabilityWithElementCoordinate:(CGPoint)coordinate {
    
    MGMapProbability *probability = [MGMapProbability mapProbability];
    
    probability.northProbability = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x, coordinate.y-1) inUnity:self].mapProbability.southProbability;
    probability.southProbability = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x, coordinate.y+1) inUnity:self].mapProbability.northProbability;
    probability.westProbability = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x-1, coordinate.y) inUnity:self].mapProbability.eastProbability;
    probability.eastProbability = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x+1, coordinate.y) inUnity:self].mapProbability.westProbability;
        
    return probability;
}
// 根据坐标点取海拔
- (CGFloat)averageAltitudeWithElementCoordinate:(CGPoint)coordinate {
    
    MGBasicElement *northElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x, coordinate.y-1) inUnity:self];
    MGBasicElement *southElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x, coordinate.y+1) inUnity:self];
    MGBasicElement *westElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x-1, coordinate.y) inUnity:self];
    MGBasicElement *eastElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x+1, coordinate.y) inUnity:self];

    // 记录共有几个方向的元素概率对象
    NSUInteger elementCount = 0;
    
    CGFloat altitudeBase = 0;
    
    if (nil != northElement) {
        elementCount++;
        altitudeBase += northElement.altitude;
    }
    if (nil != southElement) {
        elementCount++;
        altitudeBase += southElement.altitude;
    }
    if (nil != westElement) {
        elementCount++;
        altitudeBase += westElement.altitude;
    }
    if (nil != eastElement) {
        elementCount++;
        altitudeBase += eastElement.altitude;
    }
    
    if (0 == elementCount) {
        return 200;
    } else {
        return altitudeBase/elementCount;
    }
}
// 根据坐标点取温度
- (CGFloat)averageTemperatureWithElementCoordinate:(CGPoint)coordinate {
    
    MGBasicElement *northElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x, coordinate.y-1) inUnity:self];
    MGBasicElement *southElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x, coordinate.y+1) inUnity:self];
    MGBasicElement *westElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x-1, coordinate.y) inUnity:self];
    MGBasicElement *eastElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x+1, coordinate.y) inUnity:self];
    
    // 记录共有几个方向的元素概率对象
    NSUInteger elementCount = 0;
    
    CGFloat temperatureBase = 0;
    
    if (nil != northElement) {
        elementCount++;
        temperatureBase += northElement.temperature;
    }
    if (nil != southElement) {
        elementCount++;
        temperatureBase += southElement.temperature;
    }
    if (nil != westElement) {
        elementCount++;
        temperatureBase += westElement.temperature;
    }
    if (nil != eastElement) {
        elementCount++;
        temperatureBase += eastElement.temperature;
    }
    
    if (0 == elementCount) {
        return 25;
    } else {
        return temperatureBase/elementCount;
    }
}
// 根据坐标点取湿度
- (CGFloat)averageHumidityWithElementCoordinate:(CGPoint)coordinate {
    
    MGBasicElement *northElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x, coordinate.y-1) inUnity:self];
    MGBasicElement *southElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x, coordinate.y+1) inUnity:self];
    MGBasicElement *westElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x-1, coordinate.y) inUnity:self];
    MGBasicElement *eastElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x+1, coordinate.y) inUnity:self];
    
    // 记录共有几个方向的元素概率对象
    NSUInteger elementCount = 0;
    
    CGFloat humidityBase = 0;
    
    if (nil != northElement) {
        elementCount++;
        humidityBase += northElement.humidity;
    }
    if (nil != southElement) {
        elementCount++;
        humidityBase += southElement.humidity;
    }
    if (nil != westElement) {
        elementCount++;
        humidityBase += westElement.humidity;
    }
    if (nil != eastElement) {
        elementCount++;
        humidityBase += eastElement.humidity;
    }
    
    if (0 == elementCount) {
        return 40;
    } else {
        return humidityBase/elementCount;
    }
}


@end
