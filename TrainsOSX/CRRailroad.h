#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"

@class CRLevel;

@interface CRRailroad : CCNode
+ (id)railroadForLevel:(CRLevel *)level zeroPoint:(CGPoint)point tileHeight:(int)height;

- (id)initWithLevel:(CRLevel *)level zeroPoint:(CGPoint)point tileHeight:(int)height;

- (CGPoint)positionForTile:(CGPoint)tile;
@end
