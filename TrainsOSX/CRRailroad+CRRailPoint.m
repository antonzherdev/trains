#import "CRRailroad+CRRailPoint.h"
#import "CRRail.h"

@implementation CRRailroad (CRRailPoint)

- (CRMoveRailPointResult)moveRailPoint:(CRRailPoint)railPoint length:(CGFloat)length {
    float k = _th * 1.12;
    railPoint.x += length / k;

    CGFloat error = 0;
    CRDirection dir = length < 0 ? crBackward : crForward;
    while (railPoint.x < -FLT_EPSILON || railPoint.x > 1 + FLT_EPSILON) {
        CEIPoint t = railPoint.tile;
        switch (railPoint.form) {
            case crRailFormX:
                if (railPoint.x < 0) t.x--;
                else t.x++;
                break;
            case crRailFormY:
                if (railPoint.x < 0) t.y--;
                else t.y++;
                break;
            case crRailFormTurnX_Y:
                if (railPoint.x < 0) t.x++;
                else t.y--;
                break;
            case crRailFormTurnXY:
                if (railPoint.x < 0) t.x++;
                else t.y++;
                break;
            case crRailFormTurn_XY:
                if (railPoint.x < 0) t.x--;
                else t.y++;
                break;
            case crRailFormTurn_X_Y:
                if (railPoint.x < 0) t.x--;
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
                    if (railPoint.x < 0) {
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
                    if (railPoint.x < 0) {
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
                    if (railPoint.x < 0) {
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
                    if (railPoint.x < 0) {
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
                    if (railPoint.x < 0) {
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
                    if (railPoint.x < 0) {
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
                if (railPoint.x < 0) railPoint.x = -railPoint.x;
                else railPoint.x = 2 - railPoint.x;

                dir = -dir;
            } else {
                if (railPoint.x < 0) railPoint.x += 1;
                else railPoint.x -= 1;
            }
            nextRail = rail;
            break;
        }
        if (nextRail == nil) {
            if (railPoint.x < 0) {
                error = -railPoint.x;
                railPoint.x = 0;
            } else {
                error = railPoint.x - 1;
                railPoint.x = 1;
            }
        } else {
            railPoint.tile = t;
            railPoint.form = [nextRail form];
        }
    }
    CRMoveRailPointResult result;
    result.railPoint = railPoint;
    result.error = error * k;
    result.direction = dir;
    return result;
}

- (CGPoint)calculateRailPoint:(CRRailPoint)railPoint {
    CGPoint p = [self pointForTile:railPoint.tile];
    return ccpAdd(p, ceCurvePoint(_curves[railPoint.form], railPoint.x));
}
@end