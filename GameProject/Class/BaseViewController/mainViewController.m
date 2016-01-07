//
//  ViewController.m
//  GameProject
//
//  Created by YYQ2B on 16/1/5.
//  Copyright © 2016年 YYQ2B. All rights reserved.
//

#import "mainViewController.h"
#import "startViewController.h"
#import "settingViewController.h"
#import "PublicDefine.h"

@interface mainViewController ()

@end

@implementation mainViewController

#pragma mark - 生命周期(life circle)
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - 初始化(initiation)
- (void)initView {
    
    //背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //背景图片
    UIImageView* bg_view = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bg_view.image = [UIImage imageNamed:@"main-bg.png"];
    //设置背景图片是否可以点击
    bg_view.userInteractionEnabled = YES;
    [self.view addSubview:bg_view];
    
    //配置按钮
    [self initButtonOnView:bg_view];
    
}

- (void)initButtonOnView:(UIView *)view {
    
    //图片版开始按钮
    UIButton* startbtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-209) / 2, 300, 209,67)];
    [startbtn setImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
    
    //图片版继续按钮
    UIButton* continuebtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-209) / 2,400, 209, 67)];
    [continuebtn setImage:[UIImage imageNamed:@"continue.png"] forState:UIControlStateNormal];
    
    //图片版设置按钮
    UIButton* settingbtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-209)/2, 500, 209, 67)];
    [settingbtn setImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
    
    //按钮事件设置
    [startbtn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [continuebtn addTarget:self action:@selector(contine:) forControlEvents:UIControlEventTouchUpInside];
    [settingbtn addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
    
    //可视化设置
    [view addSubview:startbtn];
    [view addSubview:continuebtn];
    [view addSubview:settingbtn];
    
}

#pragma mark - 按钮响应(Button Actions)
#pragma mark 开始按钮
- (void)start:(id)sender{
    
    startViewController  *vc = [[startViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    /*导航条的隐藏*/
    [self.navigationController setNavigationBarHidden:YES];
    
    /*presentViewcontroller页面跳转*/
    //[self presentViewController:vc animated: YES completion:nil];
    //  [vc release];
}

#pragma mark 继续按钮
- (void)contine:(id)sender{
    NSLog(@"233333");
}

#pragma mark 设置按钮
- (void)setting:(id)sender{
    settingViewController *sc = [[settingViewController alloc] init];
    [self.navigationController pushViewController:sc animated:YES];
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark - 其他(others)
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
