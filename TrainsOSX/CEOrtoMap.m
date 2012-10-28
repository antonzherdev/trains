#import "CEOrtoMap.h"

@implementation CEOrtoMap {
    CEOrtoMapDim _dim;
}
@synthesize dim = _dim;


- (CGPoint)pointForTile:(CETile)tile {
    return ccp(
    (tile.y + tile.x)* _dim.tileHeight,
    (tile.y - tile.x)* _dim.tileHeight/2);
}

- (CETile)tileForPoint:(CGPoint)point {
    return ceTile(
            (int) ((point.x - 2*point.y)/(2*_dim.tileHeight)),
            (int) ((point.x + 2*point.y)/(2*_dim.tileHeight)));
}

- (BOOL)isValidTile:(CETile)tile {
    int s = tile.x + tile.y;
    int d = tile.y - tile.x;
    return  0 <= s && s <= _dim.size.width - 1 &&
            1 <= d && d <= _dim.size.height;
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
        self.contentSize = CGSizeMake((_dim.size.width + 1)*_dim.tileHeight, (_dim.size.height + 1)*_dim.tileHeight/2);
    }
    return self;
}


@end