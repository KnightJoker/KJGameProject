//
//  Engine.h
//  GameProject
//
//  Created by YYQ2B on 16/1/10.
//  Copyright © 2016年 YYQ2B. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Engine : NSObject


+ (id)shareInstances;

- (NSMutableArray *)getPicMap;

- (void)beginGamer;
- (void)nextGamer;
- (NSMutableArray *)refresh;

- (BOOL)find:(int [4])a;

- (NSMutableArray *)clear:(NSMutableArray *)map;

-(int)isConnectionWithItems:(int)firstRow
                     column:(int)firstColumn
                 secondItem:(int)secondRow
                     column:(int)secondColumn;

- (NSArray *)getGateList;

@end
