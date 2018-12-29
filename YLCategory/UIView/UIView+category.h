#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (category)

/**  移除所有的子控件  */
- (void)removeAllSubviews;

/**  获取view所在的controller  */
- (nullable UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END