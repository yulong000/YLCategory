
#import "NSString+bounds.h"

@implementation NSString (bounds)

- (CGSize)sizeWithMaxWidth:(CGFloat)maxWidth font:(UIFont *)font {
    return [self sizeWithAttributes:@{NSFontAttributeName : font}];
}

@end
