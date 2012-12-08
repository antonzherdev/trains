#import "CRSwitch.h"


@implementation CRSwitch {
    CRRailForm _form1;
    CRRailForm _form2;
}

@synthesize form1 = _form1;
@synthesize form2 = _form2;

- (id)initWithForm1:(CRRailForm)form1 form2:(CRRailForm)form2 {
    self = [super init];
    if (self) {
        if(form1 < form2) {
            _form1 = form1;
            _form2 = form2;
        } else {
            _form2 = form1;
            _form1 = form2;
        }

        CGFloat x;
        BOOL flipX = NO;
        if(_form1 == crRailFormX && _form2 == crRailFormTurn_X_Y) {
            x = 0;
        } else if(_form1 == crRailFormY && _form2 == crRailFormTurnXY) {
            x = 0;
            flipX = YES;
        } else if(_form1 == crRailFormX && _form2 == crRailFormTurnXY) {
            x = 220;
        }else if(_form1 == crRailFormY && _form2 == crRailFormTurn_X_Y) {
            x = 220;
            flipX = YES;
        } else {
            @throw @"Unknown switch";
        }

        CGRect rect = CGRectMake(x, 110, 220, 110);
        CCSprite *sprite = [CCSprite spriteWithFile:@"Rails.png" rect:rect];
        if(flipX) [sprite setFlipX:YES];
        [self addChild:sprite];
    }

    return self;
}

+ (id)switchWithForm1:(CRRailForm)form1 form2:(CRRailForm)form2 {
    return [[[CRSwitch alloc] initWithForm1:form1 form2:form2] autorelease];
}

@end