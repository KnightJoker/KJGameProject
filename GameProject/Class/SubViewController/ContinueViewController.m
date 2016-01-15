//
//  ContinueViewController.m
//  GameProject
//
//  Created by YYQ2B on 16/1/15.
//  Copyright © 2016年 YYQ2B. All rights reserved.
//

#import "ContinueViewController.h"
#import "MainViewController.h"
#import "PublicDefine.h"
#import "Engine.h"

//随机色
#define RANDOM_COLOR ([UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0])

@interface ContinueViewController()<UIScrollViewDelegate>

@property(nonatomic,strong)UIButton *backBtn;

@property(nonatomic,strong)UIScrollView *scrollView;


@end



@implementation ContinueViewController


#pragma mark - 生命周期

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.backBtn];
    
    [self.view addSubview:self.scrollView];
    
    [self initGameGate];
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

}

#pragma  mark - 按钮和屏幕滑动视界

//返回按钮
- (UIButton *)backBtn{
   
    if (_backBtn == nil) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 44, 44)];
        [_backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        
        [_backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _backBtn;
}

- (void)backBtnClicked:(id)sender{
    MainViewController  *vc = [[MainViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    /*导航条的隐藏*/
    [self.navigationController setNavigationBarHidden:YES];
}

//滑动视图

- (UIScrollView *)scrollView{
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.contentOffset = CGPointZero;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}


#pragma mark - 初始化关卡

- (void)initGameGate{
    
    NSArray *list = [[Engine shareInstances] getGateList];
    NSUInteger count = [list count];
    int page = (int)(count / 20);
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * page, _scrollView.frame.size.height);
    
    for (int index = 0; index < page; index++) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(index * SCREEN_WIDTH, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
        
        bgView.backgroundColor = RANDOM_COLOR;
        
        int rate_column = 0;
        
        for (int i = 0; i < 20; i++) {
            int num = [[list objectAtIndex:i + index * 20] intValue];
            
            UIImageView *gateView = nil;
            CGRect rect;
            
            int rate_row = i % 4;
            if (rate_row == 0 && i > 0) {
                rate_column++;
            }
            
            int space_x = (SCREEN_WIDTH - 4 * 50) / 5;
            int space_y = 0;
            
            if (num == 0) {
                gateView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LevelOpen.png"]];
                space_y = ((bgView.frame.size.height - 35) - 5 * 58) / 6;
                rect = CGRectMake(space_x * (rate_row + 1) + rate_row * 50, space_y * (rate_column + 1) + rate_column * 58, 50, 58);
                gateView.frame = rect;
                
                
            }else{
                gateView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LevelLock.png"]];
                space_y = ((bgView.frame.size.height - 35) - 5 * 50) / 6;
                rect = CGRectMake(space_x * (rate_row + 1) + rate_row * 50, space_y * (rate_column + 1) + rate_column * 50, 50, 50);
                gateView.frame = rect;
            }
            [bgView addSubview:gateView];
        }
        [self.scrollView  addSubview:bgView];
    }

}




























@end



