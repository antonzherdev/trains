#import "CEOrtoMap.h"

@implementation CEOrtoMap {
    CEOrtoMapDim _dim;
}
@synthesize dim = _dim;


- (CGPoint)pointForTile:(CETile)tile {
    return ccp(
    (tile.y + tile.x)* (int)(_dim.tileHeight),
    (tile.y - tile.x - 1)* (int)(_dim.tileHeight/2));
}

- (CETile)tileForPoint:(CGPoint)point {
    return ceTile(
            (int) round((point.x - 2*point.y - _dim.tileHeight)/((double)(2*_dim.tileHeight))),
            (int) round((point.x + 2*point.y - _dim.tileHeight)/((double)(2*_dim.tileHeight))));
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

- (void)createMesh:(CCNode *)mesh {
    [super createMesh:mesh];
    for(int sy = -1; sy < _dim.size.height + 1; sy++) {
        int x = -(sy + 1)/2 - 1;
        int y = (sy + 2)/2 - 1;
        for(int sx = -1; sx < (_dim.size.width/2) + (sy&1); sx++) {
            NSString *string = [NSString stringWithFormat:@"%d, %d", x, y];
            CCLabelTTF* label = [CCLabelTTF labelWithString:string fontName:@"Arial" fontSize:12];
            label.color = ccc3(0, 0, 0);
            CGPoint tilePoint = [self pointForTile:ceTile(x, y)];
            label.position = ccpAdd(tilePoint, ccp(_dim.tileHeight, _dim.tileHeight/2));
            [mesh addChild:label];
            x++;
            y++;
        }
    }
}


- (void)drawMeshLayer {
    [super drawMeshLayer];
    for(int sy = -1; sy < _dim.size.height + 1; sy++) {
        int x = -(sy + 1)/2 - 1;
        int y = (sy + 2)/2 - 1;
        for(int sx = -1; sx < (_dim.size.width/2) + (sy&1); sx++) {
            CGPoint tilePoint = [self pointForTile:ceTile(x, y)];
            ccDrawLine(
                    ccpAdd(tilePoint, ccp(_dim.tileHeight, _dim.tileHeight)),
                    ccpAdd(tilePoint, ccp(_dim.tileHeight*2, _dim.tileHeight/2))
            );
            ccDrawLine(
                    ccpAdd(tilePoint, ccp(_dim.tileHeight, 0)),
                    ccpAdd(tilePoint, ccp(_dim.tileHeight*2, _dim.tileHeight/2))
            );
            if(sy == - 1) {
                ccDrawLine(
                        ccpAdd(tilePoint, ccp(_dim.tileHeight, 0)),
                        ccpAdd(tilePoint, ccp(0, _dim.tileHeight/2))
                );
            }
            if(sy == _dim.size.height) {
                ccDrawLine(
                        ccpAdd(tilePoint, ccp(_dim.tileHeight, _dim.tileHeight)),
                        ccpAdd(tilePoint, ccp(0, _dim.tileHeight/2))
                );
            }
            x++;
            y++;
        }
    }
}


@end