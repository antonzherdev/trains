#import "CRRailroad.h"
#import "CRLevel.h"
#import "CRRail.h"


@implementation CRRailroad {
    CRLevel *_level;
    CGPoint _zeroPoint;
    int _tileHeight;
}


+ (id)railroadForLevel:(CRLevel *)level zeroPoint:(CGPoint)point tileHeight:(int)tileHeight {
    return [[[CRRailroad alloc] initWithLevel:level zeroPoint:point tileHeight:tileHeight] autorelease];
}

- (id)initWithLevel:(CRLevel *)level zeroPoint:(CGPoint)point tileHeight:(int)tileHeight {
    self = [super init];
    if (self) {
        _level = level;
        _zeroPoint = point;
        _tileHeight = tileHeight;

        [self addChild:[CRRail railInRailroad:self form:crRailFormX tile:ccp(0, 9)]];
        [self addChild:[CRRail railInRailroad:self form:crRailFormX tile:ccp(1, 9)]];
        [self addChild:[CRRail railInRailroad:self form:crRailFormX tile:ccp(2, 9)]];
        [self addChild:[CRRail railInRailroad:self form:crRailFormTurn1 tile:ccp(3, 9)]];
        [self addChild:[CRRail railInRailroad:self form:crRailFormY tile:ccp(3, 8)]];
        [self addChild:[CRRail railInRailroad:self form:crRailFormTurn2 tile:ccp(3, 7)]];
        [self addChild:[CRRail railInRailroad:self form:crRailFormX tile:ccp(2, 7)]];
        [self addChild:[CRRail railInRailroad:self form:crRailFormX tile:ccp(1, 7)]];
        [self addChild:[CRRail railInRailroad:self form:crRailFormX tile:ccp(0, 7)]];
        [self addChild:[CRRail railInRailroad:self form:crRailFormTurn3 tile:ccp(-1, 7)]];
        [self addChild:[CRRail railInRailroad:self form:crRailFormY tile:ccp(-1, 8)]];
        [self addChild:[CRRail railInRailroad:self form:crRailFormTurn4 tile:ccp(-1, 9)]];
    }

    return self;
}


- (CGPoint)positionForTile:(CGPoint)tile {
    return ccp(
    _zeroPoint.x + (tile.y + tile.x)*_tileHeight - _tileHeight,
    _zeroPoint.y + (tile.y - tile.x)*_tileHeight/2);

}


@end