#import <UIKit/UIKit.h>

@interface UIColor (category)

/**
 随机色
 */
+ (UIColor *)RandomColor;

/**
 *  由16进制颜色格式生成UIColor (0xffffff)
 *
 *  @param alpha 透明度
 */
+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(UInt32)hex;

/**
 *  由16进制颜色字符串格式生成UIColor
 *
 *  @param hex 16进制颜色#00FF00
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end
