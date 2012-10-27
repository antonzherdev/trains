#import "CRRailroad.h"
#import "CRLevel.h"
#import "CRRail.h"
#import "CRRailroadBuilder.h"


@implementation CRRailroad {
    CRLevel *_level;

    CGPoint _zeroPoint;
    int _tileHeight;
    CGSize _size;

    CCNode *_railsNode;
    CRRailroadBuilder *_builder;
    CETileIndex* _tileIndex;
}


+ (id)railroadForLevel:(CRLevel *)level zeroPoint:(CGPoint)point tileHeight:(int)height size:(CGSize)size {
    return [[[CRRailroad alloc] initWithLevel:level zeroPoint:point tileHeight:height size:size] autorelease];
}

- (id)initWithLevel:(CRLevel *)level zeroPoint:(CGPoint)point tileHeight:(int)height size:(CGSize)size {
    self = [super init];
    if (self) {
        _level = level;
        _zeroPoint = point;
        _tileHeight = height;
        _size = size;

        _railsNode = [CCNode node];
        [self addChild:_railsNode];
        _builder = [CRRailroadBuilder builderForRailroad:self];
        [self addChild:_builder];

        _tileIndex = [[CETileIndex tileIndexForOrtoMapWithSize:size] retain];

        [self addRail:[CRRail railInRailroad:self form:crRailFormX tile:ccp(-1, 1)]];
        [self addRail:[CRRail railInRailroad:self form:crRailFormX tile:ccp(0, 1)]];

        [self addRail:[CRRail railInRailroad:self form:crRailFormX tile:ccp(0, 8)]];
        [self addRail:[CRRail railInRailroad:self form:crRailFormX tile:ccp(1, 8)]];
        [self addRail:[CRRail railInRailroad:self form:crRailFormX tile:ccp(2, 8)]];
        [self addRail:[CRRail railInRailroad:self form:crRailFormTurn1 tile:ccp(3, 8)]];
        [self addRail:[CRRail railInRailroad:self form:crRailFormY tile:ccp(3, 7)]];
        [self addRail:[CRRail railInRailroad:self form:crRailFormTurn2 tile:ccp(3, 6)]];
        [self addRail:[CRRail railInRailroad:self form:crRailFormX tile:ccp(2, 6)]];
        [self addRail:[CRRail railInRailroad:self form:crRailFormX tile:ccp(1, 6)]];
        [self addRail:[CRRail railInRailroad:self form:crRailFormX tile:ccp(0, 6)]];
        [self addRail:[CRRail railInRailroad:self form:crRailFormTurn3 tile:ccp(-1, 6)]];
        [self addRail:[CRRail railInRailroad:self form:crRailFormY tile:ccp(-1, 7)]];
        [self addRail:[CRRail railInRailroad:self form:crRailFormTurn4 tile:ccp(-1, 8)]];
    }

    return self;
}

- (void)addRail:(CRRail *)rail {
    [_railsNode addChild:rail];
    [_tileIndex addObject:rail toTile:rail.tile];
}


- (CGPoint)positionForTile:(CGPoint)tile {
    return ccp(
    _zeroPoint.x + (tile.y + tile.x)*_tileHeight,
    _zeroPoint.y + (tile.y - tile.x)*_tileHeight/2);
}

- (void)dealloc {
    [_tileIndex release];
    [super dealloc];
}


@end