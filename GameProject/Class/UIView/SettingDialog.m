//
//  SettingDialog.m
//  GameProject
//
//  Created by YYQ2B on 16/1/14.
//  Copyright © 2016年 YYQ2B. All rights reserved.
//

#import "SettingDialog.h"
#import "PublicDefine.h"
#import "MainViewController.h"

@interface SettingDialog ()
@property(nonatomic,strong)UIImageView *pause_bg;

@end

@implementation SettingDialog

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDialogUI];
        [self addMySlider:0];
        [self addMySlider:45];
        [self initButtonwithCGRect];
    }
    return self;
}

#pragma mark - 初始化对话框
- (void)initDialogUI{
    
    UIView *mbView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    mbView.backgroundColor = [UIColor colorWithRed:236 / 255.0 green:236 / 255.0 blue:236 / 255.0 alpha:.7];
    [self addSubview:mbView];
    
    _pause_bg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200) / 2, (SCREEN_HEIGHT - 130) / 2, 200, 130)];
    _pause_bg.image = [UIImage imageNamed:@"pause_bg.png"];
    
    [mbView addSubview:_pause_bg];
}


#pragma mark - touch事件设置
- (void)dialogTap:(id)sender{
    if (sender && [sender isKindOfClass:[UITapGestureRecognizer class]]) {
        
        UITapGestureRecognizer* tap = (UITapGestureRecognizer*)sender;
        
        UIView* tapView = tap.view;
        
        switch (tapView.tag) {
            case 1000:
            {
                if (_delegate && [_delegate respondsToSelector:@selector(settingDialogDidClose)]) {
                    [_delegate settingDialogDidClose];
                }
            }
                break;
                
            default:
                break;
        }
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    
    CGPoint pt = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    if (CGRectContainsPoint(_pause_bg.frame, pt)) {
        NSLog(@"23333");
    }
    else
    {
        if (_delegate && [_delegate respondsToSelector:@selector(settingDialogDidClose)]) {
            [_delegate settingDialogDidClose];
        }
    }
    
}


#pragma mark - 按键的基本设置

- (void)initButtonwithCGRect{
    
    int margin1 =(200 - 37 * 3) / 4;
    UIButton *music = [[UIButton alloc] initWithFrame:CGRectMake(MUSIC_WISTH,MUSIC_HEIGHT+6 , 37, 37)];
    [music setImage:[UIImage imageNamed:@"music.png"] forState:UIControlStateNormal];
    [music addTarget:self action:@selector(imageClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:music];
    music.tag = 3000;
    
    UIButton *sound = [[UIButton alloc] initWithFrame:CGRectMake(MUSIC_WISTH,MUSIC_HEIGHT+130-80 , 37, 37)];
    [sound setImage:[UIImage imageNamed:@"sound.png"] forState:UIControlStateNormal];
    [sound addTarget:self action:@selector(imageClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sound];
    sound.tag = 4000;
    
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(MUSIC_WISTH+margin1-5,MUSIC_HEIGHT+130-25 , 37, 37)];
    [back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(imageClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:back];
    back.tag = 5000;
    
    
    UIButton *regroup = [[UIButton alloc] initWithFrame:CGRectMake(MUSIC_WISTH+2*margin1+37-5,MUSIC_HEIGHT+130-25 , 37, 37)];
    [regroup setImage:[UIImage imageNamed:@"regroup.png"] forState:UIControlStateNormal];
    [regroup addTarget:self action:@selector(imageClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:regroup];
    regroup.tag = 6000;
    
    UIButton* continuegame = [[UIButton alloc] initWithFrame:CGRectMake(MUSIC_WISTH+200-3*margin1,MUSIC_HEIGHT+130-25 , 37, 37)];
    [continuegame setImage:[UIImage imageNamed:@"continuegame.png"] forState:UIControlStateNormal];
    [continuegame addTarget:self action:@selector(imageClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:continuegame];
    continuegame.tag = 7000;
    
    
}
//滑动条
-(void)addMySlider:(int) i{
    //滑块图片
    UIImage *thumbImage = [UIImage imageNamed:@"slider_03.png"];
    
    
    UISlider *sliderA=[[UISlider alloc]initWithFrame:CGRectMake(MUSIC_WISTH+37,MUSIC_HEIGHT +i, 130, 50)];
    sliderA.backgroundColor = [UIColor clearColor];
    sliderA.value=0.5;
    sliderA.minimumValue=0.0;
    sliderA.maximumValue=1.0;
    sliderA.minimumTrackTintColor = [UIColor yellowColor];
    sliderA.maximumTrackTintColor = [UIColor whiteColor];
    
    //注意这里要加UIControlStateHightlighted的状态，否则当拖动滑块时滑块将变成原生的控件
    [sliderA setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [sliderA setThumbImage:thumbImage forState:UIControlStateNormal];
    //滑块拖动时的事件
    [sliderA addTarget:self action:@selector(sliderValueChanged) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:sliderA];
    
    
}

#pragma mark - 按钮事件设置

-(void)sliderValueChanged{
    
    NSLog(@"sliderValueChanged");
    
}
- (void)imageClicked:(id)sender {
    
    if (sender && [sender isKindOfClass:[UIButton class]]) {
        UIButton* btn = (UIButton*)sender;
        
        switch (btn.tag) {
            case 3000:
            {
                NSLog(@"1");
            }
                break;
            case 4000:
            {
                NSLog(@"2");
            }
                break;
            case 5000:
            {
                if (_delegate&&[_delegate respondsToSelector:@selector(pageJump)]) {
                    [_delegate pageJump];
                }
            }
                break;
            default:
                break;
        }
    }
}


@end
