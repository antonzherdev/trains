#import "CRRailroad.h"
#import "CRLevel.h"
#import "CRRailroadBuilder.h"
#import "CRCity.h"
#import "cocos2d-ex.h"


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

        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(0, 8)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(1, 8)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(2, 8)];
        [self addRail:[CRRail railWithForm:crRailFormTurnX_Y] tile:cei(3, 8)];
        [self addRail:[CRRail railWithForm:crRailFormY] tile:cei(3, 7)];
        [self addRail:[CRRail railWithForm:crRailFormTurnXY] tile:cei(3, 6)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(2, 6)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(1, 6)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(0, 6)];
        [self addRail:[CRRail railWithForm:crRailFormTurn_XY] tile:cei(-1, 6)];
        [self addRail:[CRRail railWithForm:crRailFormY] tile:cei(-1, 7)];
        [self addRail:[CRRail railWithForm:crRailFormTurn_X_Y] tile:cei(-1, 8)];
        
        [self addCity:[CRCity cityWithColor:crOrangeCity] tile:cei(-6, 6)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(-5, 6)];

        [self addCity:[CRCity cityWithColor:crGreenCity] tile:cei(1, 12)];
        [self addRail:[CRRail railWithForm:crRailFormX] tile:cei(0, 12)];

        //self.drawMesh = YES;
    }

    return self;
}

- (void)addCity:(CRCity *)city tile:(CEIPoint)tile {
    [_cityLayer addChild:city tile:tile];
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
@end