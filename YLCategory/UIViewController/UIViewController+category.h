//
//  UIViewController+category.h
//  YLCategory
//
//  Created by Apple on 2020/4/7.
//  Copyright © 2020 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (category)

/// 返回上一个页面, 如果是push,则pop,如果是present,则dismiss
- (void)goBack;

/// 如果有nav，则push，否则 present
- (void)pushVc:(UIViewController *)vc;

/// 获取导航控制器
- (UINavigationController *)rootNavController;


/// 显示alert, 只有一个按钮
/// - Parameters:
///   - title: 标题
///   - message: 内容
///   - cancelTitle: 取消按钮的标题
- (void)showAlert:(NSString * _Nullable)title
          message:(NSString * _Nullable)message
      cancelTitle:(NSString *)cancelTitle;

/// 显示alert，取消、确定，标题自定义
/// - Parameters:
///   - title: 标题
///   - message: 内容
///   - cancelTitle: 取消的标题
///   - sureTitle: 确认的标题
///   - handler: 确认的回调
- (void)showAlert:(NSString * _Nullable)title
          message:(NSString * _Nullable)message
      cancelTitle:(NSString *)cancelTitle
        sureTitle:(NSString *)sureTitle
      sureHandler:(void(^ _Nullable)(void))sureHandler;

/// 显示alert，取消、确定
/// - Parameters:
///   - title: 标题
///   - message: 内容
///   - sureHandler: 确认的回调
- (void)showAlert:(NSString * _Nullable)title
          message:(NSString * _Nullable)message
      sureHandler:(void(^ _Nullable)(void))sureHandler;

/// 显示alert，自定义多个按钮, 自带取消
/// - Parameters:
///   - title: 标题
///   - message: 内容
///   - subTitles: 按钮的标题
///   - handler: 点击后的回调
- (void)showAlert:(NSString * _Nullable)title
          message:(NSString * _Nullable)message
        subTitles:(NSArray <NSString *> *)subTitles
          handler:(void(^ _Nullable)(NSInteger index))handler;

/// 显示alert，自定义所有按钮
/// - Parameters:
///   - title: 标题
///   - message: 内容
///   - cancelTitle: 取消按钮的标题
///   - subTitles: 按钮的标题
///   - handler: 点击后的回调
- (void)showAlert:(NSString * _Nullable)title
          message:(NSString * _Nullable)message
        subTitles:(NSArray <NSString *> *)subTitles
      cancelTitle:(NSString *)cancelTitle
          handler:(void(^ _Nullable)(NSInteger index))handler;


/// 显示actionSheet，标题自定义，自带取消
/// - Parameters:
///   - title: 标题
///   - subTitles: 按钮标题
///   - handler: 回调
- (void)showActionSheet:(NSString * _Nullable)title
              subTitles:(NSArray <NSString *> *)subTitles
                handler:(void (^ _Nullable)(NSInteger index))handler;


/// 显示actionSheet，所有标题自定义
/// - Parameters:
///   - title: 标题
///   - subTitles: 按钮标题
///   - cancelTitle: 取消按钮标题
///   - handler: 回调
- (void)showActionSheet:(NSString * _Nullable)title
              subTitles:(NSArray <NSString *> *)subTitles
            cancelTitle:(NSString *)cancelTitle
                handler:(void (^ _Nullable)(NSInteger index))handler;

@end

NS_ASSUME_NONNULL_END
