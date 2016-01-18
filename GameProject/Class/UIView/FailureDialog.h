//
//  FailureDialog.h
//  GameProject
//
//  Created by YYQ2B on 16/1/18.
//  Copyright © 2016年 YYQ2B. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FailureDialogDelegate <NSObject>

-(void)failureDialogBackClicked;
-(void)failureDialogCloseDialog;

@end

@interface FailureDialog : UIView

@property(nonatomic, assign)id<FailureDialogDelegate> delegate;

@end
