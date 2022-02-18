//
//  UISwitch+category.h
//  YLCategory
//
//  Created by 魏宇龙 on 2022/1/26.
//  Copyright © 2022 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UISwitchOnBlock)(UISwitch *s, BOOL on);

@interface UISwitch (category)

@property (nonatomic, copy)   UISwitchOnBlock onBlock;

@end

