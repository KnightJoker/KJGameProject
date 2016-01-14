//
//  MenuView.h
//  GameProject
//
//  Created by YYQ2B on 16/1/8.
//  Copyright © 2016年 YYQ2B. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewDelegate <NSObject>

- (void)pauseMenuClicked;
- (void)refreshMenuClicked;
- (void)findMenuClicked;

@end

@interface MenuView : UIView

@property(nonatomic, assign)id<MenuViewDelegate> delegate;

@end



