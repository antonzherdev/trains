#import "CRRailroad.h"
#import "CRLevel.h"
#import "CRRail.h"
#import "CRRailroadBuilder.h"


@implementation CRRailroad {
    CRLevel *_level;

    CRRailroadBuilder *_builder;
    CEMapLayer *_railsLayer;
}


+ (CRRailroad *)railroadForLevel:(CRLevel *)level dim:(CEOrtoMapDim)dim {
    return [[[CRRailroad alloc] initWithLevel:level dim:dim] autorelease];
}


- (id)initWithLevel:(CRLevel *)level dim:(CEOrtoMapDim)dim {
    self = [super initWithDim:dim];
    if (self) {
        _railsLayer = [self addLayer];
        _builder = [CRRailroadBuilder builderForRailroad:self];
        [self addLayerWithNode:_builder];

        [self addRail:[CRRail railWithForm:crRailFormX] tile:ccp(-1, 1)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:ccp(0, 1)];

        [self addRail:[CRRail railWithForm:crRailFormX] tile:ccp(0, 8)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:ccp(1, 8)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:ccp(2, 8)];
        [self addRail:[CRRail railWithForm:crRailFormTurn1] tile:ccp(3, 8)];
        [self addRail:[CRRail railWithForm:crRailFormY] tile:ccp(3, 7)];
        [self addRail:[CRRail railWithForm:crRailFormTurn2] tile:ccp(3, 6)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:ccp(2, 6)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:ccp(1, 6)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:ccp(0, 6)];
        [self addRail:[CRRail railWithForm:crRailFormTurn3] tile:ccp(-1, 6)];
        [self addRail:[CRRail railWithForm:crRailFormY] tile:ccp(-1, 7)];
        [self addRail:[CRRail railWithForm:crRailFormTurn4] tile:ccp(-1, 8)];
    }

    return self;
}

- (void)addRail:(CRRail *)rail tile:(CGPoint)tile {
    [_railsLayer addChild:rail tile:tile];
}

@end