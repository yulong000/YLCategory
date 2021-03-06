//
//  UIViewController+category.h
//  YLCategory
//
//  Created by Apple on 2020/4/7.
//  Copyright © 2020 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (category)

/// 返回上一个页面, 如果是push,则pop,如果是present,则dismiss
- (void)returnBack;

@end

NS_ASSUME_NONNULL_END
