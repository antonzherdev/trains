#import "cr.h"


@interface CRCar : CCSprite
@property(nonatomic, readonly) CGFloat length;

+ (id)carWithType:(CRCarType)type color:(CRCityColor)color;

- (id)initWithType:(CRCarType)type color:(CRCityColor)color;

- (void)setStart:(CGPoint)start end:(CGPoint)end;
@end