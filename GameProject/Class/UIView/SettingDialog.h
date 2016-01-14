//
//  SettingDialog.h
//  GameProject
//
//  Created by YYQ2B on 16/1/14.
//  Copyright © 2016年 YYQ2B. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingDialogDelegate <NSObject>

- (void)settingDialogDidClose;

- (void)pageJump;

@end


@interface SettingDialog : UIView

@property(nonatomic,assign)id <SettingDialogDelegate> delegate;
@end
