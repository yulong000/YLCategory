
#import <UIKit/UIKit.h>

@interface UIAlertController (block)

/**
 创建alertView类型，只有2个选择，取消和其他

 @param title 标题
 @param message 内容
 @param cancelButtonTitle 取消button的文字
 @param cancelBlock 取消回调
 @param otherButtonTitle 第二个button的文字
 @param otherButtonBlock 第二个button的回调
 */
+ (UIAlertController *)alertControllerWithTitle:(NSString *)title
                                        message:(NSString *)message
                              cancelButtonTitle:(NSString *)cancelButtonTitle
                                    cancelBlock:(void(^)(UIAlertAction *action))cancelBlock
                               otherButtonTitle:(NSString *)otherButtonTitle
                               otherButtonblock:(void (^)(UIAlertAction *action))otherButtonBlock;

/**
 在屏幕中间弹出

 @param controller 要显示到的控制器
 */
- (void)showWithController:(UIViewController *)controller;

/**
 在屏幕中间弹出

 @param controller 要显示到的控制器
 @param completion 弹出后的回调
 */
- (void)showWithController:(UIViewController *)controller completion:(void (^)())completion;

@end
