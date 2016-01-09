//
//  MenuView.m
//  GameProject
//
//  Created by YYQ2B on 16/1/8.
//  Copyright © 2016年 YYQ2B. All rights reserved.
//

#import "MenuView.h"
#import "PublicDefine.h"

@interface MenuView()

@end

@implementation MenuView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initWithMenuItems];
    }
    return self;
}

#pragma mark - 自定义控件

- (void)initWithMenuItems{
    
    int margin = (SCREEN_WIDTH - 3 * 35) / 4;
    
    //暂停按钮
    UIImageView* pause = [[UIImageView alloc] initWithFrame:CGRectMake(margin, 0, 35, 37)];
    pause.image = [UIImage imageNamed:@"pasue.png"];
    
    //刷新按钮
    UIImageView* refresh = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pause.frame)+margin, 0, 35, 37)];
    refresh.image = [UIImage imageNamed:@"refresh.png"];
    
    //查找按钮
    UIImageView* find = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(refresh.frame)+margin, 0, 35, 37)];
    find.image = [UIImage imageNamed:@"find.png"];
    
    //设置是否可以进行点击
    pause.userInteractionEnabled = YES;
    refresh.userInteractionEnabled = YES;
    find.userInteractionEnabled = YES;
    
    //按钮点击事件的设置
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pauseMenuClicked:)];
    [pause addGestureRecognizer:tap];
    
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshMenuClicked:)];
    [refresh addGestureRecognizer:tap1];
    
    UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(findMenuClicked:)];
    [find addGestureRecognizer:tap2];
    
    //按钮的可视化
    [self addSubview:pause];
    [self addSubview:refresh];
    [self addSubview:find];
    
}



- (void) pauseMenuClicked:(id)sender{
    NSLog(@"暂停");
}

- (void) refreshMenuClicked:(id)sender{
    NSLog(@"刷新");
}


- (void) findMenuClicked:(id)sender{
    NSLog(@"发现");
}





@end
