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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //图片版开始按钮
    UIButton* startbtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-209)/2, 300, 209,67 )];
    [startbtn setImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
    
    //图片版继续按钮
    UIButton* continuebtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-209)/2,400, 209, 67)];
    [continuebtn setImage:[UIImage imageNamed:@"continue.png"] forState:UIControlStateNormal];
    
    //图片版设置按钮
    UIButton* settingbtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-209)/2, 500, 209, 67)];
    [settingbtn setImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
    
    //背景图片
    UIImageView* bg_view =[[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bg_view.image = [UIImage imageNamed:@"main-bg.png"];
    
    //设置背景图片是否可以点击
    bg_view.userInteractionEnabled = YES;
    
    //按钮事件设置
    [startbtn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [continuebtn addTarget:self action:@selector(contine:) forControlEvents:UIControlEventTouchUpInside];
    [settingbtn addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
    //可视化设置
    [self.view addSubview:bg_view];
    [bg_view addSubview:startbtn];
    [bg_view addSubview:continuebtn];
    [bg_view addSubview:settingbtn];

}

- (void)start:(id)sender{
    
    startViewController  *vc = [[startViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    /*导航条的隐藏*/
    [self.navigationController setNavigationBarHidden:YES];
    
    /*presentViewcontroller页面跳转*/
    //[self presentViewController:vc animated: YES completion:nil];
    //  [vc release];
}

- (void)contine:(id)sender{
    NSLog(@"233333");
}


- (void)setting:(id)sender{
    settingViewController *sc = [[settingViewController alloc] init];
    [self.navigationController pushViewController:sc animated:YES];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
