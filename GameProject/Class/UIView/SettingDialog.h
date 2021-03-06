//
//  SettingDialog.h
//  GameProject
//
//  Created by YYQ2B on 16/1/14.
//  Copyright © 2016年 YYQ2B. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingDialogDelegate <NSObject>

@optional
- (void)settingDialogDidClose;

@required
- (void)settingDialogDidClickBack;

- (void)settingDialogDidClickRefresh;

- (void)settingDialogDidClickResume;

@end


@interface SettingDialog : UIView

@property(nonatomic,assign)id <SettingDialogDelegate> delegate;
@end
