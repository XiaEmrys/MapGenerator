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
#import "MGMapDirtElement.h"
#import "MGMapSandElement.h"
#import "MGMapWaterElement.h"
#import "MGMapSnowElement.h"

static NSString *datasFilePath = @"/Users/emrys/Documents/MapGenerator/TestDatas";

// 海拔
typedef NS_ENUM(NSUInteger, ElementAltitudeTendency) {
    ElementAltitudeRise         // 上升
    ,ElementAltitudeDecline     // 下降
    ,ElementAltitudeInvariable  // 不变
};
// 温度
typedef NS_ENUM(NSUInteger, ElementTemperatureTendency) {
    ElementTemperatureRise         // 上升
    ,ElementTemperatureDecline     // 下降
    ,ElementTemperatureInvariable  // 不变
};
// 湿度
typedef NS_ENUM(NSUInteger, ElementHumidityTendency) {
    ElementHumidityRise         // 上升
    ,ElementHumidityDecline     // 下降
    ,ElementHumidityInvariable  // 不变
};

@interface MGBasicElement ()

@property (nonatomic, assign) CGFloat latitude;     // 纬度
@property (nonatomic, assign) CGFloat longitude;    // 经度

// 海拔
@property (nonatomic, assign) CGFloat altitude;
// 温度
@property (nonatomic, assign) CGFloat temperature;
// 湿度
@property (nonatomic, assign) CGFloat humidity;


// 北部概率模型
@property (nonatomic, strong) MGElementProbability *northProbability;
// 南部概率模型
@property (nonatomic, strong) MGElementProbability *southProbability;
// 西部概率模型
@property (nonatomic, strong) MGElementProbability *westProbability;
// 东部概率模型
@property (nonatomic, strong) MGElementProbability *eastProbability;

@end

@implementation MGBasicElement

+ (instancetype)mapWithCoordinate:(CGPoint)coordinate {
    
    // 先在本地存储取数据，没有的时候创建
    // 假设有，直接取出来
    
    // 假设没有
            // 取四个方向的元素的概率对象
                // 假设四个方向都没有，概率对象传空
    
    return [self mapWithCoordinate:coordinate probability:nil];
    
    return nil;
}
+ (instancetype)mapWithCoordinate:(CGPoint)coordinate probability:(MGMapProbability *)probability {
    
    // 根据坐标取四个方向的元素模型做平均值计算，求海拔、温度、湿度等数据
    // 如果四个方向均没有数据记录，即所有数据初始化时，设置默认参数
    CGFloat altitude = 200;     // 海拔
    CGFloat temperature = 20;   // 温度
    CGFloat humidity = 40;      // 湿度
    
    ElementType curType = [self typeWithProbability:probability];

    MGBasicElement *element;
    
    switch (curType) {
        case ElementTypeGrass:
            //
            element = [MGMapGrassElement elementWithProbability:probability];
            break;
        case ElementTypeDirt:
            //
            element = [MGMapDirtElement elementWithProbability:probability];
            break;
        case ElementTypeSand:
            //
            element = [MGMapSandElement elementWithProbability:probability];
            break;
        case ElementTypeWater:
            //
            element = [MGMapWaterElement elementWithProbability:probability];
            break;
        case ElementTypeSnow:
            //
            element = [MGMapSnowElement elementWithProbability:probability];
            break;
        default:
            break;
    }
    
    element.latitude = coordinate.x;
    element.longitude = coordinate.y;
    
    // 海拔上升下降趋势
    ElementAltitudeTendency altitudeTendency = [self altitudeTendencyRise:probability.averageProbability.altitudeRise decline:probability.averageProbability.altitudeDecline];
    // 温度上升下降趋势
    ElementTemperatureTendency temperatureTendency;
    // 湿度上升下降趋势
    ElementHumidityTendency humidityTendency = [self humidityTendencyRise:probability.averageProbability.humidityRise decline:probability.averageProbability.humidityDecline];
    
    switch (altitudeTendency) {
        case ElementAltitudeRise:
            // 海拔升高，影响温度升高概率-1，温度降低概率+1
            temperatureTendency = [self temperatureTendencyRise:probability.averageProbability.temperatureRise-1 decline:probability.averageProbability.temperatureDecline+1];
            break;
        case ElementAltitudeDecline:
            // 海拔降低，影响温度升高概率+1，温度降低概率-1
            temperatureTendency = [self temperatureTendencyRise:probability.averageProbability.temperatureRise+1 decline:probability.averageProbability.temperatureDecline-1];
            break;
        default:
            temperatureTendency = [self temperatureTendencyRise:probability.averageProbability.temperatureRise decline:probability.averageProbability.temperatureDecline];
            break;
    }
    
    element.altitude = [self altitudeWithTendency:altitudeTendency average:altitude];
    element.temperature = [self temperatureWithTendency:temperatureTendency average:temperature];
    element.humidity = [self humidityWithTendency:humidityTendency average:humidity];
    
    // 存储本地
    
    return element;
}

+ (ElementType)typeWithProbability:(MGMapProbability *)probability {
    
    if (nil == probability) {
        return ElementTypeGrass;
    }
    
    MGElementProbability *averageProbability = probability.averageProbability;
    
    if (arc4random_uniform(100) < averageProbability.grassProbability) {
        return ElementTypeGrass;
    } else if (arc4random_uniform(100) < averageProbability.dirtProbability) {
        return ElementTypeDirt;
    } else if (arc4random_uniform(100) < averageProbability.sandProbability) {
        return ElementTypeSand;
    } else if (arc4random_uniform(100) < averageProbability.waterProbability) {
        return ElementTypeWater;
    } else if (arc4random_uniform(100) < averageProbability.snowProbability) {
        return ElementTypeSnow;
    } else {
        return [self typeWithProbability:probability];
    }
}

+ (instancetype)elementWithProbability:(MGMapProbability *)probability {
    
    MGBasicElement *element = [[self alloc] init];
    
    if (nil != probability.northProbability) {
        element.southProbability = probability.northProbability;
    } else {
        element.southProbability = probability.averageProbability;
    }
    if (nil != probability.southProbability) {
        element.northProbability = probability.southProbability;
    } else {
        element.northProbability = probability.averageProbability;
    }
    if (nil != probability.westProbability) {
        element.eastProbability = probability.westProbability;
    } else {
        element.eastProbability = probability.averageProbability;
    }
    if (nil != probability.eastProbability) {
        element.westProbability = probability.eastProbability;
    } else {
        element.westProbability = probability.averageProbability;
    }
    
    return element;
}

// 通过概率计算海拔上升还是下降
+ (ElementAltitudeTendency)altitudeTendencyRise:(MGProbability)rise decline:(MGProbability)decline {
    
    if (arc4random_uniform(100) < rise) {
        return ElementAltitudeRise;
    } else if (arc4random_uniform(100) < decline) {
        return ElementAltitudeDecline;
    } else {
        return ElementAltitudeInvariable;
    }
}
// 通过海拔平均值，根据海拔上升下降结果，得出当前海拔高度
+ (CGFloat)altitudeWithTendency:(ElementAltitudeTendency)tendency average:(CGFloat)average {
    
    switch (tendency) {
        case ElementAltitudeRise:
            return average+0.01;
            break;
        case ElementAltitudeDecline:
            return average-0.01;
            break;
        default:
            return average;
            break;
    }
}

// 通过概率计算温度上升还是下降
+ (ElementTemperatureTendency)temperatureTendencyRise:(MGProbability)rise decline:(MGProbability)decline {
    
    if (arc4random_uniform(100) < rise) {
        return ElementTemperatureRise;
    } else if (arc4random_uniform(100) < decline) {
        return ElementTemperatureDecline;
    } else {
        return ElementTemperatureInvariable;
    }
}

// 通过温度平均值，根据温度上升下降结果，得出当前温度
+ (CGFloat)temperatureWithTendency:(ElementTemperatureTendency)tendency average:(CGFloat)average {
    
    switch (tendency) {
        case ElementTemperatureRise:
            return average+0.01;
            break;
        case ElementTemperatureDecline:
            return average-0.01;
            break;
        default:
            return average;
            break;
    }
}

// 通过概率计算湿度上升还是下降
+ (ElementHumidityTendency)humidityTendencyRise:(MGProbability)rise decline:(MGProbability)decline {
    
    if (arc4random_uniform(100) < rise) {
        return ElementHumidityRise;
    } else if (arc4random_uniform(100) < decline) {
        return ElementHumidityDecline;
    } else {
        return ElementHumidityInvariable;
    }
}

// 通过湿度平均值，根据湿度上升下降结果，得出当前湿度
+ (CGFloat)humidityWithTendency:(ElementHumidityTendency)tendency average:(CGFloat)average {
    
    switch (tendency) {
        case ElementHumidityRise:
            return average+0.01;
            break;
        case ElementHumidityDecline:
            return average-0.01;
            break;
        default:
            return average;
            break;
    }
}

@end
