#import "UIAlertController+block.h"
#import "Macro.h"

@implementation UIAlertActionModel

+ (instancetype)actionModelWithTitle:(NSString *)title actionStyle:(UIAlertActionStyle)style handler:(UIAlertActionHandler)handler {
    UIAlertActionModel *model = [[UIAlertActionModel alloc] init];
    model.title = title;
    model.style = style;
    model.handler = handler;
    return model;
}

+ (instancetype)cancelAction {
    UIAlertActionModel *model = [[UIAlertActionModel alloc] init];
    model.title = @"取消";
    model.style = UIAlertActionStyleCancel;
    model.handler = nil;
    return model;
}

@end

@implementation UIAlertController (block)

+ (instancetype)alertControllerWithTitle:(NSString *)title
                                 message:(NSString *)message
                       cancelButtonTitle:(NSString *)cancelButtonTitle
                             cancelBlock:(void (^)(UIAlertAction *))cancelBlock
                        otherButtonTitle:(NSString *)otherButtonTitle
                        otherButtonblock:(void (^)(UIAlertAction *))otherButtonBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:cancelBlock];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle
                                                          style:UIAlertActionStyleDefault
                                                        handler:otherButtonBlock];
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    return alertController;
}

+ (UIAlertController *)alertControllerWithTitle:(NSString *)title
                                        message:(NSString *)message
                              cancelButtonTitle:(NSString *)cancelButtonTitle
                                    cancelBlock:(UIAlertActionHandler)cancelBlock
                                  destructTitle:(NSString *)destructTitle
                                  destructBlock:(UIAlertActionHandler)destructBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:cancelBlock];
    UIAlertAction *destructAction = [UIAlertAction actionWithTitle:destructTitle
                                                          style:UIAlertActionStyleDestructive
                                                        handler:destructBlock];
    [alertController addAction:cancelAction];
    [alertController addAction:destructAction];
    return alertController;
}

+ (UIAlertController *)alertControllerWithTitle:(NSString *)title
                                        message:(NSString *)message
                                    buttonTitle:(NSString *)buttonTitle
                                    handleBlock:(void (^)(UIAlertAction *))handleBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:buttonTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:handleBlock];
    [alertController addAction:cancelAction];
    return alertController;
}

+ (UIAlertController *)alertControllerWithTitle:(NSString *)title
                                        message:(NSString *)message
                                   buttonTitles:(NSArray<NSString *> *)buttonTitles
                                        handler:(void (^)(NSInteger))handler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    for (NSInteger i = 0; i < buttonTitles.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:buttonTitles[i]
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
            if(handler) {
                handler(i);
            }
        }];
        [alertController addAction:action];
    }
    return alertController;
}

+ (UIAlertController *)actionSheetControllerWithTitle:(NSString *)title
                                              message:(NSString *)message
                                         actionModels:(NSArray<UIAlertActionModel *> *)actionModels {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:kIsPad ? UIAlertControllerStyleAlert: UIAlertControllerStyleActionSheet];
    for (UIAlertActionModel *model in actionModels) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:model.title
                                                         style:model.style
                                                       handler:model.handler];
        [alertController addAction:action];
    }
    return alertController;
}

+ (UIAlertController *)actionSheetControllerWithTitle:(NSString *)title
                                              message:(NSString *)message
                                            subTitles:(NSArray<NSString *> *)subTitles
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
    [arr addObject:cancel];
    return [self actionSheetControllerWithTitle:title message:message actionModels:arr];
}

- (void)showWithController:(UIViewController *)controller {
    [self showWithController:controller completion:nil];
}

- (void)showWithController:(UIViewController *)controller completion:(void (^)(void))completion {
    if(controller) {
        [controller presentViewController:self animated:YES completion:completion];
    }
}

@end
