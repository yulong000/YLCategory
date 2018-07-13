//
//  UILabel+category.h
//  YLCategory
//
//  Created by weiyulong on 2018/7/13.
//  Copyright © 2018年 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (category)

/**
 获取label的size, 文字自适应

 @param maxWidth 最大的宽度
 */
- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth;

/**
 获取label的size, 文字自适应
 
 @param maxWidth 最大的宽度
 @param lines 行数
 */
- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth numberOfLines:(NSInteger)lines;

/**
 获取label的size, 文字自适应
 
 @param maxWidth 最大的宽度
 @param attributes 文字属性
 */
- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth attributes:(NSDictionary *)attributes;


/**
 获取label的size, 文字自适应

 @param maxWidth 最大的宽度
 @param lines 行数
 @param attributes 文字属性
 */
- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth numberOfLines:(NSInteger)lines attributes:(NSDictionary *)attributes;

@end
