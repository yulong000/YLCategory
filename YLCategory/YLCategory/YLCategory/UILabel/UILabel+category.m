//
//  UILabel+category.m
//  YLCategory
//
//  Created by weiyulong on 2018/7/13.
//  Copyright © 2018年 WYL. All rights reserved.
//

#import "UILabel+category.h"

@implementation UILabel (category)
#pragma mark 获取label的size 文字自适应
- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth {
    return [self sizeWithMaxWidth:maxWidth attributes:@{NSFontAttributeName : self.font}];
}

- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth numberOfLines:(NSInteger)lines {
    return [self sizeWithMaxWidth:maxWidth numberOfLines:lines attributes:@{NSFontAttributeName : self.font}];
}

- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth attributes:(NSDictionary *)attributes {
    return [self sizeWithMaxWidth:maxWidth numberOfLines:0 attributes:attributes];
}

- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth numberOfLines:(NSInteger)lines attributes:(NSDictionary *)attributes {
    self.numberOfLines = lines;
    NSString *string = self.text ? self.text : @"";
    return [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                options:NSStringDrawingUsesLineFragmentOrigin
                             attributes:attributes
                                context:nil].size;
}

@end