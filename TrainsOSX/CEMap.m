#import "CEMap.h"
#import "cocos2d-ex.h"

@implementation CEMap {
    CGSize _size;
}
@synthesize size = _size;


- (id)initWithSize:(CGSize)size {
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

- (CGPoint)positionForTile:(CGPoint)tile {
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
        _map = map;
        _tileIndex = [[_map createTileIndex] retain];
    }
    return self;
}

- (void)addChild:(CCNode *)node tile:(CGPoint)tile {
    [_node addChild:node];
    [_tileIndex addObject:node toTile:tile];
    node.anchorPoint = ccp(0, 0);
    node.position = [_map positionForTile:tile];
}

- (void)dealloc {
    [_tileIndex release];
    [super dealloc];
}
@end