//
//  NSString+bounds.h
//  YLCategory
//
//  Created by weiyulong on 2018/7/13.
//  Copyright © 2018年 WYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface NSString (bounds)

/**
 获取string的size

 @param maxWidth 最大的宽度
 @param font 字体
 */
- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth font:(UIFont *)font;

@end
