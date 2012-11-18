#import "CRRailroad+CRRailPoint.h"
#import "CRRail.h"

@implementation CRRailroad (CRRailPoint)

- (CRMoveRailPointResult)moveRailPoint:(CRRailPoint)railPoint length:(CGFloat)length {
    CGFloat error = 0;
    CRDirection dir = length < 0 ? crBackward : crForward;
    while (1) {
        float fullLength;
        switch (railPoint.form) {
            case crRailFormX:
            case crRailFormY:
                fullLength = _th * 1.12;
                break;
            case crRailFormTurn_X_Y:
            case crRailFormTurnXY:
                fullLength = _th * 0.85;
                break;
            case crRailFormTurnX_Y:
            case crRailFormTurn_XY:
                fullLength = _th * 1.12;
                break;
            default:
                @throw @"Unknown rail form";
        }
        CGFloat already;
        already = railPoint.x * fullLength;
        if(length < 0) {
            if(already >= -length) {
                railPoint.x -= -length/fullLength;
                length = 0;
            } else {
                railPoint.x = 0;
                length += already;
            }
        } else {
            if(fullLength - already >= length) {
                railPoint.x += length/fullLength;
                length = 0;
            } else {
                railPoint.x = 1;
                length -= fullLength - already;
            }
        }
        if(length == 0) break;
        
        CEIPoint t = railPoint.tile;
        switch (railPoint.form) {
            case crRailFormX:
                if (railPoint.x == 0) t.x--;
                else t.x++;
                break;
            case crRailFormY:
                if (railPoint.x == 0) t.y--;
                else t.y++;
                break;
            case crRailFormTurnX_Y:
                if (railPoint.x == 0) t.x++;
                else t.y--;
                break;
            case crRailFormTurnXY:
                if (railPoint.x == 0) t.x++;
                else t.y++;
                break;
            case crRailFormTurn_XY:
                if (railPoint.x == 0) t.x--;
                else t.y++;
                break;
            case crRailFormTurn_X_Y:
                if (railPoint.x == 0) t.x--;
                else t.y--;
                break;
            default:
                @throw @"Unknown rail form";
        }
        NSArray *rails = [_railsLayer objectsAtTile:t];
        id nextRail = nil;
        for (id rail in rails) {
            CRRailForm f = [rail form];
            BOOL invertDirection;
            switch (railPoint.form) {
                case crRailFormX:
                    if (railPoint.x == 0) {
                        if (f == crRailFormX) invertDirection = NO;
                        else if (f == crRailFormTurnXY || f == crRailFormTurnX_Y) invertDirection = YES;
                        else continue;
                    } else {
                        if (f == crRailFormX) invertDirection = NO;
                        else if (f == crRailFormTurn_XY || f == crRailFormTurn_X_Y) invertDirection = NO;
                        else continue;
                    }
                    break;
                case crRailFormY:
                    if (railPoint.x == 0) {
                        if (f == crRailFormY) invertDirection = NO;
                        else if (f == crRailFormTurnXY || f == crRailFormTurn_XY) invertDirection = NO;
                        else continue;
                    } else {
                        if (f == crRailFormY) invertDirection = NO;
                        else if (f == crRailFormTurnX_Y || f == crRailFormTurn_X_Y) invertDirection = YES;
                        else continue;
                    }
                    break;
                case crRailFormTurnX_Y:
                    if (railPoint.x == 0) {
                        if (f == crRailFormX) invertDirection = YES;
                        else if (f == crRailFormTurn_XY || f == crRailFormTurn_X_Y) invertDirection = NO;
                        else continue;
                    } else {
                        if (f == crRailFormY) invertDirection = YES;
                        else if (f == crRailFormTurnXY || f == crRailFormTurn_XY) invertDirection = NO;
                        else continue;
                    }
                    break;
                case crRailFormTurnXY:
                    if (railPoint.x == 0) {
                        if (f == crRailFormX) invertDirection = YES;
                        else if (f == crRailFormTurn_XY || f == crRailFormTurn_X_Y) invertDirection = NO;
                        else continue;
                    } else {
                        if (f == crRailFormY) invertDirection = NO;
                        else if (f == crRailFormTurnX_Y || f == crRailFormTurn_X_Y) invertDirection = YES;
                        else continue;
                    }
                    break;
                case crRailFormTurn_XY:
                    if (railPoint.x == 0) {
                        if (f == crRailFormX) invertDirection = NO;
                        else if (f == crRailFormTurnXY || f == crRailFormTurnX_Y) invertDirection = YES;
                        else continue;
                    } else {
                        if (f == crRailFormY) invertDirection = NO;
                        else if (f == crRailFormTurnX_Y || f == crRailFormTurn_X_Y) invertDirection = YES;
                        else continue;
                    }
                    break;
                case crRailFormTurn_X_Y:
                    if (railPoint.x == 0) {
                        if (f == crRailFormX) invertDirection = NO;
                        else if (f == crRailFormTurnXY || f == crRailFormTurnX_Y) invertDirection = YES;
                        else continue;
                    } else {
                        if (f == crRailFormY) invertDirection = YES;
                        else if (f == crRailFormTurnXY || f == crRailFormTurn_XY) invertDirection = NO;
                        else continue;
                    }
                    break;
                default:
                    continue;
            }
            if (invertDirection) {
                if (railPoint.x == 0) railPoint.x = 0;
                else railPoint.x = 2 - railPoint.x;

                length = -length;
                dir = -dir;
            } else {
                railPoint.x = 1 - railPoint.x;
            }
            nextRail = rail;
            break;
        }
        if (nextRail == nil) {
            error = ABS(length);
            break;
        } else {
            railPoint.tile = t;
            railPoint.form = [nextRail form];
        }
    }
    CRMoveRailPointResult result;
    result.railPoint = railPoint;
    result.error = error;
    result.direction = dir;
    return result;
}

- (CGPoint)calculateRailPoint:(CRRailPoint)railPoint {
    CGPoint p = [self pointForTile:railPoint.tile];
    return ccpAdd(p, ceCurvePoint(_curves[railPoint.form], railPoint.x));
}
@end