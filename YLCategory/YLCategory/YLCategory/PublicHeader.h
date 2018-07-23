//
//  PublicHeader.h
//  YLCategory
//
//  Created by weiyulong on 2018/6/29.
//  Copyright © 2018年 WYL. All rights reserved.
//

#ifndef PublicHeader_h
#define PublicHeader_h


/****************************************  尺寸  ***********************************/

//屏幕宽、高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kIsIphoneX CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812))   // 是否是IphoneX
#define kIphoneXTopSafeAreaHeight       44.0f   // iPhonex上面的安全区域
#define kIphoneXBottomSafeAreaHeight    34.0f   // iPhonex下面的安全区域
#define kTabbarHeight       (kIsIphoneX ? 83.0f : 49.0f)    // 下面tabbar的高度
#define kNavTotalHeight     (kIsIphoneX ? 88.0f : 64.0f)  // 上面导航栏总高度


/****************************************  颜色  ***********************************/


// 纯白色
#define WhiteColor     [UIColor whiteColor]
// 纯黑色
#define BlackColor     [UIColor blackColor]
// 透明色
#define ClearColor     [UIColor clearColor]
// 灰色
#define GrayColor      [UIColor grayColor]
// 深灰色
#define DarkGrayColor  [UIColor darkGrayColor]   // 0.333 white
// 亮灰色
#define LightGrayColor [UIColor lightGrayColor]  // 0.667 white
// 红色
#define RedColor       [UIColor redColor]
// 绿色
#define GreenColor     [UIColor greenColor]
// 橙色
#define OrangeColor    [UIColor orangeColor]
// 黄色
#define YellowColor    [UIColor yellowColor]
// 蓝色
#define BlueColor      [UIColor blueColor]
// r, g, b ,a 颜色
#define RGBA(r, g, b, a)    [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]
// 随机颜色
#define RandomColor         [UIColor colorWithRed:arc4random() % 255 green:arc4random() % 255 blue:arc4random() % 255 alpha:1]
// 十六进制获取颜色
#define UIColorFromHex(s)   [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s & 0xFF00) >> 8))/255.0 blue:((s & 0xFF))/255.0  alpha:1.0]


/****************************************  数据类型转换  ***********************************/

// int float -> string
#define NSStringFromInt(int) [NSString stringWithFormat:@"%d", int]
#define NSStringFromUInt(int) [NSString stringWithFormat:@"%u", int]
#define NSStringFromInteger(integer) [NSString stringWithFormat:@"%ld", integer]
#define NSStringFromFloat(float) [NSString stringWithFormat:@"%f", float]
#define NSStringFromFloatPrice(float) [NSString stringWithFormat:@"%.2f", float]



/****************************************  字体  ***********************************/

// 字体大小
#define UIFontSize(size)  [UIFont systemFontOfSize:size]

#endif /* PublicHeader_h */
