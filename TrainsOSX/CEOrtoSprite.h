#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface CEOrtoSprite : CCSprite

- (void)setStart:(CGPoint)start end:(CGPoint)end;

- (void)addAngle:(CGFloat)angle rect:(CGRect)rect shift:(CGPoint)shift;
@end