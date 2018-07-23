#import "UIButton+block.h"
#import <objc/runtime.h>

static const char UIButtonClickedBlockKey = '\0';
static const char UIButtonAreaInsetsKey = '\0';

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

+ (instancetype)buttonWithTitle:(NSString *)title image:(UIImage *)image clickBlock:(UIButtonClickedBlock)clickedBlock {
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    if(title.length)    [button setTitle:title forState:UIControlStateNormal];
    if(image)           [button setImage:image forState:UIControlStateNormal];
    if(clickedBlock)    button.clickedBlock = clickedBlock;
    [button addTarget:button action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    return button;
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

#pragma mark - add click area
- (void)addClickArea:(UIEdgeInsets)insets {
    [self willChangeValueForKey:@"areaInsets"];
    objc_setAssociatedObject(self, &UIButtonAreaInsetsKey, [NSValue valueWithUIEdgeInsets:insets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"areaInsets"];
}

// 有效区域
- (CGRect)validArea {
    UIEdgeInsets insets = [objc_getAssociatedObject(self, &UIButtonAreaInsetsKey) UIEdgeInsetsValue];
    if(insets.top && insets.left && insets.bottom && insets.right) {
        return CGRectMake(- insets.left,
                          - insets.top,
                          self.bounds.size.width + insets.left + insets.right,
                          self.bounds.size.height + insets.top + insets.bottom);
    }
    return self.bounds;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self validArea];
    if(CGRectEqualToRect(rect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point);
}

@end
