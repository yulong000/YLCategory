//
//  UIViewController+category.m
//  YLCategory
//
//  Created by Apple on 2020/4/7.
//  Copyright © 2020 WYL. All rights reserved.
//

#import "UIViewController+category.h"
#import "UIAlertController+block.h"

@implementation UIViewController (category)

- (void)goBack {
    if([self isKindOfClass:[UINavigationController class]]) {
        // 本身是导航控制器
        UINavigationController *nav = (UINavigationController *)self;
        if(nav.viewControllers.count == 1) {
            if(nav.presentingViewController) {
                [nav dismissViewControllerAnimated:YES completion:nil];
            }
        } else {
            [nav popViewControllerAnimated:YES];
        }
    } else if (self.navigationController) {
        // 有导航控制器
        [self.navigationController goBack];
    } else {
        // 没有导航控制器
        if(self.presentationController) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)pushVc:(UIViewController *)vc {
    if(vc == nil)   return;
    if([self isKindOfClass:[UINavigationController class]]) {
        [((UINavigationController *)self) pushViewController:vc animated:YES];
    } else if (self.navigationController) {
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (UINavigationController *)rootNavController {
    if(self.navigationController) {
        return self.navigationController;
    }
    UIView *superView = self.view.superview;
    do {
        UIResponder *responder = [self.view nextResponder];
        UIViewController *superVc = nil;
        while (responder) {
            if([responder isKindOfClass:[UIViewController class]]) {
                superVc = (UIViewController *)responder;
                break;
            }
            responder = [responder nextResponder];
        }
        if(superVc == nil) {
            return nil;
        }
        UINavigationController *nav = superVc.navigationController;
        if(nav) {
            return nav;
        } else {
            superView = superView.superview;
        }
    } while (superView);
    return nil;
}

#pragma mark 显示alert, 只有一个按钮
- (void)showAlert:(NSString * _Nullable)title
          message:(NSString * _Nullable)message
      cancelTitle:(NSString *)cancelTitle {
    [[UIAlertController alertControllerWithTitle:title message:message buttonTitle:cancelTitle handleBlock:nil] showWithController:self];
}

#pragma mark 显示alert，取消、确定，标题自定义
- (void)showAlert:(NSString * _Nullable)title
          message:(NSString * _Nullable)message
      cancelTitle:(NSString *)cancelTitle
        sureTitle:(NSString *)sureTitle
      sureHandler:(void(^ _Nullable)(void))sureHandler {
    [[UIAlertController alertControllerWithTitle:title message:message cancelButtonTitle:cancelTitle cancelBlock:nil otherButtonTitle:sureTitle otherButtonblock:^(UIAlertAction *action) {
        if(sureHandler) {
            sureHandler();
        }
    }] showWithController:self];
}

#pragma mark 显示alert，取消、确定
- (void)showAlert:(NSString * _Nullable)title
          message:(NSString * _Nullable)message
      sureHandler:(void(^ _Nullable)(void))sureHandler {
    [self showAlert:title message:message cancelTitle:@"取消" sureTitle:@"确定" sureHandler:sureHandler];
}

#pragma mark 显示alert，自定义多个按钮，自带取消按钮
- (void)showAlert:(NSString * _Nullable)title
          message:(NSString * _Nullable)message
        subTitles:(NSArray <NSString *> *)subTitles
          handler:(void(^ _Nullable)(NSInteger index))handler {
    [self showAlert:title message:message subTitles:subTitles cancelTitle:@"取消" handler:handler];
}

#pragma mark 显示alert，自定义所有按钮
- (void)showAlert:(NSString *)title
          message:(NSString *)message
        subTitles:(NSArray<NSString *> *)subTitles
      cancelTitle:(NSString *)cancelTitle
          handler:(void (^)(NSInteger))handler {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < subTitles.count; i ++) {
        UIAlertActionModel *model = [UIAlertActionModel actionModelWithTitle:subTitles[i] actionStyle:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if(handler) {
                handler(i);
            }
        }];
        [arr addObject:model];
    }
    UIAlertActionModel *cancel = [UIAlertActionModel cancelAction];
    cancel.title = cancelTitle;
    [arr addObject:cancel];
    [[UIAlertController actionSheetControllerWithTitle:title message:message actionModels:arr] showWithController:self];
}


#pragma mark 显示actionSheet，标题自定义，自带取消
- (void)showActionSheet:(NSString * _Nullable)title
              subTitles:(NSArray <NSString *> *)subTitles
                handler:(void (^ _Nullable)(NSInteger index))handler {
    [self showActionSheet:title  subTitles:subTitles cancelTitle:@"取消" handler:handler];
}


#pragma mark 显示actionSheet，所有标题自定义
- (void)showActionSheet:(NSString * _Nullable)title
              subTitles:(NSArray <NSString *> *)subTitles
            cancelTitle:(NSString *)cancelTitle
                handler:(void (^ _Nullable)(NSInteger index))handler {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < subTitles.count; i ++) {
        UIAlertActionModel *model = [UIAlertActionModel actionModelWithTitle:subTitles[i] actionStyle:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if(handler) {
                handler(i);
            }
        }];
        [arr addObject:model];
    }
    UIAlertActionModel *cancel = [UIAlertActionModel cancelAction];
    cancel.title = cancelTitle;
    [arr addObject:cancel];
    [[UIAlertController actionSheetControllerWithTitle:title message:nil actionModels:arr] showWithController:self];
}
@end
