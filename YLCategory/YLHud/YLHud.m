//
//  YLHud.m
//  YLHud
//
//  Created by 魏宇龙 on 2023/4/23.
//

#import "YLHud.h"

#define kHUDMinWidth            120                                                 // 最小的宽度
#define kHUDMaxWidth            ([UIScreen mainScreen].bounds.size.width * 0.8)     // 最大的宽度，超过宽度换行
#define kHUDIconWH              37                                                  // 图标的大小

typedef NS_ENUM(NSInteger, YLHudShowStyle) {
    YLHudShowStyleCustom,       // 自定义
    YLHudShowStyleLoading,      // loading
    YLHudShowStyleText,         // 文字
    YLHudShowStyleSuccess,      // 成功
    YLHudShowStyleFailure,      // 失败
    YLHudShowStyleProgress,     // 进度环
};

#pragma mark - 进度环

@interface YLHudProgressView : UIView
/// 主题色
@property (nonatomic, assign) YLHudTheme theme;
/// 进度
@property (nonatomic, assign) CGFloat progress;
/// 将progress转换成百分比字符串
@property (nonatomic, copy)   NSString *progressText;

@end

@implementation YLHudProgressView

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)setTheme:(YLHudTheme)theme {
    _theme = theme;
    [self setNeedsDisplay];
}

- (void)setProgress:(CGFloat)progress {
    _progress = MIN(1, MAX(0, progress));;
    self.progressText = [NSString stringWithFormat:@"%d%%", (int)(_progress * 100)];
    self.backgroundColor = [UIColor clearColor];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 2);
    if(self.theme == YLHudThemeDark) {
        [[UIColor whiteColor] set];
    } else {
        [[UIColor blackColor] set];
    }
    
    CGFloat centerX = CGRectGetMidX(rect);
    CGFloat centerY = CGRectGetMidY(rect);
    CGFloat radius1 = rect.size.height / 2 - 2;
    CGFloat radius2 = radius1 - 3;
    
    // 外层的圆
    CGContextAddArc(ctx, centerX, centerY, radius1, 0, M_PI * 2, 0);
    CGContextStrokePath(ctx);
    
    // 内部的进度
    CGFloat end = M_PI * 2 * self.progress - M_PI_2;
    CGContextAddArc(ctx, centerX, centerY, radius2, - M_PI_2, end, 0);
    CGContextAddLineToPoint(ctx, centerX, centerY);
    CGContextAddLineToPoint(ctx, centerX, centerY - radius2);
    CGContextFillPath(ctx);
}

@end

#pragma mark - hud

@interface YLHud ()

/// 阴影
@property (nonatomic, strong) UIView *shadowView;
/// hud内容
@property (nonatomic, strong) UIView *contentView;
/// 文本
@property (nonatomic, strong) UILabel *textLabel;
/// 菊花
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
/// 进度环
@property (nonatomic, strong) YLHudProgressView *progressView;
/// 成功｜失败｜自定义
@property (nonatomic, strong) UIView *customView;

/// 主题
@property (nonatomic, assign) YLHudTheme theme;
/// 样式
@property (nonatomic, assign) YLHudShowStyle style;
/// 完成后的回调
@property (nonatomic, copy)   YLHudCompletionHandler completionHandler;

@end

@implementation YLHud

#pragma mark -

+ (YLHud *)createHudWithStyle:(YLHudShowStyle)style toView:(UIView *)toView {
    UIView *superView = [YLHud getHUDSuperViewWithInputView:toView];
    YLHud *hud = [[YLHud alloc] initWithFrame:superView.bounds];
    YLHudTheme theme = YLHudConfig.share.theme;
    if(theme == YLHudThemeAuto) {
        hud.theme = YLHudThemeLight;
        if(@available(iOS 13.0, *)) {
            if(UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                hud.theme = YLHudThemeDark;
            }
        }
    } else {
        hud.theme = theme;
    }
    hud.style = style;
    [superView addSubview:hud];
    return hud;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if(self = [super initWithCoder:coder]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.shadowView = [[UIView alloc] init];
    self.shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(0, 0);
    self.shadowView.layer.shadowOpacity = 0.3;
    self.shadowView.layer.shadowRadius = 2;
    [self addSubview:self.shadowView];
    
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    self.contentView.clipsToBounds = YES;
    self.contentView.layer.cornerRadius = 10;
    [self.shadowView addSubview:self.contentView];
    
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.font = [UIFont boldSystemFontOfSize:16];
    self.textLabel.textColor = YLHudConfig.share.textColor;
    self.textLabel.numberOfLines = 15;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.textLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat shadowCenterY = height * 0.4;
    switch (self.style) {
        case YLHudShowStyleCustom:
        case YLHudShowStyleSuccess:
        case YLHudShowStyleFailure:
        case YLHudShowStyleLoading:
        case YLHudShowStyleProgress: {
            if(self.textLabel.text.length) {
                // 有文字
                CGSize textSize = [self.textLabel sizeThatFits:CGSizeMake(kHUDMaxWidth - 30, MAXFLOAT)];
                CGSize iconSize = CGSizeMake(kHUDIconWH, kHUDIconWH);
                CGSize contentSize = CGSizeMake(MAX(textSize.width + 30, kHUDMinWidth), MAX(kHUDIconWH + textSize.height + 45, kHUDMinWidth));
                self.shadowView.frame = (CGRect){CGPointMake((width - contentSize.width) / 2, shadowCenterY - contentSize.height / 2), contentSize};
                self.contentView.frame = self.shadowView.bounds;
                CGFloat space = (contentSize.height - iconSize.height - textSize.height) / 3;  // icon, text 上下间距
                self.customView.frame = (CGRect){CGPointMake((contentSize.width - iconSize.width) / 2, space), iconSize};
                self.textLabel.frame = (CGRect){CGPointMake((contentSize.width - textSize.width) / 2, CGRectGetMaxY(self.customView.frame) + space), textSize};
            } else {
                // 没有文字, 只显示图标
                self.shadowView.frame = CGRectMake((width - kHUDMinWidth) / 2, shadowCenterY - kHUDMinWidth / 2, kHUDMinWidth, kHUDMinWidth);
                self.contentView.frame = self.shadowView.bounds;
                self.customView.frame = CGRectMake(0, 0, kHUDIconWH, kHUDIconWH);
                self.customView.center = CGPointMake(kHUDMinWidth / 2, kHUDMinWidth / 2);
            }
        }
            break;
        case YLHudShowStyleText: {
            CGSize textSize = [self.textLabel sizeThatFits:CGSizeMake(kHUDMaxWidth - 30, MAXFLOAT)];
            CGSize contentSize = CGSizeMake(textSize.width + 30, textSize.height + 30);
            self.shadowView.frame = (CGRect){CGPointMake((width - contentSize.width) / 2, shadowCenterY - contentSize.height / 2), contentSize};
            self.contentView.frame = self.shadowView.bounds;
            self.textLabel.frame = (CGRect){CGPointMake((contentSize.width - textSize.width) / 2, (contentSize.height - textSize.height) / 2), textSize};
        }
            break;
        default:
            break;
    }
}

- (void)setStyle:(YLHudShowStyle)style {
    _style = style;
    switch (style) {
        case YLHudShowStyleCustom: {
            [self.customView removeFromSuperview];
        }
            break;
        case YLHudShowStyleLoading: {
            [self.customView removeFromSuperview];
            self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            self.indicatorView.color = self.theme == YLHudThemeDark ? [UIColor whiteColor] : [UIColor blackColor];
            [self.indicatorView startAnimating];
            self.customView = self.indicatorView;
            [self.contentView addSubview:self.indicatorView];
        }
            break;
        case YLHudShowStyleSuccess: {
            [self.customView removeFromSuperview];
            self.customView = [[UIImageView alloc] initWithImage:[self successImage]];
            [self.contentView addSubview:self.customView];
        }
            break;
        case YLHudShowStyleFailure: {
            [self.customView removeFromSuperview];
            self.customView = [[UIImageView alloc] initWithImage:[self errorImage]];
            [self.contentView addSubview:self.customView];
        }
            break;
        case YLHudShowStyleText: {
            [self.customView removeFromSuperview];
            self.customView = nil;
        }
            break;
        case YLHudShowStyleProgress: {
            if([self.customView isKindOfClass:[YLHudProgressView class]] == NO) {
                [self.customView removeFromSuperview];
                self.progressView = [[YLHudProgressView alloc] init];
                self.customView = self.progressView;
                [self.contentView addSubview:self.progressView];
            }
            self.progressView.theme = self.theme;
        }
            break;
        default:
            break;
    }
    self.textLabel.textColor = YLHudConfig.share.textColor ?: (self.theme == YLHudThemeDark ? [UIColor whiteColor] : [UIColor colorWithWhite:0.2 alpha:1]);
    self.shadowView.layer.shadowColor = self.theme == YLHudThemeDark ? [UIColor whiteColor].CGColor : [UIColor blackColor].CGColor;
    self.contentView.backgroundColor = YLHudConfig.share.hudColor ?: (self.theme == YLHudThemeDark ? [UIColor colorWithWhite:0.15 alpha:1] : [UIColor colorWithWhite:0.85 alpha:1]);
    [self setNeedsLayout];
}

- (UIImage *)successImage {
    if(YLHudConfig.share.successImage) {
        return YLHudConfig.share.successImage;
    }
    if(self.theme == YLHudThemeDark) {
        return [YLHud bundleImage:@"success_white"];
    }
    return [YLHud bundleImage:@"success_black"];
}

- (UIImage *)errorImage {
    if(YLHudConfig.share.errorImage) {
        return YLHudConfig.share.errorImage;
    }
    if(self.theme == YLHudThemeDark) {
        return [YLHud bundleImage:@"error_white"];
    }
    return [YLHud bundleImage:@"error_black"];
}


#pragma mark - 显示成功

+ (YLHud *)showSuccess:(NSString *)success {
    return [self showSuccess:success toView:nil];
}
+ (YLHud *)showSuccess:(NSString *)success hideAfterDelay:(CGFloat)second {
    return [self showSuccess:success hideAfterDelay:second completion:nil];
}
+ (YLHud *)showSuccess:(NSString *)success completion:(YLHudCompletionHandler)handler {
    return [self showSuccess:success toView:nil completion:handler];
}
+ (YLHud *)showSuccess:(NSString *)success hideAfterDelay:(CGFloat)second completion:(YLHudCompletionHandler)handler {
    return [self showSuccess:success toView:nil hideAfterDelay:second completion:handler];
}
+ (YLHud *)showSuccess:(NSString *)success toView:(UIView *)view {
    return [self showSuccess:success toView:view completion:nil];
}
+ (YLHud *)showSuccess:(NSString *)success toView:(UIView *)view hideAfterDelay:(CGFloat)second {
    return [self showSuccess:success toView:view hideAfterDelay:second completion:nil];
}
+ (YLHud *)showSuccess:(NSString *)success toView:(UIView *)view completion:(YLHudCompletionHandler)handler {
    return [self showSuccess:success toView:view hideAfterDelay:[YLHudConfig share].hideAfterSecond completion:handler];
}
+ (YLHud *)showSuccess:(NSString *)success toView:(UIView *)view hideAfterDelay:(CGFloat)second completion:(YLHudCompletionHandler)handler {
    YLHud *hud = [YLHud createHudWithStyle:YLHudShowStyleSuccess toView:view];
    hud.textLabel.text = success;
    hud.completionHandler = handler;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide];
    });
    return hud;
}


#pragma mark - 显示失败

+ (YLHud *)showError:(NSString *)error {
    return [self showError:error toView:nil];
}
+ (YLHud *)showError:(NSString *)error hideAfterDelay:(CGFloat)second {
    return [self showError:error toView:nil hideAfterDelay:second];
}
+ (YLHud *)showError:(NSString *)error completion:(YLHudCompletionHandler)handler {
    return [self showError:error toView:nil completion:handler];
}
+ (YLHud *)showError:(NSString *)error hideAfterDelay:(CGFloat)second completion:(YLHudCompletionHandler)handler {
    return [self showError:error toView:nil hideAfterDelay:second completion:handler];
}
+ (YLHud *)showError:(NSString *)error toView:(UIView *)view {
    return [self showError:error toView:view completion:nil];
}
+ (YLHud *)showError:(NSString *)error toView:(UIView *)view hideAfterDelay:(CGFloat)second {
    return [self showError:error toView:view hideAfterDelay:second completion:nil];
}
+ (YLHud *)showError:(NSString *)error toView:(UIView *)view completion:(YLHudCompletionHandler)handler {
    return [self showError:error toView:view hideAfterDelay:[YLHudConfig share].hideAfterSecond completion:handler];
}
+ (YLHud *)showError:(NSString *)error toView:(UIView *)view hideAfterDelay:(CGFloat)second completion:(YLHudCompletionHandler)handler {
    YLHud *hud = [YLHud createHudWithStyle:YLHudShowStyleFailure toView:view];
    hud.textLabel.text = error;
    hud.completionHandler = handler;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide];
    });
    return hud;
}


#pragma mark - 显示loading

+ (YLHud *)showLoading:(NSString *)message {
    return [YLHud showLoading:message toView:nil];
}
+ (YLHud *)showLoading:(NSString *)message toView:(UIView *)view {
    YLHud *hud = [YLHud createHudWithStyle:YLHudShowStyleLoading toView:view];
    hud.textLabel.text = message;
    return hud;
}


#pragma mark - 显示文本

+ (YLHud *)showText:(NSString *)text {
    return [self showText:text toView:nil];
}
+ (YLHud *)showText:(NSString *)text hiddenAfterDelay:(CGFloat)second {
    return [self showText:text toView:nil hiddenAfterDelay:second];
}
+ (YLHud *)showText:(NSString *)text completion:(YLHudCompletionHandler)handler {
    return [self showText:text toView:nil completion:handler];
}
+ (YLHud *)showText:(NSString *)text hiddenAfterDelay:(CGFloat)second completion:(YLHudCompletionHandler)handler {
    return [self showText:text toView:nil hiddenAfterDelay:second completion:handler];
}
+ (YLHud *)showText:(NSString *)text toView:(UIView *)view {
    return [self showText:text toView:view completion:nil];
}
+ (YLHud *)showText:(NSString *)text toView:(UIView *)view hiddenAfterDelay:(CGFloat)second {
    return [self showText:text toView:view hiddenAfterDelay:second completion:nil];
}
+ (YLHud *)showText:(NSString *)text toView:(UIView *)view completion:(YLHudCompletionHandler)handler {
    return [self showText:text toView:view hiddenAfterDelay:[YLHudConfig share].hideAfterSecond completion:handler];
}
+ (YLHud *)showText:(NSString *)text toView:(UIView *)view hiddenAfterDelay:(CGFloat)second completion:(YLHudCompletionHandler)handler {
    YLHud *hud = [YLHud createHudWithStyle:YLHudShowStyleText toView:view];
    hud.textLabel.text = text;
    hud.completionHandler = handler;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide];
    });
    return hud;
}


#pragma mark - 显示进度环

+ (YLHud *)showProgress:(CGFloat)progress {
    return [self showProgress:progress text:nil];
}
+ (YLHud *)showProgress:(CGFloat)progress text:(NSString *)text {
    return [self showProgress:progress text:text toView:nil];
}
+ (YLHud *)showProgress:(CGFloat)progress toView:(UIView *)view {
    return [self showProgress:progress text:nil toView:view];
}
+ (YLHud *)showProgress:(CGFloat)progress text:(NSString *)text toView:(UIView *)view {
    YLHud *hud = [YLHud createHudWithStyle:YLHudShowStyleProgress toView:view];
    hud.progressView.progress = progress;
    hud.textLabel.text = text ?: hud.progressView.progressText;
    return hud;
}

#pragma mark - 显示自定义组件

+ (YLHud *)showWithCustomView:(UIView *)customView text:(NSString *)text toView:(UIView *)view {
    YLHud *hud = [YLHud createHudWithStyle:YLHudShowStyleCustom toView:view];
    hud.customView = customView;
    hud.textLabel.text = text;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(YLHudConfig.share.hideAfterSecond * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide];
    });
    return hud;
}


#pragma mark - 隐藏hud

+ (void)hideHUD {
    [self hideHUDForView:nil];
}
+ (void)hideHUDForView:(UIView *)view {
    view = [self getHUDSuperViewWithInputView:view];
    [view.subviews.reverseObjectEnumerator.allObjects enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:self]) {
            [((YLHud *)obj) hide];
        }
    }];
}


#pragma mark - 切换显示模式

- (void)showLoading:(NSString *)message {
    self.style = YLHudShowStyleLoading;
    self.textLabel.text = message;
}
- (void)showText:(NSString *)text {
    [self showText:text hideAfterDelay:YLHudConfig.share.hideAfterSecond];
}
- (void)showSuccess:(NSString *)success {
    [self showSuccess:success hideAfterDelay:YLHudConfig.share.hideAfterSecond];
}
- (void)showError:(NSString *)error {
    [self showError:error hideAfterDelay:YLHudConfig.share.hideAfterSecond];
}
- (void)showProgress:(CGFloat)progress {
    [self showProgress:progress text:nil];
}

- (void)showText:(NSString *)text hideAfterDelay:(CGFloat)second {
    self.style = YLHudShowStyleText;
    self.textLabel.text = text;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
    });
}
- (void)showSuccess:(NSString *)success hideAfterDelay:(CGFloat)second {
    self.style = YLHudShowStyleSuccess;
    self.textLabel.text = success;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
    });
}
- (void)showError:(NSString *)error hideAfterDelay:(CGFloat)second {
    self.style = YLHudShowStyleFailure;
    self.textLabel.text = error;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
    });
}
- (void)showProgress:(CGFloat)progress text:(NSString *)text {
    self.style = YLHudShowStyleProgress;
    self.progressView.progress = progress;
    self.textLabel.text = text ?: self.progressView.progressText;
}
- (void)hide {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if(self.completionHandler) {
            self.completionHandler();
        }
    }];
}

#pragma mark 当传入的view 为 nil 时,将hud添加到 window 上
+ (UIView *)getHUDSuperViewWithInputView:(UIView *)inputView {
    if(inputView)   return inputView;
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            [window isKindOfClass:NSClassFromString(@"UITextEffectsWindow")] == NO &&
            [window isKindOfClass:NSClassFromString(@"UIRemoteKeyboardWindow")] == NO &&
            [window isKindOfClass:NSClassFromString(@"FLEXWindow")] == NO &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            return window;
    }
    return [UIApplication sharedApplication].keyWindow;
}

#pragma mark 获取bundle里的图片
+ (UIImage *)bundleImage:(NSString *)icon {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"YLHud" withExtension:@"bundle"];
    if(url == nil) {
        url = [[[[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil] URLByAppendingPathComponent:@"YLHud"] URLByAppendingPathExtension:@"framework"];
        NSBundle *bundle = [NSBundle bundleWithURL:url];
        url = [bundle URLForResource:@"YLHud" withExtension:@"bundle"];
    }
    NSString *path = [[NSBundle bundleWithURL:url].bundlePath stringByAppendingPathComponent:icon];
    return [UIImage imageWithContentsOfFile:path];
}


@end


#pragma mark - 配置

@implementation YLHudConfig

+ (instancetype)share {
    static YLHudConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[YLHudConfig alloc] init];
        config.theme = YLHudThemeAuto;
        config.hideAfterSecond = 1.0;
    });
    return config;
}

@end
