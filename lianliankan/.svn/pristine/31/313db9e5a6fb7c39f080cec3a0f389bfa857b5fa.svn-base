//
//  MainViewController.m
//  KWGame
//
//  Created by chinasofti-nate on 16/1/6.
//  Copyright © 2016年 chinasofti-nate. All rights reserved.
//

#import "MainViewController.h"
#import "SettingViewController.h"
#import "StartViewController.h"

@interface MainViewController (){
   
}

@property(nonatomic, strong)UIImageView* bgView;

@end


@implementation MainViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    [self initUI];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
  
}

-(UIImageView*)bgView{
    if (_bgView == nil) {
        _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bgView.image = [UIImage imageNamed:@"main-bg.png"];
        
        _bgView.userInteractionEnabled = YES;
    }
   
    return _bgView;
}

-(void)initUI{
    
    [self.view addSubview:self.bgView];

#if 1
    [self initButton:CGRectMake((SCREEN_WIDTH-209)/2, 240, 209, 67) image:@"start.png" tag:1000];
    [self initButton:CGRectMake((SCREEN_WIDTH-209)/2, 240+87, 209, 67) image:@"continue.png" tag:2000];
    [self initButton:CGRectMake((SCREEN_WIDTH-209)/2, 240+87+87, 209, 67) image:@"setting.png" tag:3000];

#else
    UIButton* btn1 = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-209)/2, 240+87, 209, 67)];
    [btn1 setImage:[UIImage imageNamed:@"continue.png"] forState:UIControlStateNormal];
    btn1.tag = 2000;
    
    [btn1 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bgView  addSubview:btn1];
    
    UIButton* btn2 = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-209)/2, 240+87+87, 209, 67)];
    [btn2 setImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
    btn2.tag = 3000;
    
    [btn2 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bgView  addSubview:btn2];
 
#endif
    
}


-(void)initButton:(CGRect)rect image:(NSString*)imageName tag:(int)btnTag{
    UIButton* btn = [[UIButton alloc] initWithFrame:rect];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btn.tag = btnTag;
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bgView addSubview:btn];
}

-(void)btnClicked:(id)sender{
    if (sender && [sender isKindOfClass:[UIButton class]]) {
        
        UIButton* btn = (UIButton*)sender;
        
        switch (btn.tag) {
            case 1000:
            {
                NSLog(@"开始游戏！！！");
                StartViewController* startView = [[StartViewController alloc] init];
                
                [self presentViewController:startView animated:YES completion:^{
                    
                }];
                
            }
                break;
            case 2000:
            {
                NSLog(@"选关！！！");
            }
                break;
            case 3000:
            {
                NSLog(@"设置");
                SettingViewController* setting = [[SettingViewController alloc] init];
                
                [self presentViewController:setting animated:YES completion:^{
                    
                }];
            }
                break;
                
            default:
                break;
        }
    }
}

@end
