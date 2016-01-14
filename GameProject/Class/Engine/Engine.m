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
    [_map removeAllObjects];
    [_picMap removeAllObjects];
    [self initMap];
    [self initPicMap];
}

- (NSMutableArray*)refresh:(NSMutableArray *)map{
    
    NSNumber *number = [NSNumber numberWithInt:-1];
    NSNumber *index = [NSNumber numberWithInt:(arc4random_uniform(64))];
    for (int i = 1; i < 9; i++) {
        for (int j = 1; j < 9; j++) {
            if (map[i][j] != number) {
                map[i][j] = index;
            }
        }
    }
    return map;
}

- (BOOL)find:(NSMutableArray *)map{
    
    
    return YES;
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

/** 判断2个点是否 再一条直线上
 @param firstRow 第一个元素的行值
 @param firstColumn 第一个元素的列值
 @param secondRow 第二个元素的行值
 @param secondColumn 第二个元素的列值
 
 @return BOOL 如果返回YES，代表可以消除
 */
-(BOOL)linkBylinkToItems:(int)firstRow
                  column:(int)firstColumn
              secondItem:(int)secondRow
                  column:(int)secondColumn{
    
    NSNumber *number = [NSNumber numberWithInt:-1];
    //判断2个元素的行值是否相等
    if (firstRow == secondRow) {
        //取得最大及最小值
        int column_min = firstColumn > secondColumn? secondColumn : firstColumn;
        int column_max = firstColumn > secondColumn? firstColumn : secondColumn;
        
        for (int j = column_min + 1; j < column_max; j++) {
          
            if (_map[firstRow][j] != number) {
                return NO;
            }
        }
        
        return YES;
    }
    
    //判断2个元素的列值是否相等
    if (firstColumn == secondColumn) {
        //取得最大及最小值
        int row_min = firstRow > secondRow ? secondRow : firstRow;
        int row_max = firstRow > secondRow ? firstRow : secondRow;
        
        for (int j = row_min + 1; j < row_max; j++) {
            if (_map[j][firstColumn] != number) {
                return NO;
            }
        }
        
        return YES;
    }
    
    return NO;
    
}

/**
 *  判断2个元素是否能通过一次转折连接
 *
 @param firstRow 第一个元素的行值
 @param firstColumn 第一个元素的列值
 @param secondRow 第二个元素的行值
 @param secondColumn 第二个元素的列值
 
 @return BOOL 如果返回YES，代表可以消除，否则－－－－－
 */
-(BOOL)linkByOneTurnWithItms:(int)firstRow
                      column:(int)firstColumn
                  secondItem:(int)secondRow
                      column:(int)secondColumn{
    
    //通过一折消去，折点是固定的(firstRow,secondColumn)及 (secondRow，firstColumn)
     NSNumber *number = [NSNumber numberWithInt:-1];
    
    if (_map[firstRow][secondColumn] == number && [self linkBylinkToItems:firstRow column:secondColumn secondItem:firstRow column:firstColumn] && [self linkBylinkToItems:firstRow column:secondColumn secondItem:secondRow column:secondColumn]) {
        
        return YES;
    }
    
    if (_map[secondRow][firstColumn] == number && [self linkBylinkToItems:secondRow column:firstColumn secondItem:firstRow column:firstColumn] && [self linkBylinkToItems:secondRow column:firstColumn secondItem:secondRow column:secondColumn]) {
        return YES;
    }
    
    return NO;
}


/**
 *  判断2个元素是否能通过2次转折连接
 *
 @param firstRow 第一个元素的行值
 @param firstColumn 第一个元素的列值
 @param secondRow 第二个元素的行值
 @param secondColumn 第二个元素的列值
 
 @return BOOL 如果返回YES，代表可以消除，否则－－－－－
 */
-(BOOL)linkByTwoTurnWithItms:(int)firstRow
                      column:(int)firstColumn
                  secondItem:(int)secondRow
                      column:(int)secondColumn{
    
    NSNumber *number = [NSNumber numberWithInt:-1];
    
    for (int row = 0; row < 10; row++) {
        if (_map[row][firstColumn] == number && [self linkBylinkToItems:row column:firstColumn secondItem:firstRow column:firstColumn] && [self linkByOneTurnWithItms:row column:firstColumn secondItem:secondRow column:secondColumn]) {
            return YES;
        }
    }
    
    for (int column = 0; column < 10; column++) {
        if (_map[firstRow][column] == number && [self linkBylinkToItems:firstRow column:column secondItem:firstRow column:firstColumn] && [self linkByOneTurnWithItms:firstRow column:column secondItem:secondRow column:secondColumn]) {
            return YES;
        }
    }
    return NO;
}


/** 2个元素是否能连接
 @param firstRow 第一个元素的行值
 @param firstColumn 第一个元素的列值
 @param secondRow 第二个元素的行值
 @param secondColumn 第二个元素的列值
 
 @return int
 @ 返回为了“0”，代表链接失败，否则链接成功（ “1” 代表是直线链接，“2” 代表是一折链接，“3” 代表是两折链接 ）
 
 */
-(int)isConnectionWithItems:(int)firstRow
                     column:(int)firstColumn
                 secondItem:(int)secondRow
                     column:(int)secondColumn{
    
    NSNumber *number = [NSNumber numberWithInt:-1];
    
    if (_map[firstRow][firstColumn] == number || _map[secondRow][secondColumn] == number ||
        _map[firstRow][firstColumn] != _map[secondRow][secondColumn] ||
        ((firstRow == secondRow)&&(firstColumn == secondColumn))) {
        
        return 0;
        
    }
    if ([self linkBylinkToItems:firstRow column:firstColumn secondItem:secondRow column:secondColumn]) {
        
        _map[firstRow][firstColumn] = number;
        _map[secondRow][secondColumn] = number;
        
        return 1;
    }
    
    if ([self linkByOneTurnWithItms:firstRow column:firstColumn secondItem:secondRow column:secondColumn]) {
        _map[firstRow][firstColumn] = number;
        _map[secondRow][secondColumn] = number;
        return 2;
    }
    
    if ([self linkByTwoTurnWithItms:firstRow column:firstColumn secondItem:secondRow column:secondColumn]) {
        _map[firstRow][firstColumn] = number;
        _map[secondRow][secondColumn] = number;
        return 3;
    }
    
    return 0;
    
}



@end
