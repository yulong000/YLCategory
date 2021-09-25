//
//  ViewController.m
//  YLCategory
//
//  Created by WYL on 15/12/30.
//  Copyright © 2015年 WYL. All rights reserved.
//

#import "ViewController.h"
#import "YLCategory.h"
#import "TwoViewController.h"
#import "Macro.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    __weak typeof(self) weakSelf = self;
    UIButton *btn = [UIButton buttonWithTitle:@"点击一" backgroundImage:[UIImage stretchableImageWithColor:RedColor] clickBlock:^(UIButton *button) {
        [weakSelf test];
    }];
    btn.titleLabel.font = Font(14);
    btn.frame = CGRectMake(20, 120, 43, 20);
    [self.view addSubview:btn];
    [btn setBackgroundImage:StretchImage([UIImage imageWithColor:BlackColor size:CGSizeMake(10, 20)]) forState:UIControlStateNormal];
    
    UIButton *btn2 = [UIButton buttonWithTitle:@"颜色" backgroundImageCorlor:RandomColor cornerRadius:0 clickBlock:nil];
    btn2.frame = CGRectMake(200, 200, 100, 100);
    btn2.clickedBlock = ^(UIButton *button) {
        [weakSelf test2];
    };
    [self.view addSubview:btn2];
    
}

- (void)test {
    
    NSLog(@"keywindow %@", kAppKeyWindow);

}

- (void)test2 {
    
}

@end
