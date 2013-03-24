#import "cr.h"

@interface CRCity : NSObject
@property(nonatomic, readonly) CRCityColor* cityColor;
@property(nonatomic, readonly) CEIPoint tile;
@property(nonatomic, readonly) CRCityOrientation orientation;

+ (id)cityWithColor:(CRCityColor*)color orientation:(CRCityOrientation)orientation tile:(CEIPoint)tile;

- (id)initWithColor:(CRCityColor*)color orientation:(CRCityOrientation)orientation tile:(CEIPoint)tile;

+ (CRDirection)directionForCityInTile:(CEIPoint)point form:(CRRailForm*)form railroad:(CRRailroad *)railroad;

- (CRRailForm*) form;

- (CRRailType) railType;

- (CRRailVector)startRailVectorForRailroad:(CRRailroad *)railroad;
@end