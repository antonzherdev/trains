#import "CRRailroad.h"
#import "CRLevel.h"
#import "CRRail.h"
#import "CRRailroadBuilder.h"
#import "CRCity.h"


@implementation CRRailroad {
    CRLevel *_level;

    CRRailroadBuilder *_builder;
    CEMapLayer *_railsLayer;
    CEMapLayer *_cityLayer;
}


+ (CRRailroad *)railroadForLevel:(CRLevel *)level dim:(CEOrtoMapDim)dim {
    return [[[CRRailroad alloc] initWithLevel:level dim:dim] autorelease];
}


- (id)initWithLevel:(CRLevel *)level dim:(CEOrtoMapDim)dim {
    self = [super initWithDim:dim];
    if (self) {
        _railsLayer = [self addLayer];
        _cityLayer = [self addLayer];
        _builder = [CRRailroadBuilder builderForRailroad:self];

        [self addRail:[CRRail railWithForm:crRailFormX] tile:ceTile(0, 8)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:ceTile(1, 8)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:ceTile(2, 8)];
        [self addRail:[CRRail railWithForm:crRailFormTurn1] tile:ceTile(3, 8)];
        [self addRail:[CRRail railWithForm:crRailFormY] tile:ceTile(3, 7)];
        [self addRail:[CRRail railWithForm:crRailFormTurn2] tile:ceTile(3, 6)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:ceTile(2, 6)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:ceTile(1, 6)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:ceTile(0, 6)];
        [self addRail:[CRRail railWithForm:crRailFormTurn3] tile:ceTile(-1, 6)];
        [self addRail:[CRRail railWithForm:crRailFormY] tile:ceTile(-1, 7)];
        [self addRail:[CRRail railWithForm:crRailFormTurn4] tile:ceTile(-1, 8)];
        
        [self addCity:[CRCity cityWithColor:crOrangeCity] tile:ceTile(-6, 6)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:ceTile(-5, 6)];

        [self addCity:[CRCity cityWithColor:crGreenCity] tile:ceTile(1, 12)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:ceTile(0, 12)];

        self.drawMesh = YES;
    }

    return self;
}

- (void)addCity:(CRCity *)city tile:(CETile)tile {
    [_cityLayer addChild:city tile:tile];
}

- (void)addRail:(CRRail *)rail tile:(CETile)tile {
    [_railsLayer addChild:rail tile:tile];
}

@end