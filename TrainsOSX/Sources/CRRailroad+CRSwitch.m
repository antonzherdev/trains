#import "CRSwitch.h"
#import "CRRail.h"
#import "CRCity.h"
#import "CRRailroad.h"
#import "CRRailroad+CRSwitch.h"
#import "NSArray+CocoaEx.h"
#import "CRSwitchesComposition.h"


@implementation CRRailroad (CRSwitch)
- (BOOL)canBuildRailWithForm:(CRRailForm*)form tile:(CEIPoint)tile {
    if(tile.x + tile.y <= 0) return NO;
    if(tile.x + tile.y >= self.size.width - 1) return NO;
    if(tile.y - tile.x <= 1) return NO;
    if(tile.y - tile.x >= self.size.height) return NO;

    NSArray *rails = [_railsLayer objectsAtTile:tile];
    BOOL e[CR_RAIL_FORMS_COUNT];
    [self fillFormIndex:e withRails:rails];
    if(e[form.ordinal]) return NO;

    if(form == crRailFormX) {
        if(e[crRailFormTurnXY.ordinal] && e[crRailFormTurnX_Y.ordinal]) return NO;
        if(e[crRailFormTurn_XY.ordinal] && e[crRailFormTurn_X_Y.ordinal]) return NO;
        return YES;
    } else if(form == crRailFormY) {
        if(e[crRailFormTurnXY.ordinal] && e[crRailFormTurn_XY.ordinal]) return NO;
        if(e[crRailFormTurnX_Y.ordinal] && e[crRailFormTurn_X_Y.ordinal]) return NO;
        return YES;
    } else if(form == crRailFormTurnX_Y) {
        if(e[crRailFormX.ordinal] && e[crRailFormTurnXY.ordinal]) return NO;
        if(e[crRailFormY.ordinal] && e[crRailFormTurn_X_Y.ordinal]) return NO;
        return YES;
    } else if(form == crRailFormTurnXY) {
        if(e[crRailFormX.ordinal] && e[crRailFormTurnX_Y.ordinal]) return NO;
        if(e[crRailFormY.ordinal] && e[crRailFormTurn_XY.ordinal]) return NO;
        return YES;
    } else if(form == crRailFormTurn_XY) {
        if(e[crRailFormX.ordinal] && e[crRailFormTurn_X_Y.ordinal]) return NO;
        if(e[crRailFormY.ordinal] && e[crRailFormTurnXY.ordinal]) return NO;
        return YES;
    } else if(form == crRailFormTurn_X_Y) {
        if(e[crRailFormX.ordinal] && e[crRailFormTurn_XY.ordinal]) return NO;
        if(e[crRailFormY.ordinal] && e[crRailFormTurnX_Y.ordinal]) return NO;
        return YES;
    }
    return NO;
}

- (void)fillFormIndex:(BOOL[])e withRails:(NSArray *)rails {
    memset(e, 0, sizeof(BOOL)*(CR_RAIL_FORMS_COUNT));
    for(NSUInteger i = 0; i < rails.count; i++) {
        CRRailForm* railForm = [[rails objectAtIndex:i] form];
        e[railForm.ordinal] = YES;
    }
}

- (NSArray *)maybeCreateSwitchesForRailForm:(CRRailForm*)form tile:(CEIPoint)tile {
    NSMutableArray* switches = [NSMutableArray array];
    NSArray *rails = [_railsLayer objectsAtTile:tile];

    BOOL e[CR_RAIL_FORMS_COUNT];
    [self fillFormIndex:e withRails:rails];
    if(form != nil) e[form.ordinal] = YES;

    for (NSUInteger f1 = 0; f1 < CR_RAIL_FORMS_COUNT; f1++) {
        if(!e[f1]) continue;

        for (NSUInteger f2 = f1 + 1; f2 < CR_RAIL_FORMS_COUNT; f2++) {
            if(!e[f2]) continue;

            if(f1 == crRailFormTurnXY.ordinal && f2 == crRailFormTurn_X_Y.ordinal) continue;
            if(f1 == crRailFormTurnX_Y.ordinal && f2 == crRailFormTurn_XY.ordinal) continue;

            CRSwitch * aSwitch;
            aSwitch = [CRSwitch switchWithForm1:[CRRailForm valueWithOrdinal:f1] form2:[CRRailForm valueWithOrdinal:f2]];
            if(aSwitch != nil) {
                [switches addObject:aSwitch];
            }
        }
    }

    return switches;
}

- (void)updateSwitchesInTile:(CEIPoint)tile {
    [_switchLayer clearTile:tile];

    NSArray *switches = [self maybeCreateSwitchesForRailForm:nil tile:tile];
    BOOL *composite = calloc(switches.count, sizeof(BOOL));
    NSUInteger i = 0;
    for (CRSwitch * s in switches) {
        if(composite[i]) continue;

        CRSwitchesComposition * composition = [CRSwitchesComposition compositionWithSwitch:s];
        NSUInteger j = i + 1;
        for(CRSwitch * s2 in [switches subarrayFrom:i + 1]) {
            if(composite[j]) continue;


            if([composition maybeJoinSwitch:s2]) {
                composite[j] = YES;
            }
            j++;
        }
        [_switchLayer addChild:composition tile:tile];
        i++;
    }
    free(composite);
}
@end