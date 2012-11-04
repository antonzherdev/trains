#import "cocos2d-ex.h"
#import "CRRailroadBuilder.h"
#import "CRRailroad.h"



@implementation CRRailroadBuilder {
    CRRailroad *_railroad;
    CGPoint _startTilePoint;
    CEIPoint _startTile;
    CGPoint _startInTileSpace;
    
    CRRail* _rail;
    CEIPoint _railTile;
    CEMapLayer *_layer;
    CEIPoint _startQuarter;

    CGPoint _touchStartPoint;
    CGPoint _touchStartScreenPoint;
    NSTouch* _startTouches[2];
    BOOL _touching;
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
        self.isTouchEnabled = YES;
    }
    return self;
}

- (BOOL)ccMouseDown:(NSEvent *)event {
    CGPoint point = [self point:event];
    [self mouseDown:point];
    return YES;
}

- (void)mouseDown:(CGPoint)point {
    CCLOG(@"CRRailroadBuilder.mouseDown(%f, %f)", point.x, point.y);

    _startTilePoint = [_railroad tilePointForPoint:point];
    CCLOG(@"startTilePoint = %f, %f)", _startTilePoint.x, _startTilePoint.y);
    _startTile = ceConvertTilePointToTile(_startTilePoint);

    CCLOG(@"startTile = %d, %d", _startTile.x, _startTile.y);

    _startInTileSpace = ceConvertToTileSpace(_startTilePoint);
    _startQuarter = [self quarterInTile:_startTile point:point];
}

- (CEIPoint)quarterInTile:(CEIPoint)tile point:(CGPoint)point {
    CGPoint p = ccpSub(point, [_railroad pointForTile:tile]);
    return cei(p.x >= 0 ? 1 : -1, p.y >= 0 ? 1 : -1);
}

- (BOOL)ccMouseDragged:(NSEvent *)event {
    CGPoint point = [self point:event];
    [self mouseDragged:point];

    return YES;
}

- (void)mouseDragged:(CGPoint)point {
    CCLOG(@"CRRailroadBuilder.mouseDragged(%f, %f)", point.x, point.y);
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
                    railForm = crRailFormTurnX_Y;
                } else {
                    railForm = crRailFormTurn_XY;
                }
            } else if( (sub.x < -0.2 && sub.y < -0.2) || (sub.x > 0.2 && sub.y > 0.2)) {
                CGPoint s = ccpSub(point, [_railroad pointForTile:railTile]);
                if(s.y < 0) {
                    railForm = crRailFormTurn_X_Y;
                } else {
                    railForm = crRailFormTurnXY;
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
            if([_railroad canBuildRailWithForm:railForm inTile:railTile]) {
                CCLOG(@"Going to build rail in tile %dx%d with form %d", railTile.x, railTile.y, railForm);
                _rail = [CRRail railWithForm:railForm];
                _railTile = railTile;
                [_layer addChild:_rail tile:_railTile];
            } else {
                CCLOG(@"Coluld not build rail in tile %d,%d whithh form %d", railTile.x, railTile.y, railForm);
            }
        }
    } else {
        [self removeRail];
    }
}

- (void)removeRail {
    [_rail removeFromParentAndCleanup:YES];
    _rail = nil;
}


- (BOOL)ccMouseUp:(NSEvent *)event {
    [self mouseUp];
    return YES;
}

- (void)mouseUp {
    CCLOG(@"CRRailroadBuilder.mouseUp");
    if(_rail != nil) {
        [_rail removeFromParentAndCleanup:YES];
        [_railroad addRail:_rail tile:_railTile];
        _rail = nil;
    }
}

- (BOOL)ccTouchesBeganWithEvent:(NSEvent *)event {
    CCGLView *view = [[CCDirectorMac sharedDirector] view];
    NSSet *touches = [event touchesMatchingPhase:NSTouchPhaseTouching inView:view];
    if(touches.count == 2) {
        _touching = YES;
        NSArray *array = [touches allObjects];
        _startTouches[0] = [[array objectAtIndex:0] retain];
        _startTouches[1] = [[array objectAtIndex:1] retain];
        
        CGPoint p = [event locationInWindow];
        _touchStartScreenPoint = CGEventGetLocation([event CGEvent]);

        CCLOG(@"Touch start %f,%f", _touchStartScreenPoint.x, _touchStartScreenPoint.y);
        p = [[[CCDirector sharedDirector] view] convertPointFromBase:p];
        CCDirectorMac *dir = (CCDirectorMac *) [CCDirectorMac sharedDirector];
        p = [dir convertToLogicalCoordinates:p];
        _touchStartPoint = [self convertToNodeSpace:p];
        [self mouseDown:_touchStartPoint];
    }

    return YES;
}

- (BOOL)ccTouchesMovedWithEvent:(NSEvent *)event {
    if(!_touching) return NO;
    
    CCGLView *view = [[CCDirectorMac sharedDirector] view];
    NSSet *touches = [event touchesMatchingPhase:NSTouchPhaseTouching inView:view];
    NSTouch *touch0 = [self findTouch:_startTouches[0] inTouches:touches];
    if(touch0 == nil) return YES;
    NSTouch *touch1 = [self findTouch:_startTouches[1] inTouches:touches];
    if(touch1 == nil) return YES;

    NSPoint np1 = _startTouches[0].normalizedPosition;
    NSPoint np2 = _startTouches[1].normalizedPosition;
    NSPoint p1 = touch0.normalizedPosition;
    NSPoint p2 = touch1.normalizedPosition;
    CGFloat w = touch0.deviceSize.width;
    CGFloat h = touch0.deviceSize.height;
    CGPoint delta = ccp(
    3*((MIN(p1.x, p2.x) * w) - (MIN(np1.x, np2.x)* w)),
    3*((MIN(p1.y, p2.y) * h) - (MIN(np1.y, np2.y)* h))
    );


    CGPoint p = ccpAdd(_touchStartPoint, delta);
    CGPoint cursor = ccp(_touchStartScreenPoint.x + delta.x, _touchStartScreenPoint.y - delta.y);
    CGWarpMouseCursorPosition(cursor);
    [self mouseDragged:p];

    return YES;
}

- (NSTouch *)findTouch:(NSTouch *)touch inTouches:(NSSet *)touches {
    for(NSTouch * t in touches) {
        if([t.identity isEqual:touch.identity]) {
            return t;
        }
    }
    return nil;
}

- (BOOL)ccTouchesEndedWithEvent:(NSEvent *)event {
    if(!_touching) return NO;
    
    _touching = NO;
    [_startTouches[0] release];
    [_startTouches[1] release];
    [self mouseUp];
    
    return YES;
}


@end