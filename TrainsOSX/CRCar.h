#import "cr.h"


@interface CRCar : CEOrtoSprite
@property(nonatomic, readonly) CGFloat length;

+ (id)carWithType:(CRCarType)type color:(CRCityColor)color;

- (id)initWithType:(CRCarType)type color:(CRCityColor)color;
@end