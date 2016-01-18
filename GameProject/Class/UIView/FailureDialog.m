//
//  FailureDialog.m
//  GameProject
//
//  Created by YYQ2B on 16/1/18.
//  Copyright © 2016年 YYQ2B. All rights reserved.
//


#import "FailureDialog.h"
#import "PublicDefine.h"


#define BACK_BUTTON_TAG 1000
#define RESTART_BUTTON_TAG 2000

@interface FailureDialog ()

@property(nonatomic, strong)UIImageView* over_bg;
@property(nonatomic, strong)UIImageView* pause_bg;


@end

@implementation FailureDialog

int margin = (200 - 37 * 3) / 4;


- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initDialogUI];
        
        [self initButten:CGRectMake(MUSIC_WISTH+margin-5,MUSIC_HEIGHT+130-25 ,37,37)image:@"back.png" tag:BACK_BUTTON_TAG];
        
        [self initButten:CGRectMake(MUSIC_WISTH+200-3*margin,MUSIC_HEIGHT+130-25,37,37)image:@"regroup.png" tag:RESTART_BUTTON_TAG];
    }
    
    
    return self;
    
}

- (void)initDialogUI{
    UIView* mbView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    mbView.backgroundColor = [UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:.7];
    [self addSubview:mbView];
    
    _over_bg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-298)/2, -70, 298, 66)];
    _over_bg.image = [UIImage imageNamed: @"over.png"];
    [self addSubview:_over_bg];
    
    [UIView animateWithDuration:2.0
                          delay:0.0
         usingSpringWithDamping:0.25
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGRect rt = _over_bg.frame;
                         rt.origin.y += (SCREEN_HEIGHT-130)/2+20;
                         _over_bg.frame = rt;
                     }
                     completion:NULL];
    
}
- (void)initButten:(CGRect)rect image:(NSString*)imageName tag:(int)btnTag{
    
    UIButton* btn = [[UIButton alloc] initWithFrame:rect];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btn.tag = btnTag;
    [btn addTarget:self action:@selector(imageClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    btn.alpha = 0;
    
    [UIView animateWithDuration:3.0
                     animations:^{
                         btn.alpha = 1.0;
                     }];
}

- (void)imageClicked:(id)sender {
    
    if (sender && [sender isKindOfClass:[UIButton class]]) {
        UIButton* btn = (UIButton*)sender;
        switch (btn.tag) {
            case BACK_BUTTON_TAG:
            {
                if (_delegate&&[_delegate respondsToSelector:@selector(failureDialogBackClicked)]) {
                    [_delegate failureDialogBackClicked];
                    
                }
                break;
            case RESTART_BUTTON_TAG:
                {
                    if (_delegate && [_delegate respondsToSelector:@selector(failureDialogCloseDialog)])
                    {
                        [_delegate failureDialogCloseDialog];
                    }
                    
                }
                break;
            }
            default:
                break;
        }
        
    }
}


@end
