//
//  settingViewController.m
//  GameProject
//
//  Created by YYQ2B on 16/1/7.
//  Copyright © 2016年 YYQ2B. All rights reserved.
//

#import "settingViewController.h"
#import "PublicDefine.h"
#import "mainViewController.h"




@interface settingViewController()

@end

@implementation settingViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    
    //背景图片设置
    UIImageView* bg_view =[[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bg_view.image = [UIImage imageNamed:@"gamerbg.png"];
    
    //设置背景图片是否可以点击
    bg_view.userInteractionEnabled = YES;
    
    //按钮设置
    UIButton* back = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/3, 37, 37)];
    [back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    
    
    //按钮事件设置
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //可视化操作
    [self.view addSubview:bg_view];
    [bg_view addSubview:back];
}


- (void)back:(id)sender{
    mainViewController  *vc = [[mainViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    /*导航条的隐藏*/
    [self.navigationController setNavigationBarHidden:YES];
    
}




@end
