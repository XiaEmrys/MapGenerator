//
//  MGMapProbability.h
//  MapGenerator
//
//  Created by Emrys on 2018/5/9.
//  Copyright © 2018年 Emrys. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef u_short MGProbability;

@interface MGElementProbability : NSObject

+ (instancetype)elementProbability;

// 海拔上升概率
@property (nonatomic, assign) MGProbability altitudeRise;
// 海拔下降概率
@property (nonatomic, assign) MGProbability altitudeDecline;

// 温度上升概率
@property (nonatomic, assign) MGProbability temperatureRise;
// 温度下降概率
@property (nonatomic, assign) MGProbability temperatureDecline;

// 湿度上升概率
@property (nonatomic, assign) MGProbability humidityRise;
// 湿度下降概率
@property (nonatomic, assign) MGProbability humidityDecline;

// 元素类型概率
// 草
@property (nonatomic, assign) MGProbability grassProbability;
// 泥土
@property (nonatomic, assign) MGProbability dirtProbability;
// 沙子
@property (nonatomic, assign) MGProbability sandProbability;
// 水
@property (nonatomic, assign) MGProbability waterProbability;
// 雪
@property (nonatomic, assign) MGProbability snowProbability;


@end

@interface MGMapProbability : NSObject

+ (instancetype)mapProbability;

// 北部概率模型
@property (nonatomic, strong) MGElementProbability *northProbability;
// 南部概率模型
@property (nonatomic, strong) MGElementProbability *southProbability;
// 西部概率模型
@property (nonatomic, strong) MGElementProbability *westProbability;
// 东部概率模型
@property (nonatomic, strong) MGElementProbability *eastProbability;

// 概率平均值对象模型
@property (readonly) MGElementProbability *averageProbability;

@end
