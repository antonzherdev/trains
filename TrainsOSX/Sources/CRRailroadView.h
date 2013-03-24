#import "cr.h"

@class CRSwitch;
@class CRRailroad;

@interface CRRailroadView : CEOrtoMap<CEView> {
    CEMapLayer *_switchLayer;
    CEMapLayer *_railsLayer;
}
@property (readonly, nonatomic) CRRailroad * ctrl;

+ (CRRailroadView *)railroadForDim:(CEOrtoMapDim)dim;

- (id)initWithDim:(CEOrtoMapDim)dim;


@end
