#import "UIButton+block.h"
#import <objc/runtime.h>

static const char UIButtonClickedBlockKey = '\0';

@implementation UIButton (block)

#pragma mark - block
- (UIButtonClickedBlock)clickedBlock {
    return objc_getAssociatedObject(self, &UIButtonClickedBlockKey);
}

- (void)setClickedBlock:(UIButtonClickedBlock)clickedBlock {
    [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self willChangeValueForKey:@"clickBlock"];
    objc_setAssociatedObject(self, &UIButtonClickedBlockKey, clickedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"clickBlock"];
}

- (void)buttonClick {
    if(self.clickedBlock) {
        self.clickedBlock(self);
    }
}

+ (instancetype)buttonWithTitle:(NSString *)title image:(UIImage *)image backgroundImage:(UIImage *)backgroundImage clickBlock:(UIButtonClickedBlock)clickedBlock {
    UIButton *button =  [[UIButton alloc] init];
    if(title.length)    [button setTitle:title forState:UIControlStateNormal];
    if(image)           [button setImage:image forState:UIControlStateNormal];
    if(backgroundImage) [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    if(clickedBlock)    button.clickedBlock = clickedBlock;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    button.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    [button addTarget:button action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (instancetype)buttonWithTitle:(NSString *)title image:(UIImage *)image clickBlock:(UIButtonClickedBlock)clickedBlock {
    return [UIButton buttonWithTitle:title image:image backgroundImage:nil clickBlock:clickedBlock];
}

+ (instancetype)buttonWithTitle:(NSString *)title clickBlock:(UIButtonClickedBlock)clickedBlock {
    return [UIButton buttonWithTitle:title image:nil clickBlock:clickedBlock];
}

+ (instancetype)buttonWithImage:(UIImage *)image clickBlock:(UIButtonClickedBlock)clickedBlock {
    return [UIButton buttonWithTitle:nil image:image clickBlock:clickedBlock];
}

+ (instancetype)buttonWithClickBlock:(UIButtonClickedBlock)clickedBlock {
    return [UIButton buttonWithTitle:nil clickBlock:clickedBlock];
}

+ (instancetype)buttonWithBackgroundImage:(UIImage *)backgroundImage clickBlock:(UIButtonClickedBlock)clickedBlock {
    return [UIButton buttonWithTitle:nil image:nil backgroundImage:backgroundImage clickBlock:clickedBlock];
}

+ (instancetype)buttonWithTitle:(NSString *)title backgroundImage:(UIImage *)backgroundImage clickBlock:(UIButtonClickedBlock)clickedBlock {
    return [UIButton buttonWithTitle:title image:nil backgroundImage:backgroundImage clickBlock:clickedBlock];
}

@end
