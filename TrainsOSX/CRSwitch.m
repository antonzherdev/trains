#import "CRSwitch.h"


@implementation CRSwitch {
    CRRailForm _form1;
    CRRailForm _form2;
    CRRailForm _form3;
}

@synthesize form1 = _form1;
@synthesize form2 = _form2;

- (id)initWithForm1:(CRRailForm)form1 form2:(CRRailForm)form2 form3:(CRRailForm)form3 {
    self = [super init];
    if (self) {
        _form1 = form1;
        _form2 = form2;
        _form3 = form3;
       
        CGFloat x;
        CGFloat y = 110;
        BOOL flipX = NO;
        if(_form1 == crRailFormX && _form2 == crRailFormTurn_X_Y && _form3 == crRailFormNil) {
            x = 0;
        } else if(_form1 == crRailFormY && _form2 == crRailFormTurnXY && _form3 == crRailFormNil) {
            x = 0;
            flipX = YES;
        } else if(_form1 == crRailFormX && _form2 == crRailFormTurnXY && _form3 == crRailFormNil) {
            x = 220;
        }else if(_form1 == crRailFormY && _form2 == crRailFormTurn_X_Y && _form3 == crRailFormNil) {
            x = 220;
            flipX = YES;
        } else if(_form1 == crRailFormX && _form2 == crRailFormTurn_XY && _form3 == crRailFormNil) {
            x = 440;
        } else if(_form1 == crRailFormX && _form2 == crRailFormTurnX_Y && _form3 == crRailFormNil) {
            x = 660;
        } else if(_form1 == crRailFormX && _form2 == crRailFormY && _form3 == crRailFormNil) {
            x = 880;
        } else if(_form1 == crRailFormX && _form2 == crRailFormY && _form3 == crRailFormTurn_X_Y) {
            x = 0;
            y = 220;
        } else if(_form1 == crRailFormX && _form2 == crRailFormY && _form3 == crRailFormTurnXY) {
            x = 0;
            y = 220;
            flipX = YES;
        } else {
            [self autorelease];
            return nil;
        }

        CGRect rect = CGRectMake(x, y, 220, 110);
        CCSprite *sprite = [CCSprite spriteWithFile:@"Rails.png" rect:rect];
        if(flipX) [sprite setFlipX:YES];
        [self addChild:sprite];
    }

    return self;
}

+ (id)switchWithForm1:(CRRailForm)form1 form2:(CRRailForm)form2 form3:(CRRailForm)form3 {
    return [[[CRSwitch alloc] initWithForm1:form1 form2:form2 form3:form3] autorelease];
}

@end