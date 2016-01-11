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

/**
 *  <#Description#>
 *
 *  @param firstRow     <#firstRow description#>
 *  @param firstColumn  <#firstColumn description#>
 *  @param secondRow    <#secondRow description#>
 *  @param secondColumn <#secondColumn description#>
 *
 *  @return <#return value description#>
 */
-(int)isConnectionWithItems:(int)firstRow
                     column:(int)firstColumn
                 secondItem:(int)secondRow
                     column:(int)secondColumn;

@end
