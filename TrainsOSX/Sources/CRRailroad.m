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