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

@interface ViewController ()

@property (nonatomic, strong) UIView *view1;

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

    
    UISwitch *s = [[UISwitch alloc] init];
    [self.view addSubview:s];
    s.onBlock = ^(UISwitch *s, BOOL on) {
        NSLog(@"switch  %d", on);
    };
    
    [btn setCustomBlock:^(id control) {
        NSLog(@"btn  touch up outside");
    } forControlEvents:UIControlEventTouchUpOutside];
    
}


- (void)test {

    NSLog(@"statusBarHeight : %f", kStatusBarHeight);
}

- (void)test2 {
    [[UIAlertController alertControllerWithTitle:@"是否删除？" message:nil cancelButtonTitle:@"取消" cancelBlock:nil destructTitle:@"删除" destructBlock:^(UIAlertAction *action) {
        NSLog(@"删除成功！");
    }] showWithController:self];
}

@end
