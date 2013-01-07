#import "CRSwitchesComposition.h"
#import "CRSwitch.h"


@implementation CRSwitchesComposition {
    CRSwitch *_switch1;
    CRSwitch *_switch2;
    CRSwitch *_switch3;
}

- (id)initWithSwitch:(CRSwitch *)s {
    self = [super init];
    if (self) {
        _switch1 = s;
    }

    return self;
}

+ (CRSwitchesComposition *)compositionWithSwitch:(CRSwitch *)s {
    return [[[CRSwitchesComposition alloc] initWithSwitch:s] autorelease];
}

- (void)onEnter {
    [super onEnter];

    [self addChild:_switch1 z:1];
    if(_switch2 != nil) [self addChild:_switch2 z:1];
    if(_switch3 != nil) [self addChild:_switch3 z:1];
}


- (BOOL)maybeJoinSwitch:(CRSwitch *)s {
    BOOL* e = calloc(CR_RAIL_FORMS_COUNT, sizeof(BOOL));
    @try {
        if(_switch2 != nil) {
            if(_switch3 != nil) return NO;

            e[_switch1.form1.ordinal] = YES;
            e[_switch1.form2.ordinal] = YES;
            e[_switch2.form1.ordinal] = YES;
            e[_switch2.form2.ordinal] = YES;
            if(e[s.form1.ordinal] && e[s.form2.ordinal]) {
                _switch3 = s;
                [_switch3 composite];
                return YES;
            }
            return NO;
        }


        e[_switch1.form1.ordinal] = YES;
        e[_switch1.form2.ordinal] = YES;
        e[s.form1.ordinal] = YES;
        e[s.form2.ordinal] = YES;
        int n = 0;
        for (int i = 0; i <= CR_RAIL_FORMS_COUNT; i++) {
            if(e[i]) n++;
        }
        if(n != 3) return NO;
        
        int x;
        BOOL flipX= NO;
        if (e[crRailFormX.ordinal] && e[crRailFormY.ordinal] && e[crRailFormTurn_X_Y.ordinal]) {
            x = 0;
        } else if (e[crRailFormX.ordinal] && e[crRailFormY.ordinal] && e[crRailFormTurnXY.ordinal]) {
            x = 0;
            flipX = YES;
        } else{
            return NO;
        }
        _switch2 =s;
        [_switch1 composite];
        [_switch2 composite];

        CGRect rect = CGRectMake(x, 220, 220, 110);
        CCSprite *sprite = [CCSprite spriteWithFile:@"Rails.png" rect:rect];
        if(flipX) [sprite setFlipX:YES];
        [self addChild:sprite z:0];

        return YES;
    } @finally {
        free(e);
    }
}

@end