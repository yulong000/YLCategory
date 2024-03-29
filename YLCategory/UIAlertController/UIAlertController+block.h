
#import <UIKit/UIKit.h>

typedef void(^UIAlertActionHandler)(UIAlertAction *action);

@interface UIAlertActionModel : NSObject

@property (nonatomic, assign) UIAlertActionStyle style;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   UIAlertActionHandler handler;

+ (instancetype)actionModelWithTitle:(NSString *)title
                         actionStyle:(UIAlertActionStyle)style
                             handler:(UIAlertActionHandler)handler;

+ (instancetype)cancelAction;
@end

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
                                    cancelBlock:(UIAlertActionHandler)cancelBlock
                               otherButtonTitle:(NSString *)otherButtonTitle
                               otherButtonblock:(UIAlertActionHandler)otherButtonBlock;

/**
 创建alertView类型，只有2个选择，取消和其他(慎重)

 @param title 标题
 @param message 内容
 @param cancelButtonTitle 取消button的文字
 @param cancelBlock 取消回调
 @param destructTitle 第二个button的文字
 @param destructBlock 第二个button的回调
 */
+ (UIAlertController *)alertControllerWithTitle:(NSString *)title
                                        message:(NSString *)message
                              cancelButtonTitle:(NSString *)cancelButtonTitle
                                    cancelBlock:(UIAlertActionHandler)cancelBlock
                                  destructTitle:(NSString *)destructTitle
                                  destructBlock:(UIAlertActionHandler)destructBlock;

/**
 创建alertView类型，只有1个选择
 
 @param title 标题
 @param message 内容
 @param buttonTitle button的文字
 @param handleBlock 回调
 */
+ (UIAlertController *)alertControllerWithTitle:(NSString *)title
                                        message:(NSString *)message
                                    buttonTitle:(NSString *)buttonTitle
                                     handleBlock:(UIAlertActionHandler)handleBlock;

/**
 创建alertView类型，有多个选择
 
 @param title 标题
 @param message 内容
 @param buttonTitles button的文字数组
 @param handler 回调
 */
+ (UIAlertController *)alertControllerWithTitle:(NSString *)title
                                        message:(NSString *)message
                                   buttonTitles:(NSArray <NSString *> *)buttonTitles
                                        handler:(void(^)(NSInteger index))handler;

/**
 创建actionSheet类型
 
 @param title 标题
 @param message 内容
 @param actionModels actionModel 对象数组
 */
+ (UIAlertController *)actionSheetControllerWithTitle:(NSString *)title
                                              message:(NSString *)message
                                          actionModels:(NSArray<UIAlertActionModel *> *)actionModels;

/**
 创建actionSheet类型
 
 @param title 标题
 @param message 内容
 @param subTitles 选项的标题
 @param handler 点击后的回调
 */
+ (UIAlertController *)actionSheetControllerWithTitle:(NSString *)title
                                              message:(NSString *)message
                                            subTitles:(NSArray<NSString *> *)subTitles
                                              handler:(void(^)(NSInteger index))handler;

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
- (void)showWithController:(UIViewController *)controller completion:(void (^)(void))completion;

@end
