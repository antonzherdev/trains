#import "cr.h"

@class CRRailroad;

@interface CRRailroadBuilder : CCLayer
+ (id)builderForRailroad:(CRRailroad *)railroad;

- (id)initWithRailroad:(CRRailroad *)railroad;
@end