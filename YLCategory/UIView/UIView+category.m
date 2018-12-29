#import "UIView+category.h"

@implementation UIView (category)

#pragma mark 移除所有子控件
- (void)removeAllSubviews {
    if([self isKindOfClass:[UIView class]] == NO)   return;
    for (UIView *sub in self.subviews) {
        [sub removeFromSuperview];
    }
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
