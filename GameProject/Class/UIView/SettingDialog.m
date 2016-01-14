//
//  SettingDialog.m
//  GameProject
//
//  Created by YYQ2B on 16/1/14.
//  Copyright © 2016年 YYQ2B. All rights reserved.
//

#import "SettingDialog.h"
#import "PublicDefine.h"

@interface SettingDialog ()
@property(nonatomic,strong)UIImageView *pause_bg;

@end

@implementation SettingDialog

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDialogUI];
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

@end
