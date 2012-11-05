#import "cr.h"

@interface CRRailroad : CEOrtoMap
+ (CRRailroad *)railroadForLevel:(CRLevel *)level dim:(CEOrtoMapDim)dim;

- (id)initWithLevel:(CRLevel *)level dim:(CEOrtoMapDim)dim;

- (void)addCity:(CRCity *)city;

- (void)addRail:(CRRail *)rail tile:(CEIPoint)tile;

- (BOOL)canBuildRailWithForm:(CRRailForm)form inTile:(CEIPoint)tile;

- (CRCity *)cityForColor:(CRCityColor)color;

- (CRMoveRailPointResult)moveRailPoint:(CRRailPoint)railPoint length:(CGFloat)length;
@end
