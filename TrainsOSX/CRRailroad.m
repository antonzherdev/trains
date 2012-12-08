#import "CRRailroad.h"
#import "CRRailroadBuilder.h"
#import "CRCity.h"
#import "CRRail.h"
#import "CRRailroad+CRRailPoint.h"
#import "NSArray+BlocksKit.h"
#import "CRSwitch.h"


@implementation CRRailroad {
    CRRailroadBuilder *_builder;

    CRCity * _cities[crGreen + 1];
    CEMapLayer *_switchLayer;
}


+ (CRRailroad *)railroadForDim:(CEOrtoMapDim)dim {
    return [[[CRRailroad alloc] initWithDim:dim] autorelease];
}


- (id)initWithDim:(CEOrtoMapDim)dim {
    self = [super initWithDim:dim];
    if (self) {
        _railsLayer = [self addLayer];
        _switchLayer = [self addLayer];
        _switchLayer.zOrder = 100;
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
//        [self addRail:[CRRail railWithForm:crRailFormTurn_XY] tile:cei(-4, 6)];
//        [self addRail:[CRRail railWithForm:crRailFormY] tile:cei(-4, 7)];

        [self addCity:[CRCity cityWithColor:crGreen orientation:crCityOrientationY tile:cei(1, 12)]];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(0, 12)];

        [self initRailPoint];

//       self.drawMesh = YES;
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
    CRRailForm form = [rail form];
    NSArray *switches = [self maybeCreateSwitchesForRailForm:form tile:tile];
    for (CRSwitch * aSwitch in switches) {
        [_switchLayer addChild:aSwitch tile:tile];
    }
    [_railsLayer addChild:rail tile:tile];
}

- (BOOL)canBuildRailWithForm:(CRRailForm)form tile:(CEIPoint)tile {
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

- (CRCity *)cityInTile:(CEIPoint)point {
    return [[_railsLayer objectsAtTile:point] match:^BOOL(id obj) {
        return [obj isKindOfClass:[CRCity class]];
    }];
}

- (NSArray *)maybeCreateSwitchesForRailForm:(CRRailForm)form tile:(CEIPoint)tile {
    NSMutableArray* switches = [NSMutableArray array];
    NSArray *rails = [_railsLayer objectsAtTile:tile];

    for (CRRail *r in rails) {
        CRRailForm f1 = form;
        CRRailForm f2 = [r form];
        if(f1 > f2) {
            f1 = f2;
            f2 = form;
        }
        if(f1 == crRailFormTurnXY && f2 == crRailFormTurn_X_Y) continue;
        if(f1 == crRailFormTurn_XY && f2 == crRailFormTurnX_Y) continue;
        CRSwitch * aSwitch = [CRSwitch switchWithForm1:f1 form2:f2];
        [switches addObject:aSwitch];
    }
    return switches;
}
@end