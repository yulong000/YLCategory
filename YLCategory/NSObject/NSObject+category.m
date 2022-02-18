#import "NSObject+category.h"
#import <sys/utsname.h>

@implementation NSObject (category)

#pragma mark 是否是长度不为0的字符串
- (BOOL)isValidString {
    if([self isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)self;
        return str.length > 0;
    }
    return NO;
}

#pragma mark 是否是 [NSNull null]
- (BOOL)isNull {
    return [self isKindOfClass:[NSNull class]];
}

#pragma mark 获取显示在最上面的控制器
+ (UIViewController *)topVc {
    UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVc = rootVc;
    while (rootVc) {
        if(rootVc.presentedViewController) {
            topVc = rootVc = rootVc.presentedViewController;
        } else if([rootVc isKindOfClass:[UITabBarController class]]) {
            topVc = rootVc = ((UITabBarController *)rootVc).selectedViewController;
        } else if([rootVc isKindOfClass:[UINavigationController class]]) {
            topVc = rootVc = ((UINavigationController *)rootVc).visibleViewController;
        } else {
            rootVc = nil;
        }
    }
    return topVc;
}

#pragma mark 获取缓存大小
+ (NSString *)getCacheInfo {
    __block unsigned long long size = 0;
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSArray *fileArr = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    for (NSString *file in fileArr) {
        NSString *path = [cachePath stringByAppendingPathComponent:file];
        NSDictionary *attr = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:NULL];
        [attr enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            size += attr.fileSize;
        }];
    }
    float base = 1000.0;
    if(size > base * base * base) {
        // GB
        return [NSString stringWithFormat:@"%.2fGB", size / base / base / base];
    }
    if(size > base * base) {
        // MB
         return [NSString stringWithFormat:@"%.2fMB", size / base / base];
    }
    // KB
    return [NSString stringWithFormat:@"%.2fKB", size / base];
}

#pragma mark 清除缓存
+ (void)clearCache {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSArray *fileArr = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    for (NSString *file in fileArr) {
        NSString *path = [cachePath stringByAppendingPathComponent:file];
        if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
        }
    }
}

@end
