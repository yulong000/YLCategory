
#import "UIView+gesture.h"
#import <objc/runtime.h>

static const char UIViewGestureBlockKey = '\0';

@implementation UIView (gesture)

- (void)setGestureBlock:(UIViewGestureBlock)gestureBlock {
    [self willChangeValueForKey:@"gestureBlock"];
    objc_setAssociatedObject(self, &UIViewGestureBlockKey, gestureBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"gestureBlock"];
}

- (UIViewGestureBlock)gestureBlock {
    return objc_getAssociatedObject(self, &UIViewGestureBlockKey);
}

- (void)addTapGestureHandleBlock:(UIViewGestureBlock)handle {
    self.userInteractionEnabled = YES;
    self.gestureBlock = handle;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}

- (void)tap:(UIGestureRecognizer *)tap {
    if(self.gestureBlock) {
        self.gestureBlock(self, tap);
    }
}
@end
