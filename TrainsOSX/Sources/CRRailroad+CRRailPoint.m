#import "CRRailroad+CRRailPoint.h"
#import "CRRail.h"
#import "NSArray+CNChain.h"
#import "CNChain.h"
#import "CRCity.h"

@implementation CRRailroad (CRRailPoint)

- (void)initRailPoint {
    CGPoint x = ccp(0.5 * _th, -0.25 * _th);
    CGPoint _x = ccp(-0.5 * _th, 0.25 * _th);
    CGPoint y = ccp(0.5 * _th, 0.25 * _th);
    CGPoint _y = ccp(-0.5 * _th, -0.25 * _th);
    _curves[crRailFormX.ordinal] = ceCurveBezier(ceBezier1(_x, x), 100);
    _curves[crRailFormY.ordinal] = ceCurveBezier(ceBezier1(_y, y), 100);
    _curves[crRailFormTurnXY.ordinal] = ceCurveBezier(ceBezier2(x, ccp(-0.05* _th, 0), y), 100);
    _curves[crRailFormTurn_XY.ordinal] = ceCurveBezier(ceBezier2(_x, ccp(0, 0.05* _th), y), 100);
    _curves[crRailFormTurnX_Y.ordinal] = ceCurveBezier(ceBezier2(x, ccp(0, 0.07* _th), _y), 100);
    _curves[crRailFormTurn_X_Y.ordinal] = ceCurveBezier(ceBezier2(_x, ccp(0.05* _th, 0), _y), 100);
}


//zTODO: Create test
- (CRMoveRailPointResult)moveRailPoint:(CRRailPoint)railPoint length:(CGFloat)length {
//    CRDirection dir = crDirection(length);
    CGFloat fullLength = _th * railPoint.form.length;
    CGFloat already = railPoint.x * fullLength;
    railPoint.x += length/fullLength;
    if(railPoint.x < 0) {
        railPoint.x = 0;
        return [self moveToNextRailRailPoint:railPoint length:length + already];
    } else if(railPoint.x > 1) {
        railPoint.x = 1;
        return [self moveToNextRailRailPoint:railPoint length:length - (fullLength - already)];
    } else {
        CRMoveRailPointResult result;
        result.railPoint = railPoint;
        result.error = 0;
        result.direction = crDirection(length);
        return result;
    }
}

- (CRMoveRailPointResult)moveToNextRailRailPoint:(CRRailPoint)railPoint length:(CGFloat)length {
    CRDirection dir = railPoint.x == 0 ? crBackward : crForward;
    CEIPoint t = [railPoint.form nextTilePoint:railPoint.tile direction:dir];
    id nextRail = [[[_railsLayer objectsAtTile:t]
            filter:^BOOL(id rail) {
                return [railPoint.form couldBeNextForm:[rail form] direction:dir];
            }] first];
    if([nextRail isEmpty]) {
        CRMoveRailPointResult result;
        result.railPoint = railPoint;
        result.error = ABS(length);
        result.direction = dir;
        return result;
    } else {
        BOOL invertDirection = [railPoint.form shouldInvertDirectionForNextForm:[nextRail form] direction:dir];
        if (invertDirection) {
            if (railPoint.x == 0) railPoint.x = 0;
            else railPoint.x = 2 - railPoint.x;

            length = -length;
        } else {
            railPoint.x = 1 - railPoint.x;
        }
        CRRailPoint p;
        p.tile = t;
        p.x = railPoint.x;
        p.form = [nextRail form];
        p.type = [nextRail railType];
        return [self moveRailPoint:p length:length];
    }
}

- (CGPoint)calculateRailPoint:(CRRailPoint)railPoint {
    CGPoint p = [self pointForTile:railPoint.tile];
    return ccpAdd(p, ceCurvePoint(_curves[railPoint.form.ordinal], railPoint.x));
}
@end