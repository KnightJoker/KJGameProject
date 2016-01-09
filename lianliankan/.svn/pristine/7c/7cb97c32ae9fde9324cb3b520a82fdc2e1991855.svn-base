//
//  MenuView.m
//  KWGamerDemo
//
//  Created by chinasofti-nate on 16/1/7.
//  Copyright © 2016年 chinasofti-nate. All rights reserved.
//

#import "MenuView.h"

@interface MenuView ()

@end

@implementation MenuView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initWithMenuItems];
    }
    return self;
}

-(void)initWithMenuItems{
    
    int margin = (SCREEN_WIDTH-3*35)/4;
    
    UIImageView* pauseView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, 0, 35, 37)];
    pauseView.image = [UIImage imageNamed:@"pasue.png"];
    pauseView.userInteractionEnabled = YES;
    pauseView.tag = 1000;
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuClicked:)];
    
    [pauseView addGestureRecognizer:tap];
    
    [self addSubview:pauseView];
    
    UIImageView* refresh = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pauseView.frame)+margin, 0, 35, 37)];
    refresh.image = [UIImage imageNamed:@"refresh.png"];
    refresh.userInteractionEnabled = YES;
    refresh.tag = 2000;
    
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuClicked:)];
    
    [refresh addGestureRecognizer:tap1];
    
    [self addSubview:refresh];
    
    UIImageView* find = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(refresh.frame)+margin, 0, 35, 37)];
    find.image = [UIImage imageNamed:@"find.png"];
    find.userInteractionEnabled = YES;
    find.tag = 3000;
    
    UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuClicked:)];
    
    [find addGestureRecognizer:tap2];
    
    [self addSubview:find];
    
}

-(void)menuClicked:(id)sender{
    if (sender && [sender isKindOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer* tap = (UITapGestureRecognizer*)sender;
        
        UIView* view = tap.view;
        
        switch (view.tag) {
            case 1000:
                {
                    if (_delegate && [_delegate respondsToSelector:@selector(pauseMenuClicked)]) {
                        [_delegate pauseMenuClicked];
                    }
                }
                break;
            case 2000:
                {
                    if (_delegate && [_delegate respondsToSelector:@selector(refreshMenuClicked)]) {
                        [_delegate refreshMenuClicked];
                    }
                }
                break;
            case 3000:
                {
                    if (_delegate && [_delegate respondsToSelector:@selector(findMenuClicked)]) {
                        [_delegate findMenuClicked];
                    }
                }
                break;
                
            default:
                break;
        }
        
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
