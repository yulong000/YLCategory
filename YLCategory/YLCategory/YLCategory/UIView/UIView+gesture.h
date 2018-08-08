
#import <UIKit/UIKit.h>

// 手势回调
typedef void (^UIViewTapGestureBlock)(UIView *view, UITapGestureRecognizer *tap);
typedef void (^UIViewPanGestureBlock)(UIView *view, UIPanGestureRecognizer *pan);

@interface UIView (gesture)

- (void)addTapGestureHandleBlock:(UIViewTapGestureBlock)handle;
- (void)addPanGestureHandleBlock:(UIViewPanGestureBlock)handle;
@end
