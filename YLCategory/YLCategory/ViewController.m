//
//  ViewController.m
//  YLCategory
//
//  Created by WYL on 15/12/30.
//  Copyright © 2015年 WYL. All rights reserved.
//

#import "ViewController.h"
#import "YLCategory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelectorInBackground:@selector(getImagesize) withObject:nil];
    
    for(int i = 0; i < 20; i++)
    {
        usleep(100000); // 0.1s
        NSLog(@"i = %d", i);
    }
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
