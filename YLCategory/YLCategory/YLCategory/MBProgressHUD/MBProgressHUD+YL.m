//
//  MBProgressHUD+YL.m
//  view
//
//  Created by DreamHand on 15/9/9.
//  Copyright (c) 2015年 WYL. All rights reserved.
//

#import "MBProgressHUD+YL.h"
#import <objc/runtime.h>

static const char MBProgressHUDButtonClickedBlockKey = '\0';

@implementation MBProgressHUD (YL)

#pragma mark 当传入的view 为 nil 时,将hud添加到 window 上
+ (UIView *)hudShowViewWithInputView:(UIView *)inputView {
    if(inputView)   return inputView;
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] && CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            return window;
    }
    return [UIApplication sharedApplication].keyWindow;
}

#pragma mark - 显示自定义view
+ (MBProgressHUD *)showWithCustomView:(UIView *)customView  message:(NSString *)message toView:(UIView *)view {
    view = [self hudShowViewWithInputView:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = customView;
    hud.label.text = message;
    hud.square = YES;
    return hud;
}

#pragma mark - 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    UIImageView *customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    MBProgressHUD *hud = [self showWithCustomView:customView message:text toView:view];
    [hud hideAnimated:YES afterDelay:kHUDHiddenAfterSecond];
}

#pragma mark 显示成功信息
+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    [self show:success icon:@"success.png" view:view];
}

+ (void)showSuccess:(NSString *)success {
    [self showSuccess:success toView:nil];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view {
    [self show:error icon:@"error.png" view:view];
}

+ (void)showError:(NSString *)error {
    [self showError:error toView:nil];
}

#pragma mark - 显示一些提示信息, 带菊花, 可设置动画效果
+ (MBProgressHUD *)showMessage:(NSString *)message
                 detailMessage:(NSString *)detailMessage
                        toView:(UIView *)view
                      animated:(BOOL)animated
                 dimBackground:(BOOL)dimBackground {
    view = [self hudShowViewWithInputView:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:animated];
    hud.label.text = message;
    hud.detailsLabel.text = detailMessage;
    if(dimBackground) {
        // YES代表需要蒙版效果
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.3];
    }
    return hud;
}
+ (MBProgressHUD *)showMessage:(NSString *)message
                        toView:(UIView *)view
                      animated:(BOOL)animated
                 dimBackground:(BOOL)dimBackground {
    return [self showMessage:message detailMessage:nil toView:view animated:animated dimBackground:dimBackground];
}
+ (MBProgressHUD *)showMessage:(NSString *)message
                        toView:(UIView *)view
                      animated:(BOOL)animated {
    return [self showMessage:message toView:view animated:animated dimBackground:NO];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
                      animated:(BOOL)animated{
    return [self showMessage:message toView:nil animated:animated];
}


#pragma mark - 显示一些提示信息, 带菊花 ,有动画效果
+ (MBProgressHUD *)showMessage:(NSString *)message
                 detailMessage:(NSString *)detailMessage
                        toView:(UIView *)view
                 dimBackground:(BOOL)dimBackground {
    return [self showMessage:message detailMessage:detailMessage toView:view animated:YES dimBackground:dimBackground];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
                        toView:(UIView *)view
                 dimBackground:(BOOL)dimBackground {
    return [self showMessage:message detailMessage:nil toView:view dimBackground:dimBackground];
}

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    return [self showMessage:message toView:view dimBackground:NO];
}

+ (MBProgressHUD *)showMessage:(NSString *)message {
    return [self showMessage:message toView:nil];
}

#pragma mark - 隐藏HUD
+ (void)hideHUDForView:(UIView *)view {
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}

#pragma mark - 显示文本提示信息, 带详细信息
+ (MBProgressHUD *)showText:(NSString *)text
                 detailText:(NSString *)detailText
                     toView:(UIView *)view
                     square:(BOOL)square
           hiddenAfterDelay:(CGFloat)delay {
    view = [self hudShowViewWithInputView:view];
    if(delay <= 0)      delay = kHUDHiddenAfterSecond;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.detailsLabel.text = detailText;
    hud.square = square;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:delay];
    return hud;
}

#pragma mark - 显示文本提示信息
+ (MBProgressHUD *)showText:(NSString *)text
                 detailText:(NSString *)detailText
                     toView:(UIView *)view {
    return [self showText:text detailText:detailText toView:view square:YES hiddenAfterDelay:kHUDHiddenAfterSecond];
}

+ (MBProgressHUD *)showText:(NSString *)text
                     toView:(UIView *)view
                     square:(BOOL)square
           hiddenAfterDelay:(CGFloat)delay {
    return [self showText:text detailText:nil toView:view square:square hiddenAfterDelay:delay];
}

+ (MBProgressHUD *)showText:(NSString *)text
          toView:(UIView *)view
hiddenAfterDelay:(CGFloat)delay {
    return [self showText:text toView:view square:NO hiddenAfterDelay:delay];
}

+ (MBProgressHUD *)showText:(NSString *)text hiddenAfterDelay:(CGFloat)delay {
    return [self showText:text toView:nil hiddenAfterDelay:delay];
}

+ (MBProgressHUD *)showText:(NSString *)text {
    return [self showText:text toView:nil hiddenAfterDelay:0];
}

#pragma mark - 环形的进度条
+ (MBProgressHUD *)showAnnularProgressWithText:(NSString *)text toView:(UIView *)view {
    view = [self hudShowViewWithInputView:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = text;
    return hud;
}
#pragma mark 带按钮的环形进度条
+ (MBProgressHUD *)showAnnularProgressWithText:(NSString *)text
                                        toView:(UIView *)view
                                   buttonTitle:(NSString *)title
                                    clickBlock:(MBProgressHUDButtonClickedBlock)clickBlock {
    view = [self hudShowViewWithInputView:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = text;
    [hud.button addTarget:hud action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    hud.clickedBlock = clickBlock;
    [hud.button setTitle:title forState:UIControlStateNormal];
    return hud;
}

#pragma mark - 横向进度条
+ (MBProgressHUD *)showHorizontalProgressBarWithText:(NSString *)text toView:(UIView *)view {
    view = [self hudShowViewWithInputView:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    hud.label.text = text;
    return hud;
}



#pragma mark -
- (void)buttonClick {
    if(self.clickedBlock) {
        self.clickedBlock(self.button);
    }
}

- (void)setClickedBlock:(MBProgressHUDButtonClickedBlock)clickedBlock {
    [self willChangeValueForKey:@"clickedBlock"];
    objc_setAssociatedObject(self, &MBProgressHUDButtonClickedBlockKey, clickedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"clickedBlock"];
}

- (MBProgressHUDButtonClickedBlock)clickedBlock {
    return objc_getAssociatedObject(self, &MBProgressHUDButtonClickedBlockKey);
}

@end
