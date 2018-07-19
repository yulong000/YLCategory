#import "UIAlertController+block.h"

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

+ (UIAlertController *)alertControllerWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle handlelock:(void (^)(UIAlertAction *))handleBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:buttonTitle
                                                           style:UIAlertActionStyleCancel
                                                         handler:handleBlock];
    [alertController addAction:cancelAction];
    return alertController;
}

- (void)showWithController:(UIViewController *)controller {
    [self showWithController:controller completion:nil];
}

- (void)showWithController:(UIViewController *)controller completion:(void (^__nullable)(void))completion {
    if(controller) {
        [controller presentViewController:self animated:YES completion:completion];
    }
}

@end