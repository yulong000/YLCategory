
#import <UIKit/UIKit.h>

// 手势回调
typedef void (^UIViewGestureBlock)(UIView *view, UIGestureRecognizer *gesture);

@interface UIView (gesture)

- (void)addTapGestureHandleBlock:(UIViewGestureBlock)handle;
@end
