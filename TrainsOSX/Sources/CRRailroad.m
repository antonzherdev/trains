#import "CRRailroad.h"
#import "CRRailroadBuilder.h"
#import "CRCity.h"
#import "CRRail.h"
#import "CRRailroad+CRRailPoint.h"
#import "NSArray+BlocksKit.h"
#import "CRRailroad+CRSwitch.h"


@implementation CRRailroad {
    CRRailroadBuilder *_builder;

    CRCity * _cities[CR_CITY_COLORS_COUNT];
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
    for(int i = 1; i < CR_RAIL_FORMS_COUNT; i++) {
        ceCurveDelete(_curves[i]);
    }
    [super dealloc];
}


- (void)addCity:(CRCity *)city {
    [_railsLayer addChild:city tile:city.tile];
    _cities[city.cityColor.ordinal] = city;
}

- (void)addRail:(CRRail *)rail tile:(CEIPoint)tile {
    [_railsLayer addChild:rail tile:tile];
    [self updateSwitchesInTile:tile];
}

- (CRCity *)cityForColor:(CRCityColor*)color {
    return _cities[color.ordinal];
}

- (CRCity *)cityInTile:(CEIPoint)point {
    return [[_railsLayer objectsAtTile:point] match:^BOOL(id obj) {
        return [obj isKindOfClass:[CRCity class]];
    }];
}

- (void)removeRailWithForm:(CRRailForm*)form tile:(CEIPoint)tile {
    NSArray *rails = [_railsLayer objectsAtTile:tile];
    CRRail * rail = [rails match:^BOOL(id obj) {
        return [obj form] == form;
    }];
    if(rail != nil) {
        [rail removeFromParentAndCleanup:YES];
        [self updateSwitchesInTile:tile];
    }
}
@end