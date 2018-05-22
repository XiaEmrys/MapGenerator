//
//  MGMapProbability.m
//  MapGenerator
//
//  Created by Emrys on 2018/5/9.
//  Copyright © 2018年 Emrys. All rights reserved.
//

#import "MGMapProbability.h"

@implementation MGMapProbability

+ (instancetype)mapProbability {
    MGMapProbability *mapProbability = [[MGMapProbability alloc] init];
    
    return mapProbability;
}

- (MGElementProbability *)averageProbability {
    
    MGElementProbability *averageProbability = [MGElementProbability elementProbability];
    
    // 记录共有几个方向的元素概率对象
    NSUInteger elementProbabilityCount = 0;
    // 草元素概率基数
    MGProbability grassProbabilityBase = 1;
    // 泥土元素概率基数
    MGProbability dirtProbabilityBase = 1;
    // 沙子概率基数
    MGProbability sandProbabilityBase = 1;
    // 水元素概率基数
    MGProbability waterProbabilityBase = 1;
    // 雪元素概率基数
    MGProbability snowProbabilityBase = 1;
    
    // 海拔上升概率基数
    MGProbability altitudeRiseBase = 1;
    // 海拔下降概率基数
    MGProbability altitudeDeclineBase = 1;
    // 温度上升概率基数
    MGProbability temperatureRiseBase = 1;
    // 温度下降概率基数
    MGProbability temperatureDeclineBase = 1;
    // 湿度上升概率基数
    MGProbability humidityRiseBase = 1;
    // 湿度下降概率基数
    MGProbability humidityDeclineBase = 1;
    
    if (nil != self.northProbability) {
        elementProbabilityCount++;
        grassProbabilityBase *= self.northProbability.grassProbability;
        dirtProbabilityBase *= self.northProbability.grassProbability;
        sandProbabilityBase *= self.northProbability.grassProbability;
        waterProbabilityBase *= self.northProbability.grassProbability;
        snowProbabilityBase *= self.northProbability.grassProbability;
        
        altitudeRiseBase *= self.northProbability.altitudeRise;
        altitudeDeclineBase *= self.northProbability.altitudeDecline;
        temperatureRiseBase *= self.northProbability.temperatureRise;
        temperatureDeclineBase *= self.northProbability.temperatureDecline;
        humidityRiseBase *= self.northProbability.humidityRise;
        humidityDeclineBase *= self.northProbability.humidityDecline;
    }
    if (nil != self.southProbability) {
        elementProbabilityCount++;
        grassProbabilityBase *= self.southProbability.grassProbability;
        dirtProbabilityBase *= self.southProbability.grassProbability;
        sandProbabilityBase *= self.southProbability.grassProbability;
        waterProbabilityBase *= self.southProbability.grassProbability;
        snowProbabilityBase *= self.southProbability.grassProbability;
        
        altitudeRiseBase *= self.southProbability.altitudeRise;
        altitudeDeclineBase *= self.southProbability.altitudeDecline;
        temperatureRiseBase *= self.southProbability.temperatureRise;
        temperatureDeclineBase *= self.southProbability.temperatureDecline;
        humidityRiseBase *= self.southProbability.humidityRise;
        humidityDeclineBase *= self.southProbability.humidityDecline;
    }
    if (nil != self.westProbability) {
        elementProbabilityCount++;
        grassProbabilityBase *= self.westProbability.grassProbability;
        dirtProbabilityBase *= self.westProbability.dirtProbability;
        sandProbabilityBase *= self.westProbability.sandProbability;
        waterProbabilityBase *= self.westProbability.waterProbability;
        snowProbabilityBase *= self.westProbability.snowProbability;
        
        altitudeRiseBase *= self.westProbability.altitudeRise;
        altitudeDeclineBase *= self.westProbability.altitudeDecline;
        temperatureRiseBase *= self.westProbability.temperatureRise;
        temperatureDeclineBase *= self.westProbability.temperatureDecline;
        humidityRiseBase *= self.westProbability.humidityRise;
        humidityDeclineBase *= self.westProbability.humidityDecline;
    }
    if (nil != self.eastProbability) {
        elementProbabilityCount++;
        grassProbabilityBase *= self.eastProbability.grassProbability;
        dirtProbabilityBase *= self.eastProbability.grassProbability;
        sandProbabilityBase *= self.eastProbability.grassProbability;
        waterProbabilityBase *= self.eastProbability.grassProbability;
        snowProbabilityBase *= self.eastProbability.grassProbability;
        
        altitudeRiseBase *= self.eastProbability.altitudeRise;
        altitudeDeclineBase *= self.eastProbability.altitudeDecline;
        temperatureRiseBase *= self.eastProbability.temperatureRise;
        temperatureDeclineBase *= self.eastProbability.temperatureDecline;
        humidityRiseBase *= self.eastProbability.humidityRise;
        humidityDeclineBase *= self.eastProbability.humidityDecline;
    }
    
    if (0 == elementProbabilityCount) {
        averageProbability.grassProbability = 90;
        averageProbability.dirtProbability = 10;
        averageProbability.sandProbability = 10;
        averageProbability.waterProbability = 10;
        averageProbability.snowProbability = 0;
        
        averageProbability.altitudeRise = 50;
        averageProbability.altitudeDecline = 50;
        averageProbability.temperatureRise = 50;
        averageProbability.temperatureDecline = 50;
        averageProbability.humidityRise = 50;
        averageProbability.humidityDecline = 50;
    } else {
        averageProbability.grassProbability = pow(grassProbabilityBase, 1.0/elementProbabilityCount);
        averageProbability.dirtProbability = pow(dirtProbabilityBase, 1.0/elementProbabilityCount);
        averageProbability.sandProbability = pow(sandProbabilityBase, 1.0/elementProbabilityCount);
        averageProbability.waterProbability = pow(waterProbabilityBase, 1.0/elementProbabilityCount);
        averageProbability.snowProbability = pow(snowProbabilityBase, 1.0/elementProbabilityCount);
        
        averageProbability.altitudeRise = pow(altitudeRiseBase, 1.0/elementProbabilityCount);
        averageProbability.altitudeDecline = pow(altitudeDeclineBase, 1.0/elementProbabilityCount);
        averageProbability.temperatureRise = pow(temperatureRiseBase, 1.0/elementProbabilityCount);
        averageProbability.temperatureDecline = pow(temperatureDeclineBase, 1.0/elementProbabilityCount);
        averageProbability.humidityRise = pow(humidityRiseBase, 1.0/elementProbabilityCount);
        averageProbability.humidityDecline = pow(humidityDeclineBase, 1.0/elementProbabilityCount);
    }
    
    return averageProbability;
}

@end

@interface MGElementProbability () <NSCoding>
@end

@implementation MGElementProbability

+ (instancetype)elementProbability {
    MGElementProbability *elementProbability = [[MGElementProbability alloc] init];
    
    return elementProbability;
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeInt:self.altitudeRise forKey:@"altitudeRise"];
    [aCoder encodeInt:self.altitudeDecline forKey:@"altitudeDecline"];
    [aCoder encodeInt:self.temperatureRise forKey:@"temperatureRise"];
    [aCoder encodeInt:self.temperatureDecline forKey:@"temperatureDecline"];
    [aCoder encodeInt:self.humidityRise forKey:@"humidityRise"];
    [aCoder encodeInt:self.humidityDecline forKey:@"humidityDecline"];
    [aCoder encodeInt:self.grassProbability forKey:@"grassProbability"];
    [aCoder encodeInt:self.dirtProbability forKey:@"dirtProbability"];
    [aCoder encodeInt:self.sandProbability forKey:@"sandProbability"];
    [aCoder encodeInt:self.waterProbability forKey:@"waterProbability"];
    [aCoder encodeInt:self.snowProbability forKey:@"snowProbability"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        //
        self.altitudeRise = [aDecoder decodeIntForKey:@"altitudeRise"];
        self.altitudeDecline = [aDecoder decodeIntForKey:@"altitudeDecline"];
        self.temperatureRise = [aDecoder decodeIntForKey:@"temperatureRise"];
        self.temperatureDecline = [aDecoder decodeIntForKey:@"temperatureDecline"];
        self.humidityRise = [aDecoder decodeIntForKey:@"humidityRise"];
        self.humidityDecline = [aDecoder decodeIntForKey:@"humidityDecline"];
        self.grassProbability = [aDecoder decodeIntForKey:@"grassProbability"];
        self.dirtProbability = [aDecoder decodeIntForKey:@"dirtProbability"];
        self.sandProbability = [aDecoder decodeIntForKey:@"sandProbability"];
        self.waterProbability = [aDecoder decodeIntForKey:@"waterProbability"];
        self.snowProbability = [aDecoder decodeIntForKey:@"snowProbability"];
    }
    return self;
}

@end
