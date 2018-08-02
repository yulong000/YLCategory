//
//  NSObject+category.m
//  YLCategory
//
//  Created by weiyulong on 2018/8/1.
//  Copyright © 2018年 WYL. All rights reserved.
//

#import "NSObject+category.h"

@implementation NSObject (category)

#pragma mark 是否是长度不为0的字符串
- (BOOL)isValidString {
    if([self isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)self;
        return str.length;
    }
    return NO;
}

@end
