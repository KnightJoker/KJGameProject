//
//  Engine.h
//  KWGamerDemo
//
//  Created by chinasofti-nate on 16/1/7.
//  Copyright © 2016年 chinasofti-nate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Engine : NSObject

+(id)shareInstances;

-(void)getPicMap:(int [10][10])uiMap;

/**
 *  <#Description#>
 */
-(void)beginGamer;
/**
 *  <#Description#>
 */
-(void)nextGamer;

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
