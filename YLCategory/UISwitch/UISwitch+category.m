//
//  UISwitch+category.m
//  YLCategory
//
//  Created by 魏宇龙 on 2022/1/26.
//  Copyright © 2022 WYL. All rights reserved.
//

#import "UISwitch+category.h"
#import <objc/runtime.h>

static const char UISwitchOnBlockKey = '\0';

@implementation UISwitch (category)

#pragma mark - block
- (UISwitchOnBlock)onBlock {
    return objc_getAssociatedObject(self, &UISwitchOnBlockKey);
}

- (void)setOnBlock:(UISwitchOnBlock)onBlock {
    [self addTarget:self action:@selector(switchOn) forControlEvents:UIControlEventValueChanged];
    [self willChangeValueForKey:@"onBlock"];
    objc_setAssociatedObject(self, &UISwitchOnBlockKey, onBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"onBlock"];
}

- (void)switchOn {
    if(self.onBlock) {
        self.onBlock(self, self.on);
    }
}


@end
