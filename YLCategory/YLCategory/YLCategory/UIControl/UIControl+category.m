//
//  UIControl+category.m
//  YLCategory
//
//  Created by weiyulong on 2018/7/24.
//  Copyright © 2018年 WYL. All rights reserved.
//

#import "UIControl+category.h"
#import <objc/runtime.h>

static const char UIControlAreaInsetsKey = '\0';

@implementation UIControl (category)
#pragma mark - add click area
- (void)addClickArea:(UIEdgeInsets)insets {
    [self willChangeValueForKey:@"areaInsets"];
    objc_setAssociatedObject(self, &UIControlAreaInsetsKey, [NSValue valueWithUIEdgeInsets:insets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"areaInsets"];
}

// 有效区域
- (CGRect)validArea {
    UIEdgeInsets insets = [objc_getAssociatedObject(self, &UIControlAreaInsetsKey) UIEdgeInsetsValue];
    if(insets.top && insets.left && insets.bottom && insets.right) {
        return CGRectMake(- insets.left,
                          - insets.top,
                          self.bounds.size.width + insets.left + insets.right,
                          self.bounds.size.height + insets.top + insets.bottom);
    }
    return self.bounds;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self validArea];
    if(CGRectEqualToRect(rect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point);
}
@end
