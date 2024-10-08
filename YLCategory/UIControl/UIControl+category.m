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
static const char UIControlCustomBlockKey = '\0';

@implementation UIControl (category)

#pragma mark - block
- (UIControlClickedBlock)clickedBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setClickedBlock:(UIControlClickedBlock)clickedBlock {
    [self addTarget:self action:@selector(yl_controlClick) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(self, @selector(clickedBlock), clickedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)yl_controlClick {
    if(self.clickedBlock) {
        self.clickedBlock(self);
    }
}

- (void)setCustomBlock:(UIControlCustomBlock)customBlock forControlEvents:(UIControlEvents)events {
    [self addTarget:self action:@selector(customSelector) forControlEvents:events];
    [self willChangeValueForKey:@"customBlock"];
    objc_setAssociatedObject(self, &UIControlCustomBlockKey, customBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"customBlock"];
}

- (void)customSelector {
    UIControlCustomBlock block = objc_getAssociatedObject(self, &UIControlCustomBlockKey);
    if(block) {
        block(self);
    }
}


#pragma mark - add click area
- (void)addClickArea:(UIEdgeInsets)insets {
    [self willChangeValueForKey:@"areaInsets"];
    objc_setAssociatedObject(self, &UIControlAreaInsetsKey, [NSValue valueWithUIEdgeInsets:insets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"areaInsets"];
}

// 有效区域
- (CGRect)validArea {
    NSValue *value = objc_getAssociatedObject(self, &UIControlAreaInsetsKey);
    if(value && [value isKindOfClass:[NSNull class]] == NO) {
        UIEdgeInsets insets = [value UIEdgeInsetsValue];
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
