#import "CRRailroad.h"
#import "CRLevel.h"
#import "CRRailroadBuilder.h"
#import "CRCity.h"
#import "CRRail.h"


@implementation CRRailroad {
    NSUInteger th;

    CRLevel *_level;

    CRRailroadBuilder *_builder;
    CEMapLayer *_railsLayer;
    CRCity * _cities[crGreen + 1];
}


+ (CRRailroad *)railroadForLevel:(CRLevel *)level dim:(CEOrtoMapDim)dim {
    return [[[CRRailroad alloc] initWithLevel:level dim:dim] autorelease];
}


- (id)initWithLevel:(CRLevel *)level dim:(CEOrtoMapDim)dim {
    self = [super initWithDim:dim];
    if (self) {
        _railsLayer = [self addLayer];
        _builder = [CRRailroadBuilder builderForRailroad:self];
        th = dim.tileHeight;

        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(0, 8)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(1, 8)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(2, 8)];
        [self addRail:[CRRail railWithForm:crRailFormTurnX_Y] tile:cei(3, 8)];
        [self addRail:[CRRail railWithForm:crRailFormY] tile:cei(3, 7)];
        [self addRail:[CRRail railWithForm:crRailFormTurnXY] tile:cei(3, 6)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(2, 6)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(1, 6)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(0, 6)];
        [self addRail:[CRRail railWithForm:crRailFormTurn_XY] tile:cei(-1, 6)];
        [self addRail:[CRRail railWithForm:crRailFormY] tile:cei(-1, 7)];
        [self addRail:[CRRail railWithForm:crRailFormTurn_X_Y] tile:cei(-1, 8)];

        [self addCity:[CRCity cityWithColor:crOrange orientation:crCityOrientationX tile:cei(-6, 6)]];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(-5, 6)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(-4, 6)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(-3, 6)];

        [self addCity:[CRCity cityWithColor:crGreen orientation:crCityOrientationY tile:cei(1, 12)]];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(0, 12)];

//        self.drawMesh = YES;
    }

    return self;
}

- (void)addCity:(CRCity *)city {
    [_railsLayer addChild:city tile:city.tile];
    _cities[city.cityColor] = city;
}

- (void)addRail:(CRRail *)rail tile:(CEIPoint)tile {
    [_railsLayer addChild:rail tile:tile];
}

- (BOOL)canBuildRailWithForm:(CRRailForm)form inTile:(CEIPoint)tile {
    if(tile.x + tile.y <= 0) return NO;
    if(tile.x + tile.y >= self.size.width - 1) return NO;
    if(tile.y - tile.x <= 1) return NO;
    if(tile.y - tile.x >= self.size.height) return NO;

    NSArray *rails = [_railsLayer objectsAtTile:tile];
    BOOL e[crRailFormTurn_X_Y + 1];
    memset(e, 0, sizeof(e));
    for(NSUInteger i = 0; i < rails.count; i++) {
        CRRailForm railForm = [[rails objectAtIndex:i] form];
        if(railForm == form) return NO;
        e[railForm] = YES;
    }
    
    switch(form) {
        case crRailFormUnknown:
            return NO;
        case crRailFormX:
            if(e[crRailFormTurnXY] && e[crRailFormTurnX_Y]) return NO;
            if(e[crRailFormTurn_XY] && e[crRailFormTurn_X_Y]) return NO;
            return YES;
        case crRailFormY:
            if(e[crRailFormTurnXY] && e[crRailFormTurn_XY]) return NO;
            if(e[crRailFormTurnX_Y] && e[crRailFormTurn_X_Y]) return NO;
            return YES;
        case crRailFormTurnX_Y:
            if(e[crRailFormX] && e[crRailFormTurnXY]) return NO;
            if(e[crRailFormY] && e[crRailFormTurn_X_Y]) return NO;
            return YES;
        case crRailFormTurnXY:
            if(e[crRailFormX] && e[crRailFormTurnX_Y]) return NO;
            if(e[crRailFormY] && e[crRailFormTurn_XY]) return NO;
            return YES;
        case crRailFormTurn_XY:
            if(e[crRailFormX] && e[crRailFormTurn_X_Y]) return NO;
            if(e[crRailFormY] && e[crRailFormTurnXY]) return NO;
            return YES;
        case crRailFormTurn_X_Y:
            if(e[crRailFormX] && e[crRailFormTurn_XY]) return NO;
            if(e[crRailFormY] && e[crRailFormTurnX_Y]) return NO;
            return YES;
    }
    return YES;
}

- (CRCity *)cityForColor:(CRCityColor)color {
    return _cities[color];
}

- (CRMoveRailPointResult)moveRailPoint:(CRRailPoint)railPoint length:(CGFloat)length {
    float k = th * 1.12;
    railPoint.x += length/ k;

    CGFloat error = 0;
    CRDirection dir = length < 0 ? crBackward : crForward;
    while (railPoint.x < -FLT_EPSILON || railPoint.x > 1 + FLT_EPSILON) {
        CEIPoint t = railPoint.tile;
        switch (railPoint.form) {
            case crRailFormX:
                if(railPoint.x < 0) t.x--;
                else t.x++;
                break;
            case crRailFormY:
                if(railPoint.x < 0) t.y--;
                else t.y++;
                break;
            case crRailFormTurnX_Y:
                if(railPoint.x < 0) {
                    t.x--;
                    t.y++;
                }
                else {
                    t.x++;
                    t.y--;
                }
                break;
            case crRailFormTurnXY:
                if(railPoint.x < 0) {
                    t.x--;
                    t.y--;
                }
                else {
                    t.x++;
                    t.y++;
                }
                break;
            case crRailFormTurn_XY:
                if(railPoint.x < 0) {
                    t.x++;
                    t.y--;
                }
                else {
                    t.x--;
                    t.y++;
                }
                break;
            case crRailFormTurn_X_Y:
                if(railPoint.x < 0) {
                    t.x++;
                    t.y++;
                }
                else {
                    t.x--;
                    t.y--;
                }
                break;
            default:
                @throw @"Unknown rail form";
        }
        NSArray *rails = [_railsLayer objectsAtTile:t];
        id nextRail = nil;
        for(id rail in rails) {
            CRRailForm f = [rail form];
            BOOL invertDirection = NO;
            switch (railPoint.form) {
                case crRailFormX:
                    if(railPoint.x < 0) {
                        if(!(f == crRailFormX || f == crRailFormTurnXY || f == crRailFormTurnX_Y)) continue;
                    } else {
                        if(!(f == crRailFormX || f == crRailFormTurn_XY || f == crRailFormTurn_X_Y)) continue;
                    }
                    break;
                case crRailFormY:
                    if(railPoint.x < 0) {
                        if(f == crRailFormY) invertDirection = NO;
                        else if(f == crRailFormTurnXY || f == crRailFormTurn_XY) invertDirection = YES;
                        else continue;
                    } else {
                        if(f == crRailFormY) invertDirection = NO;
                        else if(f == crRailFormTurnX_Y || f == crRailFormTurn_X_Y) invertDirection = YES;
                        else continue;
                    }
                    break;
                case crRailFormTurnX_Y:
                    if(railPoint.x < 0) {
                        if(f == crRailFormX) invertDirection = YES;
                        else if(f == crRailFormTurn_XY || f == crRailFormTurn_X_Y) invertDirection = NO;
                        else continue;
                    } else {
                        if(f == crRailFormY) invertDirection = YES;
                        else if(f == crRailFormTurnXY || f == crRailFormTurn_XY) invertDirection = NO;
                        else continue;
                    }
                    break;
                case crRailFormTurnXY:
                    if(railPoint.x < 0) {
                        if(f == crRailFormX) invertDirection = YES;
                        else if(f == crRailFormTurn_XY || f == crRailFormTurn_X_Y) invertDirection = NO;
                        else continue;
                    } else {
                        if(f == crRailFormY) invertDirection = NO;
                        else if(f == crRailFormTurnX_Y || f == crRailFormTurn_X_Y) invertDirection = YES;
                        else continue;
                    }
                    break;
                case crRailFormTurn_XY:
                    if(railPoint.x < 0) {
                        if(f == crRailFormX) invertDirection = NO;
                        else if(f == crRailFormTurnXY || f == crRailFormTurnX_Y) invertDirection = YES;
                        else continue;
                    } else {
                        if(f == crRailFormY) invertDirection = NO;
                        else if(f == crRailFormTurnX_Y || f == crRailFormTurn_X_Y) invertDirection = YES;
                        else continue;
                    }
                    break;
                case crRailFormTurn_X_Y:
                    if(railPoint.x < 0) {
                        if(f == crRailFormX) invertDirection = NO;
                        else if(f == crRailFormTurnXY || f == crRailFormTurnX_Y) invertDirection = YES;
                        else continue;
                    } else {
                        if(f == crRailFormY) invertDirection = YES;
                        else if(f == crRailFormTurnXY || f == crRailFormTurn_XY) invertDirection = NO;
                        else continue;
                    }
                    break;
                default:
                    continue;
            }
            if(invertDirection) {
                if(railPoint.x < 0) railPoint.x = -railPoint.x - 1;
                else railPoint.x = 1 - railPoint.x;

                dir = -dir;
            } else {
                if(railPoint.x < 0) railPoint.x += 1;
                else railPoint.x -= 1;
            }
            nextRail = rail;
            break;
        }
        if(nextRail == nil) {
            if(railPoint.x < 0) {
                error =  -railPoint.x;
                railPoint.x = 0;
            } else {
                error = railPoint.x - 1;
                railPoint.x = 1;
            }
        } else {
            railPoint.tile = t;
        }
    }
    CRMoveRailPointResult result;
    result.railPoint = railPoint;
    result.error = error*k;
    result.direction = dir;
    return result;
}

- (CGPoint)calculateRailPoint:(CRRailPoint)railPoint {
    CGPoint p = [self pointForTile:railPoint.tile];
    return ccp(p.x  + railPoint.x*th - th/2, p.y - railPoint.x*th/2 + th/4);
}
@end