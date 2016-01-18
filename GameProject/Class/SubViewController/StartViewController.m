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
#import "SettingDialog.h"
#import "FailureDialog.h"

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

@interface StartViewController ()<MenuViewDelegate,SettingDialogDelegate,FailureDialogDelegate>{
    UILabel *_numberLabel;
    NSMutableArray *_uiMap;
    
    UIImageView *_firstView;
    UIImageView *_secondView;
    UIView *_gameView;
    
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

- (void)dealloc {
    //ARC时代，这个方法也是可以调用的，每个类最后一个执行的函数都是这个，当其被释放的时候
    //那么，通过断点判断这个类（ViewController）是否执行进这个函数，可以粗略判断这个类的内存是否安全
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[Engine shareInstances] beginGamer];
    [self initGamerParam];
    [self initUI];
    [self startTimerAtProgress:PROGRESS_TOTAL_LEN];
    //[self initPicItems];
}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    //注意，离开这个页面的时候，除非有需要让timer继续运行，否则必须要invalidate
    //否则你的timer会在后台一直跑，并且不会跑到你写的invalidate的方法内，导致这个页面的内存无法被释放
    [_timer invalidate];
    // [self.timer fire];
    //[self initUI];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化参数设置

- (void)initGamerParam{
    _gamerStatus = GamerStatusTypeStart;
    _firstRow = 0;
    _firstColumn = 0;
    _secondColumn = 0;
    _secondRow = 0;
    _uiMap = [NSMutableArray array];    //这个类型的数组必须先初始化才能赋值
    _uiMap = [[Engine shareInstances] getPicMap];
}

//背景初始化
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
    
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-110)/2+10, 80, 110, 35)];
    _numberLabel.text = @"0";
    _numberLabel.textColor = [UIColor yellowColor];
    _numberLabel.backgroundColor = [UIColor clearColor];
    
    //进度条设置
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(50,CGRectGetMaxY(_numberLabel.frame) + 15, SCREEN_WIDTH - 100, 100)];
    _progressView.progressViewStyle = UIProgressViewStyleDefault;
    _progressView.tintColor = [UIColor yellowColor];
    _progressView.progress = 1.0f;
    
    //可视化设置
    [self.view addSubview:bg_view];
    [bg_view addSubview:number];
    [bg_view addSubview:_numberLabel];
    [bg_view addSubview:_progressView];
    
    [self initPicItems];
    
}

//初始化图片
- (void)initPicItems{
    
    //背景图
    UIImageView* bg_view = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    // bg_view.image = [UIImage imageNamed:@"gamerbg.png"];
    bg_view.userInteractionEnabled = YES;
    [self.view addSubview:bg_view];
    
    //游戏点击区域
    [_gameView removeFromSuperview];    //先重置游戏区域（刷新需要）
    _gameView = [[UIView alloc] initWithFrame:bg_view.frame];    //因为你的坐标是针对bgView计算的，所以这个容器以bgView的frame为frame
    for (int i = 1; i < 9; i++) {
        for (int j = 1; j < 9; j++) {
            //int num = [_uiMap[i][j] integerValue];
            
            NSNumber* value = (NSNumber*)_uiMap[i][j];
            
            int num =  [value intValue];
            
            UIImageView* picView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_X + (j - 1) * PIC_W, MARGIN_Y + (i -1) * PIC_H, PIC_W, PIC_H)];
            
            NSString* imageName = [NSString stringWithFormat:@"fruit-%d", num];
            
            picView.image = [UIImage imageNamed:imageName];
            picView.userInteractionEnabled = YES;
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picItemsClicked:)];
            [picView addGestureRecognizer:tap];
            
            [_gameView addSubview:picView];  //将图片放到容器内
        }
    }
    [bg_view addSubview:_gameView];
    
    //菜单
    MenuView* menu = [[MenuView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40-40, SCREEN_WIDTH, 40)];
    menu.delegate = self;
    [bg_view addSubview:menu];
}

#pragma mark - 计时器周期
- (NSTimer *)startTimerAtProgress:(float)progress{
    
    //利用计时器，每1S调用一次
    _currectProgress = progress;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressView:)  userInfo:nil repeats:YES];
    
    return _timer;
} 

- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)updateProgressView:(id)sender{
//    __block BOOL flag;
    _currectProgress -= PROGRESS_STEP_LEN;
//    _currectProgress = -1;，，，
    if (_currectProgress < 0) {
        [self stopTimer];
        FailureDialog* dlg = [[FailureDialog alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
       dlg.tag = 20000;
        dlg.delegate = self;
        [self.view addSubview:dlg];
    }
    [_progressView setProgress:_currectProgress / PROGRESS_TOTAL_LEN  animated:YES];
    
//    if (_currectProgress < PROGRESS_TOTAL_LEN/4.0) {
//        _progressView.tintColor=[UIColor redColor];
//        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            flag = !flag;
//            _progressView.hidden = flag;
//        }completion:^(BOOL f){
//            
//        }];
//    
//    }
    
}


#pragma mark - 事件
- (void)picItemsClicked:(id)sender{
    NSLog(@"点击成功");
    if (sender && [sender isKindOfClass:[UITapGestureRecognizer class]]) {
        
        UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
        
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
                
                //选中放大
                [self scaleChangeForItem:_firstView isScaleUp:YES completion:nil];
                
            }
                break;
            case GamerStatusTypeEnd:
            {
                _gamerStatus = GamerStatusTypeStart;
                _secondRow = row;
                _secondColumn = column;
                
                _secondView = (UIImageView*)tap.view;
                
                //选中放大
                __weak typeof(self) weakSelf = self;
                [self scaleChangeForItem:_secondView isScaleUp:YES completion:^(BOOL finished) {
                    //动画完成后，连接检测
                    [weakSelf linkToLink];
                }];
                
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

//链接事件
- (void)linkToLink{
    
    int ret = [[Engine shareInstances] isConnectionWithItems:_firstRow
                                                      column:_firstColumn
                                                  secondItem:_secondRow
                                                      column:_secondColumn];
    
    if (ret != 0) {
        //先缩小，再消失
        [self scaleChangeForItem:_firstView isScaleUp:NO completion:nil];
        
        //注意：这个是iOS非常重要的点，在block中，一般情况下（除系统的block外），各种block内，对于类成员变量、类本身实例
        //的调用，都需要弱化。因为这些对象大多数默认为strong的，尤其是类本身，在block内部被执行的时候，会将自身引用计数器+1，
        //直到这个block被执行结束然后释放；但是，这个block又会等待自身内部的变量被释放，才会释放，而这个block内部有一个强
        //引用的self，最终导致：self在等block释放，block在等self释放，两个产生循环引用，最终导致内存不会被释放，出现内存泄漏。
        //故，需要将self拷贝到一个weak对象，weak意味着在调用后会立刻释放，那么就不会产生循环引用了。
        __weak typeof(self) weakSelf = self;
        [self scaleChangeForItem:_secondView isScaleUp:NO completion:^(BOOL finished) {
            [weakSelf modifyScore:ret];
            [weakSelf animationItems:ret rect:_secondView.frame];
            [weakSelf removePicItems];
        }];
        
    } else {
        //如果没有匹配成功，则缩小
        [self scaleChangeForItem:_firstView isScaleUp:NO completion:nil];
        [self scaleChangeForItem:_secondView isScaleUp:NO completion:nil];
    }
}

//消除图片
- (void)removePicItems{
    [_firstView removeFromSuperview];
    _firstView = nil;
    [_secondView removeFromSuperview];
    _secondView = nil;
}

//分数设置
- (void)modifyScore:(int)param{
    
    int currentNum = [_numberLabel.text intValue];
    
    int num = param * 100 + currentNum;
    
    [_numberLabel setText:[NSString stringWithFormat:@"%d",num]];
    
}

#pragma mark - 动画
- (void)scaleChangeForItem:(UIView *)view
                 isScaleUp:(BOOL)isScale
                completion:(void (^)(BOOL finished))completion{
    
    //这里completion是一个block，类似java的匿名函数，在执行完动画后，执行这个block；而block的声明在调用处声明即可（没有则为nil）
    [UIView animateWithDuration:0.1 animations:^{
        CGRect rect = view.frame;
        rect.size = CGSizeMake(isScale ? 58 : PIC_W, isScale ? 58 : PIC_H);
        CGPoint originCenter = view.center;
        view.frame = rect;
        view.center = originCenter;
    } completion:completion];
}

-(void)animationItems:(int)ret rect:(CGRect)rect{
    
    UILabel* label = [[UILabel alloc] initWithFrame:rect];
    label.backgroundColor = [UIColor clearColor];
    
    label.text = [NSString stringWithFormat:@"%d", ret*100];
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:label];
    
    [UIView animateWithDuration:1 animations:^{
        CGRect rt = label.frame;
        rt.origin.y -= 50;
        label.frame = rt;
    }completion:^(BOOL finished){
        [label removeFromSuperview];
    }];
}
    
#pragma mark - 代理

#pragma mark MenuView
- (void)pauseMenuClicked{
    
    NSLog(@"暂停");
    //停止计时器
    [self stopTimer];
    
    SettingDialog* dlg = [[SettingDialog alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    dlg.tag = 1;
    dlg.delegate = self;
    [self.view addSubview:dlg];
    
}

- (void)refreshMenuClicked{
    NSLog(@"刷新");
    //[[Engine shareInstances] nextGamer];
    _numberLabel.text = @"0";
    [self modifyScore:0];
    
    [self startTimerAtProgress:PROGRESS_TOTAL_LEN];
    
   // _uiMap = [[Engine shareInstances] clear:_uiMap];
    [_uiMap removeAllObjects];
    _uiMap = [NSMutableArray arrayWithArray:[[Engine shareInstances] refresh]];
    //_uiMap = [[Engine shareInstances] getPicMap];
    
    [_gameView removeFromSuperview];    //先重置游戏区域（刷新需要）
    _gameView = nil;
    
   // _uiMap = [[Engine shareInstances] getPicMap];
    
    [self initPicItems];
    
}

- (void)findMenuClicked{
    NSLog(@"发现");
//    NSMutableArray *tempArrey = [NSMutableArray array];
//    tempArrey = [[Engine shareInstances] find:_uiMap];
    int a[4];
    BOOL b = [[Engine shareInstances]find:a];
    
    if (b) {
        _firstRow = (int)a[0];
        _firstColumn = (int)a[1];
        _secondRow = (int)a[2];
        _secondColumn = (int)a[3];
        
        NSLog(@"%d",_firstRow);
        NSLog(@"%d",_firstColumn);
        NSLog(@"%d",_secondRow);
        NSLog(@"%d",_secondColumn);
    }

    //选中放大
   // [self scaleChangeForItem:_firstView isScaleUp:YES completion:nil];
    
}

#pragma mark SettingDialog
- (void)settingDialogDidClose{
    [self continuePlayGame];
}

- (void)settingDialogDidClickBack {
    [self pageJump];
}

- (void)settingDialogDidClickRefresh {
    [self refreshMenuClicked];
}

- (void)settingDialogDidClickResume {
    [self continuePlayGame];
}

//私有方法
- (void)pageJump{
    MainViewController* main = [[MainViewController alloc] init];
    [self.navigationController pushViewController:main animated:YES];
    /*导航条的隐藏*/
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)continuePlayGame {
    
    SettingDialog* dialog = (SettingDialog*)[self.view viewWithTag:1];
    [dialog removeFromSuperview];
    dialog = nil;
    
    //重启计时器
    [self startTimerAtProgress:_currectProgress];
}

#pragma mark FailureDialog
- (void)failureDialogBackClicked {
    [self pageJump];
}


- (void)failureDialogCloseDialog {
    FailureDialog* dialog = (FailureDialog*)[self.view viewWithTag:20000];
    [dialog removeFromSuperview];
    dialog = nil;
  //  [self performSelector:@selector(restartGamer)];
}


@end
