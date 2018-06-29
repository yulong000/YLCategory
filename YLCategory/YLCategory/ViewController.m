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
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"button" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    btn.clickedBlock = ^(UIButton *button) {
        [self test];
    };
    btn.frame = CGRectMake(120, 120, 100, 200);
    [self.view addSubview:btn];
}

- (void)test {
//    TwoViewController *two = [[TwoViewController alloc] init];
//    [self.navigationController pushViewController:two animated:YES];
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"title" message:@"message" cancelButtonTitle:@"quxiao" cancelBlock:^(UIAlertAction *action) {
        NSLog(@"quxiao");
    } otherButtonTitle:@"queding" otherButtonblock:^(UIAlertAction *action) {
        NSLog(@"qita");
    }];
    [controller showWithController:self completion:^{
        NSLog(@"over");
    }];
    return;
}

- (void)getImagesize
{
    CGSize size = [UIImage imageSizeWithURL:@"http://img2.3lian.com/img2007/10/28/123.jpg"];
    NSLog(@"size : %@", NSStringFromCGSize(size));

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
