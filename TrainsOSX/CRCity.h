#import "cr.h"

@interface CRCity : CCSprite
@property(nonatomic, readonly) CRCityColor cityColor;
@property(nonatomic, readonly) CEIPoint tile;


+ (id)cityWithColor:(CRCityColor)color orientation:(CRCityOrientation)orientation tile:(CEIPoint)tile;

- (id)initWithColor:(CRCityColor)color orientation:(CRCityOrientation)orientation tile:(CEIPoint)tile;

- (CRRailPoint)startRailPoint;

- (CRDirection)startTrainOrientation;

- (CRRailForm) form;
@end