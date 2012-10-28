#import "CEMap.h"

@implementation CEMap {
    CEMapSize _size;
}
@synthesize size = _size;


- (id)initWithSize:(CEMapSize)size {
    self = [super init];
    if(self) {
        _size = size;
    }
    return self;
}

- (CEMapLayer *)addLayer {
    return [self addLayerWithNode:[CCNode node]];
}

- (CEMapLayer *)addLayerWithNode:(CCNode *)node {
    CEMapLayer *layer = [[[CEMapLayer alloc] initWithMap:self node:node] autorelease];
    [self addChild:node];
    return layer;
}

- (CGPoint)pointForTile:(CETile)tile {
    @throw @"abstract";
}

- (CETile)tileForPoint:(CGPoint)point {
    @throw @"abstract";
}

- (BOOL)isValidTile:(CETile)tile {
    @throw @"abstract";
}


- (CETileIndex *)createTileIndex {
    return [CETileIndex tileIndexWithSize:_size];
}
@end

@implementation CEMapLayer {
    CEMap *_map;
    CETileIndex *_tileIndex;
    CCNode *_node;
}
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

- (void)addChild:(CCNode *)node tile:(CETile)tile {
    [_node addChild:node];
    [_tileIndex addObject:node toTile:tile];
    node.anchorPoint = ccp(0, 0);
    node.position = [_map pointForTile:tile];
}

- (void)dealloc {
    [_tileIndex release];
    [super dealloc];
}
@end
