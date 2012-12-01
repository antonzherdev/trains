#import "cr.h"

@interface CRRailroad : CEOrtoMap {
    CEMapLayer *_railsLayer;
    NSUInteger _th;

    CECurve _curves[crRailFormTurn_X_Y + 1];
}
+ (CRRailroad *)railroadForDim:(CEOrtoMapDim)dim;

- (id)initWithDim:(CEOrtoMapDim)dim;

- (void)addCity:(CRCity *)city;

- (void)addRail:(CRRail *)rail tile:(CEIPoint)tile;

- (BOOL)canBuildRailWithForm:(CRRailForm)form inTile:(CEIPoint)tile;

- (CRCity *)cityForColor:(CRCityColor)color;

- (CRCity *)cityInTile:(CEIPoint)point;
@end
