//
//  Engine.m
//  KWGamerDemo
//
//  Created by chinasofti-nate on 16/1/7.
//  Copyright © 2016年 chinasofti-nate. All rights reserved.
//

#import "Engine.h"

@interface Engine (){
    int map[10][10];
    NSMutableArray* _picMap;
    
}

@end

@implementation Engine

+(id)shareInstances{
    static Engine* instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[Engine alloc] init];
    });
    
    return instance;
}

-(id)init{
    self = [super init];
    
    if (self) {

        
    }
    return self;
}

-(void)beginGamer{
    [self initMap];
    [self initPicMap];
}

-(void)nextGamer{
    [self initMap];
    [_picMap removeAllObjects];
    [self initPicMap];
    
}

-(void)initMap{
    for (int i=0; i<10; i++) {
        for (int j=0; j<10; j++) {
            map[i][j] = -1;
        }
    }
}

/**
 *  <#Description#>
 */
-(void)initPicMap{
    _picMap = [NSMutableArray array];
    
    for (int index=0; index<64; index++) {
        int random = arc4random()%5+1;
        [_picMap insertObject:[NSNumber numberWithInt:random] atIndex:index];
        [_picMap insertObject:[NSNumber numberWithInt:random] atIndex:index++];
    }
#if 0
    int i=0;
    for (NSNumber* ob in _picMap) {
        i++;
        NSLog(@"ob=%d", [ob intValue]);
    }
    
    NSLog(@"i=%d",i);
#endif
}

/**
 *  获得引擎的数据结构
 *
 *  @param uiMap 通过参数返回数组
 */
-(void)getPicMap:(int [10][10])uiMap{
    
    int index = 64;
    
    for (int i=1; i<9; i++) {
        
        for (int j=1; j<9; j++) {
            
            int num = arc4random_uniform(index);
            map[i][j] = [[_picMap objectAtIndex:num] intValue];
            _picMap[num] = _picMap[--index];

        }
    }
    
    for (int i=0; i<10; i++) {
        for (int j=0; j<10; j++) {
            uiMap[i][j] = map[i][j];
        }
    }
    
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
    
    //判断2个元素的行值是否相等
    if (firstRow == secondRow) {
        //取得最大及最小值
        int column_min = firstColumn > secondColumn? secondColumn : firstColumn;
        int column_max = firstColumn > secondColumn? firstColumn : secondColumn;
        
        for (int j=column_min+1; j<column_max; j++) {
            if (map[firstRow][j] != -1) {
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
        
        for (int j=row_min+1; j<row_max; j++) {
            if (map[j][firstColumn] != -1) {
                return NO;
            }
        }
        
        return YES;
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
    
    if (map[firstRow][firstColumn] == -1 || map[secondRow][secondColumn] == -1 ||
        map[firstRow][firstColumn] != map[secondRow][secondColumn] ||
        ((firstRow == secondRow)&&(firstColumn == secondColumn))) {
        return 0;
    }
    if ([self linkBylinkToItems:firstRow column:firstColumn secondItem:secondRow column:secondColumn]) {
        map[firstRow][firstColumn] = -1;
        map[secondRow][secondColumn] = -1;
        return 1;
    }
    
    
    return 0;
    
}
@end



