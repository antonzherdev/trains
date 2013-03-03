#import "CRRailroad+CRRailPoint.h"
#import "CRRail.h"

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


//TODO: Replace with recursion
- (CRMoveRailPointResult)moveRailPoint:(CRRailPoint)railPoint length:(CGFloat)length {
    CGFloat error = 0;
    CRDirection dir = length < 0 ? crBackward : crForward;
    while (1) {
        CGFloat fullLength = _th * railPoint.form.length;
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

        CRDirection direction = railPoint.x == 0 ? crBackward : crForward;
        CEIPoint t = [railPoint.form nextTilePoint:railPoint.tile direction:direction];
        
        NSArray *rails = [_railsLayer objectsAtTile:t];
        id nextRail = nil;
        for (id rail in rails) {
            CRRailForm* f = [rail form];
            if(![railPoint.form couldBeNextForm:f direction:direction]) continue;
            BOOL invertDirection = [railPoint.form shouldInvertDirectionForNextForm:f direction:direction];
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
            railPoint.type = [nextRail railType];
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
    return ccpAdd(p, ceCurvePoint(_curves[railPoint.form.ordinal], railPoint.x));
}
@end