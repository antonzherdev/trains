#import "CRRailroad.h"
#import "CRLevel.h"
#import "CRRail.h"


@implementation CRRailroad {
    CRLevel *_level;
}

+ (id)railroadForLevel:(CRLevel *)level {
    return [[[CRRailroad alloc] initWithLevel:level] autorelease];
}

- (id)initWithLevel:(CRLevel *)level {
    self = [super init];
    if (self) {
        _level = level;

        [self addChild:[CRRail railWithForm:crRailFormHorizontal tile:ccp(2, 4)]];
        [self addChild:[CRRail railWithForm:crRailFormHorizontal tile:ccp(3, 4)]];
        [self addChild:[CRRail railWithForm:crRailFormHorizontal tile:ccp(4, 4)]];
        [self addChild:[CRRail railWithForm:crRailFormTurn4 tile:ccp(5, 4)]];
        [self addChild:[CRRail railWithForm:crRailFormVertical tile:ccp(6, 5)]];
        [self addChild:[CRRail railWithForm:crRailFormTurn1 tile:ccp(5, 6)]];
        [self addChild:[CRRail railWithForm:crRailFormHorizontal tile:ccp(4, 7)]];
        [self addChild:[CRRail railWithForm:crRailFormHorizontal tile:ccp(3, 7)]];
    }

    return self;
}

#define TILE_WIDTH 160
#define TILE_HEIGHT 100

+ (CGPoint)positionForTile:(CGPoint)tile {
    return ccp(tile.x*TILE_WIDTH, tile.y*TILE_HEIGHT);
}


@end