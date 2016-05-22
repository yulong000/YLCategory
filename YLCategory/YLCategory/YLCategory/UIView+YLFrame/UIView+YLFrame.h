

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface UIView (YLFrame)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize  size;
@property (assign, nonatomic) CGPoint origin;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;
@property (assign, nonatomic) CGFloat bottom;
@property (assign, nonatomic) CGFloat right;
@property (assign, readonly, nonatomic) CGFloat maxX;
@property (assign, readonly, nonatomic) CGFloat maxY;

@end
