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
#import "PublicHeader.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"button" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    btn.clickedBlock = ^(UIButton *button) {
        [weakSelf test];
    };
    btn.frame = CGRectMake(120, 120, 100, 200);
    [self.view addSubview:btn];
}

- (void)test {
    [MBProgressHUD showSuccess:@"删除订单成功"];
//    TwoViewController *two = [[TwoViewController alloc] init];
//    [self.navigationController pushViewController:two animated:YES];
}


@end
