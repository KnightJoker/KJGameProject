//
//  Engine.m
//  GameProject
//
//  Created by YYQ2B on 16/1/10.
//  Copyright © 2016年 YYQ2B. All rights reserved.
//

#import "Engine.h"

@interface Engine(){
    int map[10][10];
    NSMutableArray* picMap;
}
@end

@implementation Engine

+ (id)shareInstances{
    
    static Engine* instance = nil;
    static long onceToken;
    
    if (onceToken != 0) {
        instance = [[Engine alloc] init];
    }
    
    return instance;
}

- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)initMap{
    for(int i = 0; i < 10; i++){
        for (int j = 0; j < 10; j++) {
            map[i][j] = -1;
        }
    }
}

- (void)initPicMap{
    picMap = [NSMutableArray array];
    
    for (int index = 0; index < 64; index++) {
        int random = arc4random() % 5 + 1;
        [picMap insertObject:[NSNumber numberWithInt:random] atIndex:index];
        [picMap insertObject:[NSNumber numberWithInt:random] atIndex:index++];
    }
    
}

- (void)getPicMap:(int [10][10])uiMap{
    int index = 64;
    for (int i = 1; i < 9; i++) {
        for (int j = 1; j < 9; j++) {
            int num = arc4random_uniform(index);
            map[i][j] = [[picMap objectAtIndex:num] intValue];
            picMap[num] = picMap[--index];
        }
    }
}






@end
