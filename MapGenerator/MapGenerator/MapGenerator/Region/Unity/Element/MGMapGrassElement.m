//
//  MGMapGrassElement.m
//  MapGenerator
//
//  Created by Emrys on 2018/5/9.
//  Copyright © 2018年 Emrys. All rights reserved.
//

#import "MGMapGrassElement.h"

@implementation MGMapGrassElement

+ (instancetype)elementWithProbability:(MGMapProbability *)probability {
    
    MGMapGrassElement *grassElement = [[self alloc] init];
    
    
    
    return grassElement;
}

- (ElementType)elementType {
    return ElementTypeGrass;
}

- (NSUInteger)colorHexValue {
    return 0X7CFC00;
}

@end
