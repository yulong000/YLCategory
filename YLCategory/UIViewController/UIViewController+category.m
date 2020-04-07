//
//  UIViewController+category.m
//  YLCategory
//
//  Created by Apple on 2020/4/7.
//  Copyright © 2020 WYL. All rights reserved.
//

#import "UIViewController+category.h"

@implementation UIViewController (category)

#pragma mark - 返回

- (void)returnBack {
    if(self.navigationController.presentingViewController) {
        if(self.navigationController.viewControllers.count == 1) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if(self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
