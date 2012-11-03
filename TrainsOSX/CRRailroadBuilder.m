#import "cocos2d-ex.h"
#import "CRRailroadBuilder.h"
#import "CRRailroad.h"
#import "CRRail.h"


@implementation CRRailroadBuilder {
    CRRailroad *_railroad;
    CGPoint _startTilePoint;
    CETile _startTile;
    CGPoint _startInTileSpace;
    
    CRRail* _rail;
    CETile _railTile;
    CEMapLayer *_layer;
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
    _startTile = convertTilePointToTile(_startTilePoint);
    _startInTileSpace = convertToTileSpace(_startTilePoint);
    return YES;
}

- (BOOL)ccMouseDragged:(NSEvent *)event {
    CGPoint point = [self point:event];
    CGPoint tilePoint = [_railroad tilePointForPoint:point];
    
    CRRailForm railForm = crRailFormUnknown;
    
    if(ccpDistance(_startTilePoint, tilePoint) > 0.5) {
        CGPoint sub = ccpSub(tilePoint, _startTilePoint);
        if(sub.x > 0.2 && sub.y > 0.2) {
            railForm = crRailFormTurn2;
        } else if(sub.x > 0.2 && sub.y < -0.2) {
            railForm = crRailFormTurn1;
        } else if(sub.x < -0.2 && sub.y > 0.2) {
            railForm = crRailFormTurn3;
        } else if(sub.x < -0.2 && sub.y < -0.2) {
            railForm = crRailFormTurn4;
        } else if(sub.x > 0.4 || sub.x < -0.4) {
            railForm = crRailFormX;
        } else if(sub.y > 0.4 || sub.y < -0.4) {
            railForm = crRailFormY;
        }
    }

    if(railForm != crRailFormUnknown) {
        CETile railTile = _startTile;
        if(_rail != nil) {
            if(_rail.form != railForm || !ceTileEq(railTile, _railTile)) {
                [self removeRail];
            }
        }
        if(_rail == nil) {
            CCLOG(@"Going to build rail in tile %dx%d with form %d", railTile.x, railTile.y, railForm);
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