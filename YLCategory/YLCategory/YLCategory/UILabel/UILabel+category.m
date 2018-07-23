
#import "UILabel+category.h"
#import <objc/runtime.h>

static const char UILabelClickedBlockKey = '\0';

@implementation UILabel (category)
#pragma mark - 获取label的size 文字自适应
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
    CGSize size = [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                options:NSStringDrawingUsesLineFragmentOrigin
                             attributes:attributes
                                context:nil].size;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    return size;
}

#pragma mark - 添加单击操作
- (void)setClickedBlock:(UILabelClickedBlock)clickedBlock {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
    [self willChangeValueForKey:@"clickedBlock"];
    objc_setAssociatedObject(self, &UILabelClickedBlockKey, clickedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"clickedBlock"];
}
- (UILabelClickedBlock)clickedBlock {
    return objc_getAssociatedObject(self, &UILabelClickedBlockKey);
}

- (void)tap {
    if(self.clickedBlock) {
        self.clickedBlock(self);
    }
}
#pragma mark -

@end
