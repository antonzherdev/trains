#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CETileIndex.h"

@class CETileIndex;
@class CEMapLayer;

@interface CEMap : CCNode
@property(nonatomic, readonly) CEISize size;
@property(nonatomic) BOOL drawMesh;

- (id)initWithSize:(CEISize)size1;

- (CEMapLayer*) addLayer;
- (CEMapLayer*) addLayerWithNode:(CCNode*)node;

- (CGPoint)pointForTile:(CEIPoint)tile;
- (CEIPoint)tileForPoint:(CGPoint)point;
- (CGPoint)tilePointForPoint:(CGPoint)point;

- (BOOL) isValidTile : (CEIPoint)tile;

- (CETileIndex *)createTileIndex;

- (void)createMesh:(CCNode *)mesh;

- (void)drawMeshLayer;
@end

@interface CEMapLayer : NSObject
@property(nonatomic, readonly) CCNode *node;

- (id) initWithMap:(CEMap*)map node:(CCNode*)node;
- (void) addChild:(CCNode*)child tile:(CEIPoint)tile;
@end

CEIPoint ceConvertTilePointToTile(CGPoint tilePoint);
CGPoint ceConvertToTileSpace(CGPoint tilePoint);