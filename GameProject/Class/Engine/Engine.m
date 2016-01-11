//
//  Engine.m
//  GameProject
//
//  Created by YYQ2B on 16/1/10.
//  Copyright © 2016年 YYQ2B. All rights reserved.
//

#import "Engine.h"

@interface Engine(){
    NSMutableArray *_map;
    NSMutableArray *_picMap;
}
@end

@implementation Engine

+ (id)shareInstances{
    
    static Engine* instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[Engine alloc] init];
    });
    
    return instance;
}

- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)beginGamer{
    [self initMap];
    [self initPicMap];
}

- (void)nextGamer{
    [self initMap];
    [_picMap removeAllObjects];
    [self initPicMap];
}

- (void)initMap{
    _map = [NSMutableArray array];
}

- (void)initPicMap{
    _picMap = [NSMutableArray array];
    
    for (int index = 0; index < 64; index++) {
        int random = arc4random() % 5 + 1;
        [_picMap insertObject:[NSNumber numberWithInt:random] atIndex:index];
        [_picMap insertObject:[NSNumber numberWithInt:random] atIndex:index++];
    }
    
}

- (NSMutableArray *)getPicMap{
    
    NSMutableArray *uiMapArray = [NSMutableArray array];
    
    /**
     *  这里采用了逐行写入mutableDictionary的方法，一个数组，每行又是一个数组，组成了二维数组，OC的二维数组一般这么来处理
     */
    int index = 64;
    for (int i = 1; i < 9; i++) {
        //单行缓存
        NSMutableArray *lineArray = [NSMutableArray array];
        for (int j = 1; j < 9; j++) {
            int num = arc4random_uniform(index);
            [lineArray addObject:@([[_picMap objectAtIndex:num] integerValue])];
            _picMap[num] = _picMap[--index];
        }
        //增加左右边界
        [lineArray insertObject:@(-1) atIndex:0];
        [lineArray addObject:@(-1)];
        
        [_map addObject:lineArray];
    }
    //增加上下边界
    [_map insertObject:[NSArray arrayWithObjects:@(-1),@(-1),@(-1),@(-1),@(-1),@(-1),@(-1),@(-1),@(-1),@(-1), nil] atIndex:0];
    [_map addObject:[NSArray arrayWithObjects:@(-1),@(-1),@(-1),@(-1),@(-1),@(-1),@(-1),@(-1),@(-1),@(-1), nil]];
    
    
    for (int i = 0; i < 10; i++) {
        //单行缓存
        NSMutableArray *lineArray = [NSMutableArray array];
        for (int j = 0; j < 10; j++) {
            [lineArray addObject:@([_map[i][j] integerValue])];
        }
        
        //单行写入
        [uiMapArray addObject:lineArray];
    }
    
    return uiMapArray;
    
}






@end
