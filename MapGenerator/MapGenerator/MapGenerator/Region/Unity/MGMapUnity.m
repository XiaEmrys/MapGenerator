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
#import "MGMapWaterElement.h"

#import <sqlite3.h>

//static NSString *datasFilePath = @"/Users/emrys/Documents/MapGenerator/TestDatas/__datas_0_0.element";

//static NSString *datasFilePath = @"/Users/emrys/Library/Containers/com.Emrys.MapGenerator/Data/Documents/__datas_0_0.element";
//static NSString *datasFilePath = [[NSString stringWithFormat:@"%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]] stringByAppendingPathComponent:@"TestDatas/__datas_0_0.element"];

@interface MGMapUnity ()

@property (nonatomic, assign) CGPoint coordinate;
@property (nonatomic, strong) NSData *elementDatas;

@property (nonatomic, strong) NSMutableArray<MGBasicElement *>*elementArrM;

@end

@implementation MGMapUnity

+ (instancetype)mapWithCoordinate:(CGPoint)coordinate {
    //+ (instancetype)unityWithCoordinate:(CGPoint)coordinate {
    
    return nil;
}

+ (instancetype)createWithCoordinate:(CGPoint)coordinate inRegion:(MGMapRegion *)region {
    MGMapUnity *unity = [[MGMapUnity alloc] init];
    
    unity.coordinate = coordinate;
    
    unity.elementArrM = [NSMutableArray arrayWithCapacity:100*100];
    
    NSMutableData *elementInfoData = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:elementInfoData];
    for (int i = 0; i < 100*100; ++i) {
        int latitude = i%100;
        int longitude = i/100;
        
        MGBasicElement *element = [MGBasicElement createWithCoordinate:CGPointMake(latitude, longitude) inUnity:unity];
        
        [archiver encodeObject:element forKey:element.elementKey];
        
        unity.elementDatas = [NSData dataWithData:elementInfoData];
        
        [unity.elementArrM addObject:element];
        
//        NSLog(@"element:%.2f, index:%d", element.altitude, i);
//        NSLog(@"element:%zd, index:%d", element.elementType, i);
//        if (ElementTypeGrass != element.elementType) {
//            NSLog(@"element:%zd, index:%d", element.elementType, i);
//        }
    }
    [archiver finishEncoding];
    
    [elementInfoData writeToFile:unity.elementDatasPath atomically:YES];
    
    // 存储数据库
        // 坐标值
        // 元素存储路径
    sqlite3 *_db = NULL;
    int openResult = sqlite3_open([[NSString stringWithFormat:@"%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]] stringByAppendingPathComponent:@"TestDatas/test_db.sqlite"].UTF8String, &_db);
    
    if (SQLITE_OK == openResult) {
        
        // 创建表
        int creatResult = sqlite3_exec(_db, @"CREATE TABLE IF NOT EXISTS t_testTable(id INTEGER PRIMARY KEY AUTOINCREMENT, coordinate TEXT NOT NULL UNIQUE)".UTF8String, NULL, NULL, NULL);
        
        if (SQLITE_OK == creatResult) {
            NSLog(@"创建表成功");
            
            int insertResult = sqlite3_exec(_db, [NSString stringWithFormat:@"INSERT INTO t_testTable (coordinate) VALUES ('__unity_latitude_%zd_longitude_%zd');", (NSInteger)coordinate.x, (NSInteger)coordinate.y].UTF8String, NULL, NULL, NULL);
            
            if (SQLITE_OK == insertResult) {
                // 保存数据成功
                NSLog(@"地点坐标保存成功");
            } else {
                // 保存数据失败
                NSLog(@"地点坐标保存失败");
//                if (SQLITE_CONSTRAINT == insertResult) {
//                    int updateResult = sqlite3_exec(_db, [NSString stringWithFormat:@"UPDATE t_testTable SET *** = *** WHERE coordinate = '__unity_latitude_%zd_longitude_%zd';", (NSInteger)coordinate.x, (NSInteger)coordinate.y].UTF8String, NULL, NULL, NULL);
//                    NSLog(@"%d", updateResult);
//                }
            }
            
        } else {
            NSLog(@"创建表失败，%d", creatResult);
        }
        
        int closeResult = sqlite3_close(_db);
        if (SQLITE_OK == closeResult) {
            NSLog(@"关闭数据库成功");
        } else {
            NSLog(@"关闭数据库失败");
        }
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
    
    
//    return [[NSString stringWithFormat:@"%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]] stringByAppendingPathComponent:@"TestDatas"];
    return [NSString stringWithFormat:@"%@/__unity_%02zd_%02zd.datas", [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"TestDatas"],  (NSInteger)self.coordinate.x, (NSInteger)self.coordinate.y];

}

// 根据坐标点取概率模型
- (MGMapProbability *)probabilityWithElementCoordinate:(CGPoint)coordinate {
    
    MGMapProbability *probability = [MGMapProbability mapProbability];
    
    MGBasicElement *northElement = [self northElementWithElementCoordinate:coordinate];
    MGBasicElement *southElement = [self southElementWithElementCoordinate:coordinate];
    MGBasicElement *westElement = [self westElementWithElementCoordinate:coordinate];
    MGBasicElement *eastElement = [self eastElementWithElementCoordinate:coordinate];
    
    if (nil != northElement) {
        probability.northProbability = northElement.mapProbability.southProbability;
    } else {
        probability.northProbability = nil;
    }
    if (nil != southElement) {
        probability.southProbability = southElement.mapProbability.northProbability;
    } else {
        probability.southProbability = nil;
    }
    if (nil != westElement) {
        probability.westProbability = westElement.mapProbability.eastProbability;
    } else {
        probability.westProbability = nil;
    }
    if (nil != eastElement) {
        probability.eastProbability = eastElement.mapProbability.westProbability;
    } else {
        probability.eastProbability = nil;
    }

    
//    if (coordinate.x > 0) {
//        probability.westProbability = self.elementArrM[(int)coordinate.y*100 + (int)coordinate.x-1].mapProbability.eastProbability;
//    } else {
//        probability.westProbability = nil;
//    }
//    if (coordinate.x < 100) {
//        probability.eastProbability = nil;
//    } else {
//        probability.eastProbability = nil;
//    }
//    if (coordinate.y > 0) {
//        probability.northProbability = self.elementArrM[((int)coordinate.y-1)*100 + (int)coordinate.x].mapProbability.southProbability;
//    } else {
//        probability.northProbability = nil;
//    }
//    if (coordinate.y < 100) {
//        probability.southProbability = nil;
//    } else {
//        probability.southProbability = nil;
//    }

//    probability.northProbability = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x, coordinate.y-1) inUnity:self].mapProbability.southProbability;
//    probability.southProbability = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x, coordinate.y+1) inUnity:self].mapProbability.northProbability;
//    probability.westProbability = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x-1, coordinate.y) inUnity:self].mapProbability.eastProbability;
//    probability.eastProbability = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x+1, coordinate.y) inUnity:self].mapProbability.westProbability;
    
    return probability;
}
// 根据坐标点取海拔
- (CGFloat)averageAltitudeWithElementCoordinate:(CGPoint)coordinate {
    
//    MGBasicElement *northElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x, coordinate.y-1) inUnity:self];
//    MGBasicElement *southElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x, coordinate.y+1) inUnity:self];
//    MGBasicElement *westElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x-1, coordinate.y) inUnity:self];
//    MGBasicElement *eastElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x+1, coordinate.y) inUnity:self];
    
    MGBasicElement *northElement = [self northElementWithElementCoordinate:coordinate];
    MGBasicElement *southElement = [self southElementWithElementCoordinate:coordinate];
    MGBasicElement *westElement = [self westElementWithElementCoordinate:coordinate];
    MGBasicElement *eastElement = [self eastElementWithElementCoordinate:coordinate];

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
    
//    MGBasicElement *northElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x, coordinate.y-1) inUnity:self];
//    MGBasicElement *southElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x, coordinate.y+1) inUnity:self];
//    MGBasicElement *westElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x-1, coordinate.y) inUnity:self];
//    MGBasicElement *eastElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x+1, coordinate.y) inUnity:self];
    
    MGBasicElement *northElement = [self northElementWithElementCoordinate:coordinate];
    MGBasicElement *southElement = [self southElementWithElementCoordinate:coordinate];
    MGBasicElement *westElement = [self westElementWithElementCoordinate:coordinate];
    MGBasicElement *eastElement = [self eastElementWithElementCoordinate:coordinate];
    
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
    
//    MGBasicElement *northElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x, coordinate.y-1) inUnity:self];
//    MGBasicElement *southElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x, coordinate.y+1) inUnity:self];
//    MGBasicElement *westElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x-1, coordinate.y) inUnity:self];
//    MGBasicElement *eastElement = [MGBasicElement elementWithCoordinate:CGPointMake(coordinate.x+1, coordinate.y) inUnity:self];
    
    MGBasicElement *northElement = [self northElementWithElementCoordinate:coordinate];
    MGBasicElement *southElement = [self southElementWithElementCoordinate:coordinate];
    MGBasicElement *westElement = [self westElementWithElementCoordinate:coordinate];
    MGBasicElement *eastElement = [self eastElementWithElementCoordinate:coordinate];
    
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
// 河流上游方向
- (MapDirection)upstreamDirectionOfRiverWithElementCoordinate:(CGPoint)coordinate {
    MGBasicElement *northElement = [self northElementWithElementCoordinate:coordinate];
    if (nil != northElement) {
        if (ElementTypeWater == northElement.elementType) {
            if (MapDirectionSouth == ((MGMapWaterElement *)northElement).downstreamDirection) {
                // 下游方向是south
                return MapDirectionNorth;
            }
        }
    }
    MGBasicElement *southElement = [self southElementWithElementCoordinate:coordinate];
    if (nil != southElement) {
        if (ElementTypeWater == southElement.elementType) {
            if (MapDirectionNorth == ((MGMapWaterElement *)southElement).downstreamDirection) {
                // 下游方向是north
                return MapDirectionSouth;
            }
        }
    }
    MGBasicElement *westElement = [self westElementWithElementCoordinate:coordinate];
    if (nil != westElement) {
        if (ElementTypeWater == westElement.elementType) {
            if (MapDirectionEast == ((MGMapWaterElement *)westElement).downstreamDirection) {
                // 下游方向是east
                return MapDirectionWest;
            }
        }
    }
    MGBasicElement *eastElement = [self eastElementWithElementCoordinate:coordinate];
    if (nil != eastElement) {
        if (ElementTypeWater == eastElement.elementType) {
            if (MapDirectionWest == ((MGMapWaterElement *)eastElement).downstreamDirection) {
                // 下游方向是west
                return MapDirectionEast;
            }
        }
    }
    return MapDirectionUnknown;
}
// 河流下游方向
- (MapDirection)downstreamDirectionOfRiverWithElementCoordinate:(CGPoint)coordinate {
    MGBasicElement *northElement = [self northElementWithElementCoordinate:coordinate];
    if (nil != northElement) {
        if (ElementTypeWater == northElement.elementType) {
            if (MapDirectionSouth == ((MGMapWaterElement *)northElement).upstreamDirection) {
                // 上游方向是south
                return MapDirectionNorth;
            }
        }
    }
    MGBasicElement *southElement = [self southElementWithElementCoordinate:coordinate];
    if (nil != southElement) {
        if (ElementTypeWater == southElement.elementType) {
            if (MapDirectionNorth == ((MGMapWaterElement *)southElement).upstreamDirection) {
                // 上游方向是north
                return MapDirectionSouth;
            }
        }
    }
    MGBasicElement *westElement = [self westElementWithElementCoordinate:coordinate];
    if (nil != westElement) {
        if (ElementTypeWater == westElement.elementType) {
            if (MapDirectionEast == ((MGMapWaterElement *)westElement).upstreamDirection) {
                // 上游方向是east
                return MapDirectionWest;
            }
        }
    }
    MGBasicElement *eastElement = [self eastElementWithElementCoordinate:coordinate];
    if (nil != eastElement) {
        if (ElementTypeWater == eastElement.elementType) {
            if (MapDirectionWest == ((MGMapWaterElement *)eastElement).upstreamDirection) {
                // 上游方向是west
                return MapDirectionEast;
            }
        }
    }
    return MapDirectionUnknown;
}

- (MGBasicElement *)northElementWithElementCoordinate:(CGPoint)coordinate {
    if (coordinate.y > 0) {
        return self.elementArrM[((int)coordinate.y-1)*100 + (int)coordinate.x];
    } else {
        return nil;
    }
}
- (MGBasicElement *)southElementWithElementCoordinate:(CGPoint)coordinate {
    if (coordinate.y < 100) {
        return nil;
    } else {
        return nil;
    }
}
- (MGBasicElement *)westElementWithElementCoordinate:(CGPoint)coordinate {
    if (coordinate.x > 0) {
        return self.elementArrM[(int)coordinate.y*100 + (int)coordinate.x-1];
    } else {
        return nil;
    }
}
- (MGBasicElement *)eastElementWithElementCoordinate:(CGPoint)coordinate {
    if (coordinate.x < 100) {
        return nil;
    } else {
        return nil;
    }
}

@end
