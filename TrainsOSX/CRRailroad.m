#import "CRRailroad.h"
#import "CRRailroadBuilder.h"
#import "CRCity.h"
#import "CRRail.h"


@implementation CRRailroad {
    CRRailroadBuilder *_builder;

    CRCity * _cities[crGreen + 1];
}


+ (CRRailroad *)railroadForDim:(CEOrtoMapDim)dim {
    return [[[CRRailroad alloc] initWithDim:dim] autorelease];
}


- (id)initWithDim:(CEOrtoMapDim)dim {
    self = [super initWithDim:dim];
    if (self) {
        _railsLayer = [self addLayer];
        _builder = [CRRailroadBuilder builderForRailroad:self];
        _th = dim.tileHeight;

        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(0, 8)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(1, 8)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(2, 8)];
        [self addRail:[CRRail railWithForm:crRailFormTurn_X_Y] tile:cei(3, 8)];
        [self addRail:[CRRail railWithForm:crRailFormY] tile:cei(3, 7)];
        [self addRail:[CRRail railWithForm:crRailFormTurn_XY] tile:cei(3, 6)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(2, 6)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(1, 6)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(0, 6)];
        [self addRail:[CRRail railWithForm:crRailFormTurnXY] tile:cei(-1, 6)];
        [self addRail:[CRRail railWithForm:crRailFormY] tile:cei(-1, 7)];
        [self addRail:[CRRail railWithForm:crRailFormTurnX_Y] tile:cei(-1, 8)];

        [self addCity:[CRCity cityWithColor:crOrange orientation:crCityOrientationX tile:cei(-6, 6)]];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(-5, 6)];
        [self addRail:[CRRail railWithForm:crRailFormTurn_X_Y] tile:cei(-4, 6)];
        [self addRail:[CRRail railWithForm:crRailFormY] tile:cei(-4, 5)];

        [self addCity:[CRCity cityWithColor:crGreen orientation:crCityOrientationY tile:cei(1, 12)]];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(0, 12)];

        CGPoint x = ccp(0.5 * _th, -0.25 * _th);
        CGPoint _x = ccp(-0.5 * _th, 0.25 * _th);
        CGPoint y = ccp(0.5 * _th, 0.25 * _th);
        CGPoint _y = ccp(-0.5 * _th, -0.25 * _th);
        _curves[crRailFormX] = ceCurveBezier(ceBezier1(_x, x), 100);
        _curves[crRailFormY] = ceCurveBezier(ceBezier1(_y, y), 100);
        _curves[crRailFormTurnXY] = ceCurveBezier(ceBezier2(x, ccp(0, 0), y), 100);
        _curves[crRailFormTurn_XY] = ceCurveBezier(ceBezier2(_x, ccp(0, 0.1*_th), y), 100);
        _curves[crRailFormTurnX_Y] = ceCurveBezier(ceBezier2(x, ccp(0, -0.15*_th), _y), 100);
        _curves[crRailFormTurn_X_Y] = ceCurveBezier(ceBezier2(_x, ccp(0, 0), _y), 100);

       self.drawMesh = YES;
    }

    return self;
}

- (void)dealloc {
    for(int i = 1; i <= crRailFormTurn_X_Y; i++) {
        ceCurveDelete(_curves[i]);
    }
    [super dealloc];
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

@end