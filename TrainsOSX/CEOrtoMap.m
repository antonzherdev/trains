#import "CEOrtoMap.h"
#import "cocos2d-ex.h"

@implementation CEOrtoMap {
    CEOrtoMapDim _dim;
}
@synthesize dim = _dim;


- (CGPoint)positionForTile:(CGPoint)tile {
    return ccp(
    _dim.zeroPoint.x + (tile.y + tile.x)* _dim.tileHeight,
    _dim.zeroPoint.y + (tile.y - tile.x)* _dim.tileHeight/2);
}

- (CETileIndex *)createTileIndex {
    return [CETileIndex tileIndexForOrtoMapWithSize:self.size];
}

+ (id)ortoMapWithDim:(CEOrtoMapDim)dim {
    return [[[CEOrtoMap alloc] initWithDim:dim] autorelease];
}

- (id)initWithDim:(CEOrtoMapDim)dim {
    self = [super initWithSize:dim.size];
    if(self) {
        _dim = dim;
    }
    return self;
}


@end