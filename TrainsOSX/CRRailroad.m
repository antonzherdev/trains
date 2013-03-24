#import "CRRailroad.h"
#import "CRCity.h"
#import "CRRail.h"
#import "CRSwitch.h"

//zTODO: Switches
@implementation CRRailroad {
    NSArray *_cities;
    NSArray *_rails;
    NSArray *_switches;
    CEOrtoMapDim _dim;
    CETileIndex * _tileIndex;
    NSUInteger _th;
    CECurve _curves[CR_RAIL_FORMS_COUNT + 1];
}
@synthesize cities = _cities;
@synthesize rails = _rails;
@synthesize switches = _switches;
@synthesize  dim = _dim;

- (id)initWithView:(id)view dim:(CEOrtoMapDim)dim {
    self = [super initWithView:view];
    if (self) {
        _dim = dim;
        _cities = [[NSArray array] retain];
        _rails = [[NSArray array] retain];
        _switches = [[NSArray array] retain];
        _tileIndex = [[CETileIndex tileIndexForOrtoMapWithSize:dim.size] retain];
        _th = dim.tileHeight;
        [self initRailPoint];
    }

    return self;
}

+ (id)ctrlWithView:(id)view dim:(CEOrtoMapDim)dim {
    return [[[self alloc] initWithView:view dim:dim] autorelease];
}

- (void)addCity:(CRCity *)city {
    _cities = [[[_cities autorelease] arrayByAddingObject:city] retain];
    [self updated];
}

- (CRCity *)cityInTile:(CEIPoint)point {
    return [[[_tileIndex objectsAtTile:point] filter:^BOOL(id x) {
        return [x isKindOfClass:[CRCity class]];
    }] first];
}

- (void)addRailWithForm:(CRRailForm *)form tile:(CEIPoint)tile {
    CRRail *rail = [CRRail railWithForm:form tile:tile];
    _rails = [[[_rails autorelease] arrayByAddingObject:rail] retain];
    
    _switches = [[[[[[_tileIndex objectsAtTile:tile] filter:^BOOL(CRRail *x) {
        return !crDirVecEq(x.form.v1, crDirVecInvert(form.v1))
                || !crDirVecEq(x.form.v2, crDirVecInvert(form.v2));
    }] map:^id(CRRail *x) {
        return [CRSwitch switchWithForm1:form form2:x.form];
    }] prepend:[_switches autorelease]]
       array] retain];
    [_tileIndex addObject:rail toTile:tile];
    
    [self updated];
}

- (void)removeRailWithForm:(CRRailForm *)form tile:(CEIPoint)tile {
    [[[_tileIndex objectsAtTile:tile] filter:^BOOL(id x) {
        return [x form] == form;
    }] foreach:^(id x) {
        [_tileIndex removeObject:x tile:tile];
        _rails = [[[_rails autorelease] filter:^BOOL(id xx) {
            return x != xx;
        }] array];
        [self updated];
    }];
}


- (CRCity *)cityForColor:(CRCityColor*)color {
    return [[_cities filter:^BOOL(CRCity *x) {
        return x.cityColor == color;
    }] first];
}

- (void)dealloc {
    [_cities release];
    [_rails release];
    for(int i = 1; i < CR_RAIL_FORMS_COUNT; i++) {
        ceCurveDelete(_curves[i]);
    }
    [_switches release];
    [_tileIndex release];
    [super dealloc];
}

@end

@implementation CRRailroad (CRRailPoint)
- (CGPoint)tilePointForPoint:(CGPoint)point {
    return [CEOrtoMap tilePointForPoint:point dim:_dim];
}

- (CGPoint)pointForTile:(CEIPoint)point {
    return [CEOrtoMap pointForTile:point dim:_dim];
}

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


- (CRMoveRailPointResult)moveRailPoint:(CRRailPoint)railPoint length:(CGFloat)length {
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
    id nextRail = [[[_tileIndex objectsAtTile:t]
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
    CGPoint p = [CEOrtoMap pointForTile:railPoint.tile dim:_dim];
    return ccpAdd(p, ceCurvePoint(_curves[railPoint.form.ordinal], railPoint.x));
}
@end

@implementation CRRailroad(CRSwitch)
- (BOOL)canBuildRailWithForm:(CRRailForm *)form tile:(CEIPoint)tile {
    if(tile.x + tile.y <= 0) return NO;
    if(tile.x + tile.y >= _dim.size.width - 1) return NO;
    if(tile.y - tile.x <= 1) return NO;
    if(tile.y - tile.x >= _dim.size.height) return NO;

    NSArray *rails = [_tileIndex objectsAtTile:tile];
    BOOL e[CR_RAIL_FORMS_COUNT];
    [self fillFormIndex:e withRails:rails];
    if(e[form.ordinal]) return NO;

    if(form == crRailFormX) {
        if(e[crRailFormTurnXY.ordinal] && e[crRailFormTurnX_Y.ordinal]) return NO;
        if(e[crRailFormTurn_XY.ordinal] && e[crRailFormTurn_X_Y.ordinal]) return NO;
        return YES;
    } else if(form == crRailFormY) {
        if(e[crRailFormTurnXY.ordinal] && e[crRailFormTurn_XY.ordinal]) return NO;
        if(e[crRailFormTurnX_Y.ordinal] && e[crRailFormTurn_X_Y.ordinal]) return NO;
        return YES;
    } else if(form == crRailFormTurnX_Y) {
        if(e[crRailFormX.ordinal] && e[crRailFormTurnXY.ordinal]) return NO;
        if(e[crRailFormY.ordinal] && e[crRailFormTurn_X_Y.ordinal]) return NO;
        return YES;
    } else if(form == crRailFormTurnXY) {
        if(e[crRailFormX.ordinal] && e[crRailFormTurnX_Y.ordinal]) return NO;
        if(e[crRailFormY.ordinal] && e[crRailFormTurn_XY.ordinal]) return NO;
        return YES;
    } else if(form == crRailFormTurn_XY) {
        if(e[crRailFormX.ordinal] && e[crRailFormTurn_X_Y.ordinal]) return NO;
        if(e[crRailFormY.ordinal] && e[crRailFormTurnXY.ordinal]) return NO;
        return YES;
    } else if(form == crRailFormTurn_X_Y) {
        if(e[crRailFormX.ordinal] && e[crRailFormTurn_XY.ordinal]) return NO;
        if(e[crRailFormY.ordinal] && e[crRailFormTurnX_Y.ordinal]) return NO;
        return YES;
    }
    return NO;
}

- (void)fillFormIndex:(BOOL[])e withRails:(NSArray *)rails {
    memset(e, 0, sizeof(BOOL)*(CR_RAIL_FORMS_COUNT));
    for(NSUInteger i = 0; i < rails.count; i++) {
        CRRailForm* railForm = [[rails objectAtIndex:i] form];
        e[railForm.ordinal] = YES;
    }
}


@end