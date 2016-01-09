//
//  StartViewController.m
//  KWGamerDemo
//
//  Created by chinasofti-nate on 16/1/7.
//  Copyright © 2016年 chinasofti-nate. All rights reserved.
//

#import "StartViewController.h"
#import "MenuView.h"


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

#define PIC_W   44
#define PIC_H   44

#define MARGIN_X  ((SCREEN_WIDTH - 44*8)/2)
#define MARGIN_Y  ((SCREEN_HEIGHT - 44*8)/2+18.5)

@interface StartViewController () <MenuViewDelegate>{
    UILabel* _number_label;
    int _uiMap[10][10];
    
    UIImageView* _firstView;
    UIImageView* _secondView;
    
    //元素行列
    int _firstRow;
    int _firstColumn;
    
    int _secondRow;
    int _secondColumn;
}

@property(nonatomic, strong)UIImageView* bgView;
@property(nonatomic, strong)UIImageView* totalView;

@property(nonatomic, assign)GamerStatusType gamerStatus;

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initGamerParam];
    
    [[Engine shareInstances] beginGamer];
    
}

-(void)dealloc{
    
}
-(void)initGamerParam{
    _gamerStatus = GamerStatusTypeStart;
    _firstRow = 0;
    _firstColumn = 0;
    _secondColumn = 0;
    _secondRow = 0;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initUI];
    
}

-(UIImageView*)bgView{
    if (_bgView == nil) {
        _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bgView.image = [UIImage imageNamed:@"gamerbg.png"];
        
        _bgView.userInteractionEnabled = YES;
    }
    
    return _bgView;
}

-(UIImageView*)totalView{
    
    if (_totalView == nil) {
        _totalView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-110)/2, 80, 110, 35)];
        _totalView.image = [UIImage imageNamed:@"number_bg.png"];
        
    }
   
    return _totalView;
}


-(void)initUI{
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.totalView];
    
    [self initNumberLabel];
    
    MenuView* menu = [[MenuView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40-40, SCREEN_WIDTH, 40)];
    menu.delegate = self;
    
    [self.bgView addSubview:menu];
    
    [self initPicItems];
    
}

-(void)initPicItems{
    [[Engine shareInstances] getPicMap:_uiMap];
    
#if 1
    for (int i=1; i<9; i++) {
        for (int j=1; j<9; j++) {
            
            int num =  _uiMap[i][j];
            
            UIImageView* picView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_X+(j-1)*PIC_W, MARGIN_Y+(i-1)*PIC_H, PIC_W, PIC_H)];
            
            NSString* imageName = [NSString stringWithFormat:@"fruit-%d",num];
            
            picView.image = [UIImage imageNamed:imageName];
            
            picView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picItemsClicked:)];
            
            [picView addGestureRecognizer:tap];
            
            [self.bgView addSubview:picView];
        }
    }
    
#else

    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60 , 200, 40, 40)];
    
    NSString* imageName = [NSString stringWithFormat:@"fruit-%d", _uiMap[1][1] ];
    imageView.image = [UIImage imageNamed:imageName];

    [self.bgView addSubview:imageView];
#endif
    
}

-(void)picItemsClicked:(id)sender{
    if (sender && [sender isKindOfClass:[UITapGestureRecognizer class]]) {
          UITapGestureRecognizer* tap = (UITapGestureRecognizer*)sender;
        
        CGRect rect = tap.view.frame;
        
        //计算元素所在的行列
        int row = (rect.origin.y - MARGIN_Y)/PIC_H + 1;
        int column = (rect.origin.x - MARGIN_X)/PIC_W + 1;
        
        switch (_gamerStatus) {
            case GamerStatusTypeStart:
            {
                _gamerStatus = GamerStatusTypeEnd;
                _firstRow = row;
                _firstColumn = column;
                
                _firstView = (UIImageView*)tap.view;
                
                [UIView animateWithDuration:1. animations:^{
                    CGRect rect = _firstView.frame;
                    rect.size = CGSizeMake(48, 48);
                    _firstView.frame = rect;
                }];
                
            }
                break;
            case GamerStatusTypeEnd:
            {
                _gamerStatus = GamerStatusTypeStart;
                _secondRow = row;
                _secondColumn = column;
                
                _secondView = (UIImageView*)tap.view;
                
                [self linkToLink];
                
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

/**
 *
 */
-(void)linkToLink{
    int ret = [[Engine shareInstances] isConnectionWithItems:
                                            _firstRow column:_firstColumn
                                                  secondItem:_secondRow
                                                      column:_secondColumn];
    
    if (ret != 0) {
        [self removePicItems];
    }
}

/**
 *
 */
-(void)removePicItems{
    [_firstView removeFromSuperview];
    _firstView = nil;
    [_secondView removeFromSuperview];
    _secondView = nil;
}

-(void)initNumberLabel{
    _number_label = [[UILabel  alloc] initWithFrame:CGRectMake(0, 0, 110, 35)];
    _number_label.text = @"0";
    _number_label.backgroundColor = [UIColor clearColor];
    _number_label.textAlignment = NSTextAlignmentCenter;
    [_number_label setFont:[UIFont systemFontOfSize:18.]];
    
    [self.totalView addSubview:_number_label];
}


#pragma mark- MenuViewDelegate
-(void)pauseMenuClicked{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)refreshMenuClicked{
    
}

-(void)findMenuClicked{
    
}










@end
