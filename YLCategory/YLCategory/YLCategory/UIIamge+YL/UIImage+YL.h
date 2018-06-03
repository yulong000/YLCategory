//
//  UIImage+YL.h
//  UIImageBlurredFrameExample
//
//  Created by WYL on 15/12/28.
//  Copyright © 2015年 Icalia Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YL)

/**
 *  裁剪圆形图片 （以宽度最大边界）
 *
 *  @param image       原始图片
 *  @param borderWidth 边框的宽度
 *  @param borderColor 边框的颜色
 *
 *  @return 裁剪后的图片
 */
+ (instancetype)circleImage:(UIImage *)image
                borderWidth:(CGFloat)borderWidth
                borderColor:(UIColor *)borderColor;

/**
 *  获取图片上某个点的颜色
 *
 *  @param point 点坐标
 *
 *  @return 获取到的颜色
 */
- (UIColor *)colorAtPixel:(CGPoint)point;


/// ------------------------------------
/// @name 高斯模糊
/// ------------------------------------
- (UIImage *)applyLightEffectAtFrame:(CGRect)frame;
- (UIImage *)applyExtraLightEffectAtFrame:(CGRect)frame;
- (UIImage *)applyDarkEffectAtFrame:(CGRect)frame;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor atFrame:(CGRect)frame;
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage
                         atFrame:(CGRect)frame;
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                 iterationsCount:(NSInteger)iterationsCount
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage
                         atFrame:(CGRect)frame;

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                 iterationsCount:(NSInteger)iterationsCount
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage;


/**
 *  获取网络图片的 size
 *
 *  @param imageURL 图片的 url 地址 (NSSring / NSURL)
 *
 */
+ (CGSize)imageSizeWithURL:(id)imageURL;

@end
