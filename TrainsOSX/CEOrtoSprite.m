#import "CEOrtoSprite.h"


@implementation CEOrtoSprite {
    CGPoint _shift;
}
@synthesize shift = _shift;

- (void)setStart:(CGPoint)start end:(CGPoint)end {
    CGFloat angle = (end.x - start.x) / (end.y - start.y);
    [self setFlipX:angle > 0];

    self.position = ccp((end.x + start.x)/2 + _shift.x, (end.y + start.y)/2 + _shift.y);
}
@end