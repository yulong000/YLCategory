
#import <UIKit/UIKit.h>

// 手势回调
typedef void (^UIViewTapGestureHandler)(id view, UITapGestureRecognizer *tap);
typedef void (^UIViewPanGestureHandler)(id view, UIPanGestureRecognizer *pan);
typedef void (^UIViewLongPressGestureHandler)(id view, UILongPressGestureRecognizer *longPress);

@interface UIView (gesture)

- (UITapGestureRecognizer *)addTapGestureWithHandler:(UIViewTapGestureHandler)handler;
- (UIPanGestureRecognizer *)addPanGestureWithHandler:(UIViewPanGestureHandler)handler;
- (UILongPressGestureRecognizer *)addLongPressGestureWithHandler:(UIViewLongPressGestureHandler)handler;

- (UITapGestureRecognizer *)addTapGestureWithDelegate:(id)delegate handler:(UIViewTapGestureHandler)handler;
- (UIPanGestureRecognizer *)addPanGestureWithDelegate:(id)delegate handler:(UIViewPanGestureHandler)handler;
- (UILongPressGestureRecognizer *)addLongPressGestureWithDelegate:(id)delegate handler:(UIViewLongPressGestureHandler)handler;

@end
