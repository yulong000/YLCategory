#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 通知回调
typedef void (^YLNotificationHandler)(NSNotification * _Nonnull note);

@interface NSObject (category)

/**  长度不为0的字符串  */
- (BOOL)isValidString;

/**  是否是 [NSNull null]  */
- (BOOL)isNull;

/// 发送通知
- (void)postNotificationWithName:(NSString * _Nonnull)name;
- (void)postNotificationWithName:(NSString * _Nonnull)name userInfo:(NSDictionary * _Nullable)userInfo;
/// 监听通知
- (void)addNotificationName:(NSString * _Nonnull)name handler:(YLNotificationHandler _Nullable)handler;
/// 移除监听通知
- (void)removeAllNotifications;

/// 获取显示在最上面的控制器
+ (UIViewController *)topVc;

/// 获取缓存大小
+ (NSString *)getCacheInfo;
/// 清除缓存
+ (void)clearCache;

@end

NS_ASSUME_NONNULL_END
