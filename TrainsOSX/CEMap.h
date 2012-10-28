#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class CETileIndex;
@class CEMapLayer;

@interface CEMap : CCNode
@property(nonatomic, readonly) CGSize size;

- (id)initWithSize:(CGSize)size1;

- (CEMapLayer*) addLayer;
- (CEMapLayer*) addLayerWithNode:(CCNode*)node;
- (CGPoint)positionForTile:(CGPoint)tile;

- (CETileIndex *)createTileIndex;
@end

@interface CEMapLayer : NSObject
- (id) initWithMap:(CEMap*)map node:(CCNode*)node;
- (void) addChild:(CCNode*)child tile:(CGPoint)tile;
@end
