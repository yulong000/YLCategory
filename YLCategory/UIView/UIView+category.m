#import "UIView+category.h"

@implementation UIView (category)

#pragma mark 移除所有子控件
- (void)removeAllSubviews {
    if([self isKindOfClass:[UIView class]] == NO)   return;
    for (UIView *sub in self.subviews) {
        [sub removeFromSuperview];
    }
}

#pragma mark 添加一组子控件
- (void)addSubViewsFromArray:(NSArray *)subViews {
    [subViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[UIView class]]) {
            [self addSubview:obj];
        }
    }];
}

#pragma mark 获取view所在的controller
- (UIViewController *)controller {
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}
@end
