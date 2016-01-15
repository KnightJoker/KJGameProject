//
//  settingViewController.m
//  GameProject
//
//  Created by YYQ2B on 16/1/7.
//  Copyright © 2016年 YYQ2B. All rights reserved.
//

#import "SettingViewController.h"
#import "PublicDefine.h"
#import "MainViewController.h"




@interface SettingViewController()

@end

@implementation SettingViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - 初始化
- (void)initUI{
    //背景图片设置
    UIImageView* bg_view =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bg_view.image = [UIImage imageNamed:@"gamerbg.png"];
    
    //设置背景图片是否可以点击
    bg_view.userInteractionEnabled = YES;
    
    //按钮设置
    UIButton* back = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5.5 + 10, SCREEN_HEIGHT/2.5 + 160, 37, 37)];
    [back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    
    UIButton* regroup = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5.5 + 100, SCREEN_HEIGHT/2.5 + 160, 37, 37)];
    [regroup setImage:[UIImage imageNamed:@"regroup.png"] forState:UIControlStateNormal];
    
    UIButton* continuegame =[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5.5 + 190, SCREEN_HEIGHT/2.5 + 160, 37, 37)];
    [continuegame setImage:[UIImage imageNamed:@"continuegame.png"] forState:UIControlStateNormal];
    
    //按钮事件设置
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [regroup addTarget:self action:@selector(regroup:) forControlEvents:UIControlEventTouchUpInside];
    
    [continuegame addTarget:self action:@selector(continuegame:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置栏背景
    UIImageView* pause_bg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5.5, SCREEN_HEIGHT/2.5, 250, 200)];
    pause_bg.image = [UIImage imageNamed:@"pause_bg.png"];
    
    //音乐和音效界面设置
    UIImageView* music = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5.5 + 10, SCREEN_HEIGHT/2.5 + 20, 37, 37)];
    music.image = [UIImage imageNamed:@"music.png"];
    
    UIImageView* sound = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5.5 + 10, SCREEN_HEIGHT/2.5 + 100, 37, 37)];
    sound.image = [UIImage imageNamed:@"sound.png"];
    
    //滑动条设置
    UISlider* slider = [[UISlider alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/5.5 + 10, SCREEN_HEIGHT/2.5 + 20, 20, 30)];
    slider.minimumValue = 100;
    slider.maximumValue = 500;
    slider.value = 20;
    slider.backgroundColor = [UIColor clearColor];
    [slider setMinimumTrackImage:[UIImage imageNamed:@"slider_03.png"]
                        forState:UIControlStateNormal];
    slider.minimumTrackTintColor = [UIColor yellowColor];
    slider.maximumTrackTintColor = [UIColor whiteColor];
    //slider.minimumValueImage = [UIImage imageNamed:@"slider_03"];
    
    //滑动条事件设置
    [slider addTarget:self action:@selector(updateslider:) forControlEvents:UIControlEventValueChanged];
    
    //可视化操作
    [self.view addSubview:bg_view];
    
    [bg_view addSubview:pause_bg];
    [bg_view addSubview:back];
    [bg_view addSubview:regroup];
    [bg_view addSubview:continuegame];
    
    [bg_view addSubview:music];
    [bg_view addSubview:sound];
    
    [bg_view addSubview:slider];

}
#pragma mark - 按钮响应(Button Actions)

#pragma mark - 返回按钮
- (void)back:(id)sender{
    MainViewController  *vc = [[MainViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    /*导航条的隐藏*/
    [self.navigationController setNavigationBarHidden:YES];
    
}

#pragma mark - 刷新按钮
- (void)regroup:(id)sender{
    NSLog(@"刷新");
}

#pragma mark - 继续游戏按钮
- (void)continuegame:(id)sender{
    NSLog(@"继续游戏");
}

#pragma mark - 滑动条
- (void)updateslider:(id)sender{
   // NSLog(@"已经滑动");
  
}

@end
