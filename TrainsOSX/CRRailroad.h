#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"

@class CRLevel;

@interface CRRailroad : CCNode
+ (id)railroadForLevel:(CRLevel *)level;
- (id)initWithLevel:(CRLevel *)level;

+ (CGPoint)positionForTile:(CGPoint)tile;
@end
