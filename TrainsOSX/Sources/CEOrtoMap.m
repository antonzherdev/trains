#import "CEOrtoMap.h"

@implementation CEOrtoMap {
    CEOrtoMapDim _dim;
}
@synthesize dim = _dim;


- (CGPoint)pointForTile:(CEIPoint)tile {
    CEOrtoMapDim dim = _dim;
    return [CEOrtoMap pointForTile:tile dim:dim];
}

+ (CGPoint)pointForTile:(CEIPoint)tile dim:(CEOrtoMapDim)dim {
    return ccp(
    (tile.y + tile.x + 1)* (int)(dim.tileHeight),
    (tile.y - tile.x)* (int)(dim.tileHeight/2));
}


- (CGPoint)tilePointForPoint:(CGPoint)point {
    return [CEOrtoMap tilePointForPoint:point dim:_dim];
}

+ (CGPoint)tilePointForPoint:(CGPoint)point dim:(CEOrtoMapDim)dim {
    return ccp(
            (point.x - 2*point.y - dim.tileHeight)/((double)(2* dim.tileHeight)),
            (point.x + 2*point.y - dim.tileHeight)/((double)(2* dim.tileHeight)));
}


- (BOOL)isValidTile:(CEIPoint)tile {
    int s = tile.x + tile.y;
    int d = tile.y - tile.x;
    return  0 <= s && s <= _dim.size.width - 1 &&
            1 <= d && d <= _dim.size.height;
}

- (NSInteger)zOrderForTile:(CEIPoint)point {
    return self.zOrder - (point.y - point.x);
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
            CGPoint tilePoint = [self pointForTile:cei(x, y)];
            label.anchorPoint = ccp(0.5, 0.5);
            label.position = tilePoint;
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
            CGPoint tilePoint = ccpSub([self pointForTile:cei(x, y)], ccp(_dim.tileHeight, _dim.tileHeight/2));
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