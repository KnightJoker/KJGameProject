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

#define PIC_W   47
#define PIC_H   47

#define MARGIN_X  ((SCREEN_WIDTH - 47*8)/2)
#define MARGIN_Y  ((SCREEN_HEIGHT - 47*8)/2+18.5)

#define PROGRESS_TOTAL_LEN (SCREEN_WIDTH - 100.0)
#define PROGRESS_STEP_LEN (PROGRESS_TOTAL_LEN/120.0)

typedef NS_ENUM(NSInteger, GamerStatusType){
    GamerStatusTypeNone,
    GamerStatusTypeStart,
    GamerStatusTypePause,
    GamerStatusTypeEnd,
    GamerStatusTypeFinished,
    GamerStatusTypeGamerOver,
    GamerStatusTypeContinue,
    GamerStatusTypeMax,
};

@interface StartViewController (){
    UILabel *_number_label;
    NSMutableArray *_uiMap;
    
    UIImageView *_firstView;
    UIImageView *_secondView;
    
    int _firstRow;
    int _firstColumn;
    int _secondRow;
    int _secondColumn;
    
    CGFloat _currectProgress;//记录当前的进度条
    UIProgressView *_progressView;
    NSTimer *_timer;//计时器
    
}


@property(nonatomic, assign)GamerStatusType gamerStatus;
@end

@implementation StartViewController

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [[Engine shareInstances] beginGamer];
    [self initGamerParam];
    [self initUI];
    //[self initPicItems];
}


- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    //[self initUI];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -初始化游戏界面

- (void)initGamerParam{
    _gamerStatus = GamerStatusTypeStart;
    _firstRow = 0;
    _firstColumn = 0;
    _secondColumn = 0;
    _secondRow = 0;
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
    _number_label.text = @"0";
    _number_label.textColor = [UIColor yellowColor];
    _number_label.backgroundColor = [UIColor clearColor];
    
    //进度条设置
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(50,CGRectGetMaxY(_number_label.frame) + 15, SCREEN_WIDTH - 100, 100)];
    _progressView.progressViewStyle = UIProgressViewStyleDefault;
    _progressView.tintColor = [UIColor yellowColor];
    _progressView.progress = 1.0f;
    
    //利用计时器，每1S调用一次
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressView:)  userInfo:nil repeats:YES];
    
    //可视化设置
    [self.view addSubview:bg_view];
    [bg_view addSubview:number];
    [bg_view addSubview:_number_label];
    [bg_view addSubview:_progressView];
   // [_timer fire];

    [self initPicItems];
   // [self progresssView];
}


#pragma mark - 初始化图片

- (void)initPicItems{
    _uiMap = [NSMutableArray array];    //这个类型的数组必须先初始化才能赋值
    _uiMap = [[Engine shareInstances] getPicMap];
    
    UIImageView* bg_view = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
   // bg_view.image = [UIImage imageNamed:@"gamerbg.png"];
    bg_view.userInteractionEnabled = YES;
    
    [self.view addSubview:bg_view];
    
    for (int i = 1; i < 9; i++) {
        for (int j = 1; j < 9; j++) {
            //int num = [_uiMap[i][j] integerValue];
            NSInteger num = [_uiMap[i][j] integerValue];  //
            
            UIImageView* picView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_X + (j - 1) * PIC_W, MARGIN_Y + (i -1) * PIC_H, PIC_W, PIC_H)];
            
            NSString* imageName = [NSString stringWithFormat:@"fruit-%zi", num];
            
            picView.image = [UIImage imageNamed:imageName];
            
            picView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picItemsClicked:)];
            
            [picView addGestureRecognizer:tap];
            
            [bg_view addSubview:picView];
            
        }
    }
    
    
    MenuView* menu = [[MenuView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40-40, SCREEN_WIDTH, 40)];
    [bg_view addSubview:menu];
}


#pragma mark -事件设置

- (void)picItemsClicked:(id)sender{
    NSLog(@"点击成功");
    if (sender && [sender isKindOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer* tap = (UITapGestureRecognizer*)sender;
        
        CGRect rect = tap.view.frame;
        
        //计算元素所在的行列
        int row = (rect.origin.y - MARGIN_Y)/PIC_H + 1;
        int column = (rect.origin.x - MARGIN_X)/PIC_W + 1;
        
//        NSLog(_gamerStatus);
        switch (_gamerStatus) {
            case GamerStatusTypeStart:
            {
                _gamerStatus = GamerStatusTypeEnd;
                _firstRow = row;
                _firstColumn = column;
                
                _firstView = (UIImageView*)tap.view;
                
                [UIView animateWithDuration:1. animations:^{
                    CGRect rect = _firstView.frame;
                    rect.size = CGSizeMake(48, 48);
                    _firstView.frame = rect;
                }];
                
            }
                break;
            case GamerStatusTypeEnd:
            {
                _gamerStatus = GamerStatusTypeStart;
                _secondRow = row;
                _secondColumn = column;
                
                _secondView = (UIImageView*)tap.view;
                
                [self linkToLink];
                
            }
                break;
            case GamerStatusTypeFinished:
            {
                
            }
                break;
            default:
                break;
        }
        
        
    }
    

}

#pragma mark 链接事件

- (void)linkToLink{
    int ret = [[Engine shareInstances] isConnectionWithItems:_firstRow
                                                      column:_firstColumn
                                                  secondItem:_secondRow
                                                      column:_secondColumn];
    
    if (ret != 0) {
        [self modifyScore:ret];
        [self removePicItems];
    }
}

#pragma mark 消除图片
- (void)removePicItems{
    [_firstView removeFromSuperview];
    _firstView = nil;
    [_secondView removeFromSuperview];
    _secondView = nil;
}

#pragma mark 分数设置

- (void)modifyScore:(int)param{
    
    int currentNum = [_number_label.text intValue];
    
    int num = param * 100 + currentNum;
    
    [_number_label setText:[NSString stringWithFormat:@"%d",num]];

}

#pragma mark 进度条事件
- (void)updateProgressView:(id)sender{
    
    _currectProgress -= PROGRESS_STEP_LEN;
    
    if (_currectProgress < 0) {
        [_timer invalidate];
        _timer = nil;
    }
    [_progressView setProgress:_currectProgress - 100 animated:YES];

}

@end
