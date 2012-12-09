#import "CRSwitch.h"
#import "CRRail.h"
#import "CRCity.h"
#import "CRRailroad.h"
#import "CRRailroad+CRSwitch.h"


@implementation CRRailroad (CRSwitch)
- (BOOL)canBuildRailWithForm:(CRRailForm)form tile:(CEIPoint)tile {
    if(tile.x + tile.y <= 0) return NO;
    if(tile.x + tile.y >= self.size.width - 1) return NO;
    if(tile.y - tile.x <= 1) return NO;
    if(tile.y - tile.x >= self.size.height) return NO;

    NSArray *rails = [_railsLayer objectsAtTile:tile];
    BOOL e[crRailFormTurn_X_Y + 1];
    [self fillFormIndex:e withRails:rails];
    if(e[form]) return NO;

    switch(form) {
        case crRailFormNil:
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

- (void)fillFormIndex:(BOOL[])e withRails:(NSArray *)rails {
    memset(e, 0, sizeof(e));
    for(NSUInteger i = 0; i < rails.count; i++) {
        CRRailForm railForm = [[rails objectAtIndex:i] form];
        e[railForm] = YES;
    }
}

- (NSArray *)maybeCreateSwitchesForRailForm:(CRRailForm)form tile:(CEIPoint)tile {
    NSMutableArray* switches = [NSMutableArray array];
    NSArray *rails = [_railsLayer objectsAtTile:tile];

    BOOL e[CR_RAIL_FORM_MAX + 1];
    [self fillFormIndex:e withRails:rails];
    e[form] = YES;

    for (CRRailForm f1 = crRailFormNil + 1; f1 <= CR_RAIL_FORM_MAX; f1++) {
        if(!e[f1]) continue;

        for (CRRailForm f2 = f1 + 1; f2 <= CR_RAIL_FORM_MAX; f2++) {
            if(!e[f2]) continue;

            if(f1 == crRailFormTurnXY && f2 == crRailFormTurn_X_Y) continue;
            if(f1 == crRailFormTurnX_Y && f2 == crRailFormTurn_XY) continue;

            CRSwitch * aSwitch;
            aSwitch = nil;
            for (CRRailForm f3 = f2 + 1; f3 <= CR_RAIL_FORM_MAX; f3++) {
                if(!e[f3]) continue;

                aSwitch = [CRSwitch switchWithForm1:f1 form2:f2 form3:f3];
                if(aSwitch != nil) {
                    e[f3] = NO;
                    [switches addObject:aSwitch];
                }
            }
            if(aSwitch == nil) {
                aSwitch = [CRSwitch switchWithForm1:f1 form2:f2 form3:crRailFormNil];
                if(aSwitch != nil) {
                    [switches addObject:aSwitch];
                }
            }
        }
    }

    return switches;
}

- (void)updateSwitchesInTile:(CEIPoint)tile {
    [_switchLayer clearTile:tile];

    NSArray *switches = [self maybeCreateSwitchesForRailForm:crRailFormNil tile:tile];
    for (CRSwitch * aSwitch in switches) {
        [_switchLayer addChild:aSwitch tile:tile];
    }
}
@end