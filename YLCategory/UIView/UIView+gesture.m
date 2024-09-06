
#import "UIView+gesture.h"
#import <objc/runtime.h>

@implementation UIView (gesture)

#pragma mark - 点击手势

- (void)setTapGestureHandler:(UIViewTapGestureHandler)tapGestureHandler {
    objc_setAssociatedObject(self, @selector(tapGestureHandler), tapGestureHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIViewTapGestureHandler)tapGestureHandler {
    return objc_getAssociatedObject(self, _cmd);
}

- (UITapGestureRecognizer *)addTapGestureWithDelegate:(id)delegate handler:(UIViewTapGestureHandler)handler {
    self.userInteractionEnabled = YES;
    self.tapGestureHandler = [handler copy];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    if(delegate) tap.delegate = delegate;
    [self addGestureRecognizer:tap];
    return tap;
}

- (UITapGestureRecognizer *)addTapGestureWithHandler:(UIViewTapGestureHandler)handler {
    return [self addTapGestureWithDelegate:nil handler:handler];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    if(self.tapGestureHandler) {
        self.tapGestureHandler(self, tap);
    }
}

#pragma mark - 拖动手势

- (void)setPanGestureHandler:(UIViewPanGestureHandler)panGestureHandler {
    objc_setAssociatedObject(self, @selector(panGestureHandler), panGestureHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIViewPanGestureHandler)panGestureHandler {
    return objc_getAssociatedObject(self, _cmd);
}

- (UIPanGestureRecognizer *)addPanGestureWithDelegate:(id)delegate handler:(UIViewPanGestureHandler)handler {
    self.userInteractionEnabled = YES;
    self.panGestureHandler = [handler copy];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    if(delegate) pan.delegate = delegate;
    [self addGestureRecognizer:pan];
    return pan;
}

- (UIPanGestureRecognizer *)addPanGestureWithHandler:(UIViewPanGestureHandler)handler {
    return [self addPanGestureWithDelegate:nil handler:handler];
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    if(self.panGestureHandler) {
        self.panGestureHandler(self, pan);
    }
}

#pragma mark - 长按手势

- (void)setLongPressGestureHandler:(UIViewLongPressGestureHandler)longPressGestureHandler {
    objc_setAssociatedObject(self, @selector(longPressGestureHandler), longPressGestureHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIViewLongPressGestureHandler)longPressGestureHandler {
    return objc_getAssociatedObject(self, _cmd);
}

- (UILongPressGestureRecognizer *)addLongPressGestureWithDelegate:(id)delegate handler:(UIViewLongPressGestureHandler)handler {
    self.userInteractionEnabled = YES;
    self.longPressGestureHandler = [handler copy];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    if(delegate) longPress.delegate = delegate;
    [self addGestureRecognizer:longPress];
    return longPress;
}

- (UILongPressGestureRecognizer *)addLongPressGestureWithHandler:(UIViewLongPressGestureHandler)handler {
    return [self addLongPressGestureWithDelegate:nil handler:handler];
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress {
    if(self.longPressGestureHandler) {
        self.longPressGestureHandler(self, longPress);
    }
}


@end
