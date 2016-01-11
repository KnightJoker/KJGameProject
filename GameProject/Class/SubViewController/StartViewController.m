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
#import "Engine.h"

#define PIC_W   44
#define PIC_H   44

#define MARGIN_X  ((SCREEN_WIDTH - 44*8)/2)
#define MARGIN_Y  ((SCREEN_HEIGHT - 44*8)/2+18.5)

@interface StartViewController (){
    UILabel *_number_label;
    NSMutableArray *_uiMap;
    
    UIImageView *_firstView;
    UIImageView *_secondView;
    
    int _firstRow;
    int _firstColumn;
    int _secondRow;
    int _secondColumn;
}

@end

@implementation StartViewController

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [[Engine shareInstances] beginGamer];
   // [self initUI];
    [self initPicItems];
}


- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    //[self initUI];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 背景初始化(initiation)

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
    
    _number_label = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-110)/2+10, 80, 110, 35)];
    _number_label.text = @"2333";
    _number_label.backgroundColor = [UIColor clearColor];
    
    //可视化设置
    [self.view addSubview:bg_view];
    [bg_view addSubview:number];
    [bg_view addSubview:_number_label];
    
    MenuView* menu = [[MenuView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40-40, SCREEN_WIDTH, 40)];
    [bg_view addSubview:menu];
    
    [self initPicItems];
}


#pragma mark - 初始化图片

- (void)initPicItems{
    _uiMap = [NSMutableArray array];    //这个类型的数组必须先初始化才能赋值
    _uiMap = [[Engine shareInstances] getPicMap];
    
    for (int i = 1; i < 9; i++) {
        for (int j = 1; j < 9; j++) {
            //int num = [_uiMap[i][j] integerValue];
            NSInteger num = [_uiMap[i][j] integerValue];  //
            
            UIImageView* picView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_X + (j - 1 * PIC_W), MARGIN_Y + (i -1) * PIC_H, PIC_W, PIC_H)];
            
            NSString* imageName = [NSString stringWithFormat:@"fruit-%zi", num];
            
            picView.image = [UIImage imageNamed:imageName];
            
            picView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picItemsClicked:)];
            
            [picView addGestureRecognizer:tap];
            
            UIImageView* bg_view = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            bg_view.image = [UIImage imageNamed:@"gamerbg.png"];
            bg_view.userInteractionEnabled = YES;
            
            [self.view addSubview:bg_view];
            [bg_view addSubview:picView];
            
        }
    }
}


- (void)picItemsClicked:(id)sender{
    NSLog(@"点击成功");
}












@end
