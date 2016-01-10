//
//  startViewController.m
//  GameProject
//
//  Created by YYQ2B on 16/1/5.
//  Copyright © 2016年 YYQ2B. All rights reserved.
//

#import "StartViewController.h"
#import "MainViewController.h"
#import "MenuView.h"
#import "PublicDefine.h"

@interface StartViewController ()

@end

@implementation StartViewController

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
  //  self.view.backgroundColor = [UIColor blackColor];

 //   mainViewController  *vc = [[mainViewController alloc] init];
  //  [self.navigationController pushViewController:vc animated:YES];
  //  [self.navigationController setNavigationBarHidden:YES];
  //  [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化(initiation)

- (void)initUI{
    
    //背景图片
    UIImageView* bg_view = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bg_view.image = [UIImage imageNamed:@"gamerbg.png"];
    //设置背景图片是否可以点击
    bg_view.userInteractionEnabled = YES;
   
    //分数条背景的设置
    UIImageView* number = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-110)/2, 80, 110, 35)];
    
    number.image = [UIImage imageNamed:@"number_bg.png"];
    
    //分数条设置
    
    UILabel* number_label = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-110)/2+10, 80, 110, 35)];
    number_label.text = @"2333";
    number_label.backgroundColor = [UIColor clearColor];
    
    //可视化设置
    [self.view addSubview:bg_view];
    [bg_view addSubview:number];
    [bg_view addSubview:number_label];
    
    MenuView* menu = [[MenuView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40-40, SCREEN_WIDTH, 40)];
    [bg_view addSubview:menu];
}


















@end
