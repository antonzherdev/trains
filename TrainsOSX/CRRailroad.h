#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"

@class CRLevel;

@interface CRRailroad : CCNode
+ (id)railroadForLevel:(CRLevel *)level zeroPoint:(CGPoint)point tileHeight:(int)height size:(CGSize)size1;

- (id)initWithLevel:(CRLevel *)level zeroPoint:(CGPoint)point tileHeight:(int)height size:(CGSize)size1;

- (CGPoint)positionForTile:(CGPoint)tile;
@end
