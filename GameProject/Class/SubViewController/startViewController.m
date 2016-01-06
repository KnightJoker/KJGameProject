//
//  startViewController.m
//  GameProject
//
//  Created by YYQ2B on 16/1/5.
//  Copyright © 2016年 YYQ2B. All rights reserved.
//

#import "startViewController.h"
#import "mainViewController.h"

@interface startViewController ()

@end

@implementation startViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
//    [self.navigationController popViewControllerAnimated:YES];
  //  self.title = @"主页";
   // mainViewController  *vc1 = [[mainViewController alloc] init];
    [self dismissModalViewControllerAnimated: YES];
//    [self dismissViewControllerAnimated: YES completion: nil ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
