//
//  YLHud.h
//  YLHud
//
//  Created by 魏宇龙 on 2023/4/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YLHudTheme) {
    YLHudThemeAuto,         // 自动
    YLHudThemeDark,         // 黑色
    YLHudThemeLight,        // 亮色
};

#pragma mark - 全局配置

@interface YLHudConfig : NSObject

+ (instancetype)share;

/// 主题色, 默认auto
@property (nonatomic, assign) YLHudTheme theme;
/// 提示框的背景色
@property (nonatomic, strong) UIColor *hudColor;
/// 文本的颜色
@property (nonatomic, strong) UIColor *textColor;
/// 默认显示的时间, default = 1
@property (nonatomic, assign) CGFloat hideAfterSecond;
/// 成功时的图片
@property (nonatomic, strong) UIImage *successImage;
/// 失败时的图片
@property (nonatomic, strong) UIImage *errorImage;

@end


#pragma mark -

/*
 ############################################################
 温馨提示：未传入view时，显示在最上层的window上
 ############################################################
 */

typedef void (^YLHudCompletionHandler)(void);

@interface YLHud : UIView

/// 显示成功信息，自动隐藏

+ (YLHud *)showSuccess:(NSString *)success;
+ (YLHud *)showSuccess:(NSString *)success hideAfterDelay:(CGFloat)second;
+ (YLHud *)showSuccess:(NSString *)success completion:(YLHudCompletionHandler _Nullable)handler;
+ (YLHud *)showSuccess:(NSString *)success hideAfterDelay:(CGFloat)second completion:(YLHudCompletionHandler _Nullable)handler;
+ (YLHud *)showSuccess:(NSString *)success toView:(UIView * _Nullable)view;
+ (YLHud *)showSuccess:(NSString *)success toView:(UIView * _Nullable)view hideAfterDelay:(CGFloat)second;
+ (YLHud *)showSuccess:(NSString *)success toView:(UIView * _Nullable)view completion:(YLHudCompletionHandler _Nullable)handler;
+ (YLHud *)showSuccess:(NSString *)success toView:(UIView * _Nullable)view hideAfterDelay:(CGFloat)second completion:(YLHudCompletionHandler _Nullable)handler;


/// 显示错误信息，自动隐藏

+ (YLHud *)showError:(NSString *)error;
+ (YLHud *)showError:(NSString *)error hideAfterDelay:(CGFloat)second;
+ (YLHud *)showError:(NSString *)error completion:(YLHudCompletionHandler _Nullable)handler;
+ (YLHud *)showError:(NSString *)error hideAfterDelay:(CGFloat)second completion:(YLHudCompletionHandler _Nullable)handler;
+ (YLHud *)showError:(NSString *)error toView:(UIView * _Nullable)view;
+ (YLHud *)showError:(NSString *)error toView:(UIView * _Nullable)view hideAfterDelay:(CGFloat)second;
+ (YLHud *)showError:(NSString *)error toView:(UIView * _Nullable)view completion:(YLHudCompletionHandler _Nullable)handler;
+ (YLHud *)showError:(NSString *)error toView:(UIView * _Nullable)view hideAfterDelay:(CGFloat)second completion:(YLHudCompletionHandler _Nullable)handler;


/// 显示带文字的loading信息， 需手动隐藏

+ (YLHud *)showLoading:(NSString *)message;
+ (YLHud *)showLoading:(NSString *)message toView:(UIView * _Nullable)view;

/// 显示文字信息，自动隐藏

+ (YLHud *)showText:(NSString *)text;
+ (YLHud *)showText:(NSString *)text hiddenAfterDelay:(CGFloat)second;
+ (YLHud *)showText:(NSString *)text completion:(YLHudCompletionHandler _Nullable)handler;
+ (YLHud *)showText:(NSString *)text hiddenAfterDelay:(CGFloat)second completion:(YLHudCompletionHandler _Nullable)handler;
+ (YLHud *)showText:(NSString *)text toView:(UIView * _Nullable)view;
+ (YLHud *)showText:(NSString *)text toView:(UIView * _Nullable)view hiddenAfterDelay:(CGFloat)second;
+ (YLHud *)showText:(NSString *)text toView:(UIView * _Nullable)view completion:(YLHudCompletionHandler _Nullable)handler;
+ (YLHud *)showText:(NSString *)text toView:(UIView * _Nullable)view hiddenAfterDelay:(CGFloat)second completion:(YLHudCompletionHandler _Nullable)handler;


/// 显示进度

/// 环形的进度条, progress 取值范围 0 ~ 1
+ (YLHud *)showProgress:(CGFloat)progress;
+ (YLHud *)showProgress:(CGFloat)progress text:(NSString * _Nullable)text;
+ (YLHud *)showProgress:(CGFloat)progress toView:(UIView * _Nullable)view;
+ (YLHud *)showProgress:(CGFloat)progress text:(NSString * _Nullable)text toView:(UIView * _Nullable)view;


/// 显示自定义view
+ (YLHud *)showWithCustomView:(UIView *)customView text:(NSString * _Nullable)text toView:(UIView * _Nullable)view;

/// 隐藏HUD

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView * _Nullable)view;


/// 切换模式

- (void)showLoading:(NSString * _Nullable)message;
- (void)showText:(NSString * _Nullable)text;
- (void)showSuccess:(NSString * _Nullable)success;
- (void)showError:(NSString * _Nullable)error;
- (void)showProgress:(CGFloat)progress;

- (void)showText:(NSString * _Nullable)text hideAfterDelay:(CGFloat)second;
- (void)showSuccess:(NSString * _Nullable)success hideAfterDelay:(CGFloat)second;
- (void)showError:(NSString * _Nullable)error hideAfterDelay:(CGFloat)second;
- (void)showProgress:(CGFloat)progress text:(NSString * _Nullable)text;

/// 隐藏

- (void)hide;

@end

NS_ASSUME_NONNULL_END
