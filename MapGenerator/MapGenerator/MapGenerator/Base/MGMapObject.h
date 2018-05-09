//
//  MGMapObject.h
//  MapGenerator
//
//  Created by Emrys on 2018/5/9.
//  Copyright © 2018年 Emrys. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MGMapProbability;
@interface MGMapObject : NSObject

+ (instancetype)mapWithCoordinate:(CGPoint)coordinate;
+ (instancetype)mapWithCoordinate:(CGPoint)coordinate probability:(MGMapProbability *)probability;

@property (readonly) MGMapProbability *mapProbability;

@end
