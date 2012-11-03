#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CETileIndex.h"

@class CETileIndex;
@class CEMapLayer;

@interface CEMap : CCNode
@property(nonatomic, readonly) CEMapSize size;
@property(nonatomic) BOOL drawMesh;

- (id)initWithSize:(CEMapSize)size1;

- (CEMapLayer*) addLayer;
- (CEMapLayer*) addLayerWithNode:(CCNode*)node;

- (CGPoint)pointForTile:(CETile)tile;
- (CETile)tileForPoint:(CGPoint)point;
- (CGPoint)tilePointForPoint:(CGPoint)point;

- (BOOL) isValidTile : (CETile)tile;

- (CETileIndex *)createTileIndex;

- (void)createMesh:(CCNode *)mesh;

- (void)drawMeshLayer;
@end

@interface CEMapLayer : NSObject
@property(nonatomic, readonly) CCNode *node;

- (id) initWithMap:(CEMap*)map node:(CCNode*)node;
- (void) addChild:(CCNode*)child tile:(CETile)tile;
@end

CETile convertTilePointToTile(CGPoint tilePoint);
CGPoint convertToTileSpace(CGPoint tilePoint);