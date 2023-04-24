//
//  TwoViewController.m
//  YLCategory
//
//  Created by weiyulong on 2018/6/24.
//  Copyright © 2018年 WYL. All rights reserved.
//

#import "TwoViewController.h"
#import "YLCategory.h"

@interface TwoViewController ()
@property (nonatomic, strong) UIButton *btn;
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    UIButton *btn = [UIButton buttonWithClickBlock:^(UIButton *button) {
        [weakSelf test];
        [button setTitle:@"test" forState:UIControlStateNormal];
    }];
    btn.backgroundColor = [UIColor greenColor];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:btn];
    self.btn = btn;
    [self test];
}

- (void)test {
    
}

- (void)dealloc
{
    NSLog(@"two dealloc");
}

@end
