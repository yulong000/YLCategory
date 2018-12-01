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
    __weak typeof(self) weakSelf = self;
    UIButton *btn = [UIButton buttonWithTitle:@"点击一" backgroundImage:[UIImage stretchableImageWithColor:RedColor] clickBlock:^(UIButton *button) {
        
    }];
    btn.titleLabel.font = Font(14);
    btn.frame = CGRectMake(20, 120, 43, 20);
    [self.view addSubview:btn];
}

- (void)test {
//    [MBProgressHUD showMessage:@"jiazao"];
    [MBProgressHUD showSuccess:@"删除订单成功"];
//    [MBProgressHUD hideHUD];
//    TwoViewController *two = [[TwoViewController alloc] init];
//    [self.navigationController pushViewController:two animated:YES];
}


@end
