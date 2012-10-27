#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"

@class CRRailroad;

@interface CRRailroadBuilder : CCLayer
+ (id)builderForRailroad:(CRRailroad *)railroad;

- (id)initWithRailroad:(CRRailroad *)railroad;
@end