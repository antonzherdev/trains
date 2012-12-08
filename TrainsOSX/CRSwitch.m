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
        if(_form1 == crRailFormX && _form2 == crRailFormTurn_X_Y) {
            x = 0;
        } else {
            @throw @"Unknown switch";
        }
        CGRect rect = CGRectMake(x, 110, 220, 110);
        CCSprite *sprite = [CCSprite spriteWithFile:@"Rails.png" rect:rect];
        [self addChild:sprite];
    }

    return self;
}

+ (id)switchWithForm1:(CRRailForm)form1 form2:(CRRailForm)form2 {
    return [[[CRSwitch alloc] initWithForm1:form1 form2:form2] autorelease];
}

@end