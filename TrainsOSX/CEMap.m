#import "CEMap.h"

@interface CEMapMesh : CCNode
- (id)initWithMap:(CEMap *)map;
@end

@implementation CEMap {
    CEISize _size;
    BOOL _drawMesh;
    CEMapMesh *_mesh;
    NSMutableArray *_layers;
}
@synthesize size = _size;
@synthesize drawMesh = _drawMesh;


- (id)initWithSize:(CEISize)size {
    self = [super init];
    if(self) {
        _size = size;
        _layers = [[NSMutableArray array] retain];
    }
    return self;
}

- (CEMapLayer *)addLayer {
    return [self addLayerWithNode:[CCNode node]];
}

- (CEMapLayer *)addLayerWithNode:(CCNode *)node {
    CEMapLayer *layer = [[[CEMapLayer alloc] initWithMap:self node:node] autorelease];
    [_layers addObject:layer];
    [self addChild:node];
    return layer;
}

- (CGPoint)pointForTile:(CEIPoint)tile {
    @throw @"abstract";
}

- (CEIPoint)tileForPoint:(CGPoint)point {
    CGPoint tilePoint = [self tilePointForPoint:point];
    return ceConvertTilePointToTile(tilePoint);
}

- (CGPoint)tilePointForPoint:(CGPoint)point {
    @throw @"abstract";
}


- (BOOL)isValidTile:(CEIPoint)tile {
    @throw @"abstract";
}


- (CETileIndex *)createTileIndex {
    return [CETileIndex tileIndexWithSize:_size];
}

- (void)setDrawMesh:(BOOL)drawMesh {
    _drawMesh = drawMesh;
    if(drawMesh) {
        _mesh = [[CEMapMesh alloc] initWithMap:self];
        [self createMesh:_mesh];
        [self addChild:_mesh];
    } else {
        [_mesh removeFromParentAndCleanup:YES];
        [_mesh release];
        _mesh = nil;
    }
}

- (void)createMesh:(CCNode *)mesh {

}

- (void)drawMeshLayer {
    glEnable(GL_LINE_SMOOTH);
    glLineWidth(2);
    ccDrawColor4F(0, 0, 0, 0.7);
    ccDrawRect(ccp(2, 2), ccp(self.contentSize.width, self.contentSize.height));
    glLineWidth(1);
}

- (void)dealloc {
    [_mesh release];
    [_layers release];
    [super dealloc];
}
@end

@implementation CEMapLayer {
    CEMap *_map;
    CETileIndex *_tileIndex;
    CCNode *_node;
}
@synthesize node = _node;

- (id)initWithMap:(CEMap *)map node:(CCNode *)node {
    self = [super init];
    if(self) {
        _node = node;
        _node.contentSize = map.contentSize;
        _map = map;
        _tileIndex = [[_map createTileIndex] retain];
    }
    return self;
}

- (void)addChild:(CCNode *)node tile:(CEIPoint)tile {
    [_node addChild:node];
    [_tileIndex addObject:node toTile:tile];
    node.anchorPoint = ccp(0.5, 0.5);
    node.position = [_map pointForTile:tile];
}

- (NSArray *)objectsAtTile:(CEIPoint)tile {
    return [_tileIndex objectsAtTile:tile];
}


- (void)dealloc {
    [_tileIndex release];
    [super dealloc];
}
@end


@implementation CEMapMesh {
    CEMap *_map;
}
- (id)initWithMap:(CEMap *)map {
    self = [super init];
    if(self) {
        _map = map;
    }
    return self;
}

- (void)draw {
    [_map drawMeshLayer];
}

@end

CEIPoint ceConvertTilePointToTile(CGPoint tilePoint) {
    return cei((int) round(tilePoint.x), (int) round(tilePoint.y));
}

CGPoint ceConvertToTileSpace(CGPoint tilePoint) {
    return ccp(tilePoint.x - ((int) round(tilePoint.x)), tilePoint.y - ((int) round(tilePoint.y)));
}
