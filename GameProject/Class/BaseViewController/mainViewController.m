//
//  ViewController.m
//  GameProject
//
//  Created by YYQ2B on 16/1/5.
//  Copyright © 2016年 YYQ2B. All rights reserved.
//

#import "mainViewController.h"
#import "startViewController.h"
#import "PublicDefine.h"

@interface mainViewController ()

@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //开始按键
    UIButton* startBn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    //CGRectMake(x,y,a,b) x,y为矩形的坐标；a,b为矩形的长宽
    startBn.frame = CGRectMake(155, 300,100, 60);
    
    [startBn setTitle:@"开始游戏"
             forState:UIControlStateNormal];
    //按钮文字距离边框的位置
    [startBn setTitleEdgeInsets:UIEdgeInsetsMake(5,5,5,5)];
    //按钮背景色
    [startBn setBackgroundColor:UIColor.darkGrayColor];
    
    //图片版开始按钮
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-209)/2, 300, 209,67 )];
    [btn setImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
    
    
    //背景图片
    UIImageView* bg_view =[[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bg_view.image = [UIImage imageNamed:@"main-bg.png"];
    //设置背景图片是否可以点击
    bg_view.userInteractionEnabled = YES;
    
    //开始按钮事件设置
    [startBn addTarget:self action:@selector(start:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [btn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    
    //可视化设置
    [self.view addSubview:bg_view];
    [bg_view addSubview:btn];
    //[self.view addSubview:startBn];
}
- (void)start:(id)sender{
    
    startViewController  *vc = [[startViewController alloc] init];
    [self presentViewController:vc animated: YES completion:nil];
   // [self.navigationController pushViewController:vc animated:YES];
    
    //  [vc release];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
