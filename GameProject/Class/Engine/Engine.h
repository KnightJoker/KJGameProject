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

- (void)getPicMap:(int [10][10]) uiMap;

- (void)beginGamer;
- (void)nextGamer;

@end
