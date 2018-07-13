//
//  NSString+bounds.m
//  YLCategory
//
//  Created by weiyulong on 2018/7/13.
//  Copyright © 2018年 WYL. All rights reserved.
//

#import "NSString+bounds.h"

@implementation NSString (bounds)

- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth font:(UIFont *)font {
    return [self sizeWithAttributes:@{NSFontAttributeName : font}];
}

@end
