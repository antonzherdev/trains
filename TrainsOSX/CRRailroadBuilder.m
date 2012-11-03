#import "cocos2d-ex.h"
#import "CRRailroadBuilder.h"
#import "CRRailroad.h"
#import "CRRail.h"


@implementation CRRailroadBuilder {
    CRRailroad *_railroad;
    CGPoint _startTilePoint;
    CEIPoint _startTile;
    CGPoint _startInTileSpace;
    
    CRRail* _rail;
    CEIPoint _railTile;
    CEMapLayer *_layer;
    CEIPoint _startQuarter;
}

+ (id)builderForRailroad:(CRRailroad *)railroad {
    return [[[CRRailroadBuilder alloc] initWithRailroad:railroad] autorelease];
}

- (id)initWithRailroad:(CRRailroad *)railroad {
    self = [super init];
    if(self) {
        _railroad = railroad;
        _layer = [railroad addLayerWithNode:self];
        self.isMouseEnabled = YES;
    }
    return self;
}

- (BOOL)ccMouseDown:(NSEvent *)event {
    CGPoint point = [self point:event];
    _startTilePoint = [_railroad tilePointForPoint:point];
    _startTile = ceConvertTilePointToTile(_startTilePoint);
    _startInTileSpace = ceConvertToTileSpace(_startTilePoint);
    _startQuarter = [self quarterInTile:_startTile point:point];
    return YES;
}

- (CEIPoint)quarterInTile:(CEIPoint)tile point:(CGPoint)point {
    CGPoint p = ccpSub(point, [_railroad pointForTile:tile]);
    return cei(p.x >= 0 ? 1 : -1, p.y >= 0 ? 1 : -1);
}

- (BOOL)ccMouseDragged:(NSEvent *)event {
    CGPoint point = [self point:event];
    CGPoint tilePoint = [_railroad tilePointForPoint:point];
    
    CRRailForm railForm = crRailFormUnknown;
    CEIPoint railTile = _startTile;

    if(ccpDistance(_startTilePoint, tilePoint) > 0.5) {
        CGPoint sub = ccpSub(tilePoint, _startTilePoint);
        CEIPoint tile = ceConvertTilePointToTile(tilePoint);

        BOOL tileFound = YES;
        if(!ceiEq(tile, _startTile)) {
            tileFound = NO;
            if(ceiDistance(_startTile, tile) <= 2) {
                CEIPoint quarter = [self quarterInTile:tile point:point];
                if(tile.x + tile.y == _startTile.x + _startTile.y) {
                    if(_startQuarter.x < 0 && quarter.x < 0) {
                        tileFound = YES;
                        railTile = cei(MIN(tile.x, _startTile.x), MIN(tile.y, _startTile.y));
                    } else if(_startQuarter.x > 0 && quarter.x > 0) {
                        tileFound = YES;
                        railTile = cei(MAX(tile.x, _startTile.x), MAX(tile.y, _startTile.y));
                    }
                } else if(tile.y - tile.x == _startTile.y - _startTile.x) {
                    if(_startQuarter.y < 0 && quarter.y < 0) {
                        tileFound = YES;
                        railTile = cei(MAX(tile.x, _startTile.x), MIN(tile.y, _startTile.y));
                    } else if(_startQuarter.y > 0 && quarter.y > 0) {
                        tileFound = YES;
                        railTile = cei(MIN(tile.x, _startTile.x), MAX(tile.y, _startTile.y));
                    }
                } else {
                    CEIPoint direction = ceiSub(tile, _startTile);
                    CGPoint m = cepMul(_startInTileSpace, direction);
                    if((m.x < 0.2 && direction.x != 0) || (m.y < 0.2 && direction.y != 0)) {
                        railTile = _startTile;
                    } else {
                        railTile = tile;
                    }
                    tileFound = YES;
                }
            }
        }

        if(tileFound) {
            if((sub.x > 0.2 && sub.y < -0.2) || (sub.x < -0.2 && sub.y > 0.2)) {
                CGPoint s = ccpSub(point, [_railroad pointForTile:railTile]);
                if(s.x < 0) {
                    railForm = crRailFormTurn1;
                } else {
                    railForm = crRailFormTurn3;
                }
            } else if( (sub.x < -0.2 && sub.y < -0.2) || (sub.x > 0.2 && sub.y > 0.2)) {
                CGPoint s = ccpSub(point, [_railroad pointForTile:railTile]);
                if(s.y < 0) {
                    railForm = crRailFormTurn4;
                } else {
                    railForm = crRailFormTurn2;
                }
            } else if(sub.x > 0.4 || sub.x < -0.4) {
                railForm = crRailFormX;
            } else if(sub.y > 0.4 || sub.y < -0.4) {
                railForm = crRailFormY;
            }
        }
    }

    if(railForm != crRailFormUnknown) {
        if(_rail != nil) {
            if(_rail.form != railForm || !ceiEq(railTile, _railTile)) {
                [self removeRail];
            }
        }
        if(_rail == nil) {
            //CCLOG(@"Going to build rail in tile %dx%d with form %d", railTile.x, railTile.y, railForm);
            _rail = [CRRail railWithForm:railForm];
            _railTile = railTile;
            [_layer addChild:_rail tile:_railTile];
        }
    } else {
        [self removeRail];
    }

    return YES;
}

- (void)removeRail {
    [_rail removeFromParentAndCleanup:YES];
    _rail = nil;
}


- (BOOL)ccMouseUp:(NSEvent *)event {
    if(_rail != nil) {
        [_rail removeFromParentAndCleanup:YES];
        [_railroad addRail:_rail tile:_railTile];
        _rail = nil;
    }
    return YES;
}


@end