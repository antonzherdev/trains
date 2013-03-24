#import "CRSwitch.h"


@implementation CRSwitch {
    CRRailForm* _form1;
    CRRailForm* _form2;
    CEIPoint _tile;
    int _state;
}

@synthesize form1 = _form1;
@synthesize form2 = _form2;
@synthesize tile = _tile;

- (id)initWithForm1:(CRRailForm*)form1 form2:(CRRailForm*)form2 {
    self = [super init];
    if (self) {
        _form1 = form1;
        _form2 = form2;
        _state = 0;
    }

    return self;
}

+ (id)switchWithForm1:(CRRailForm*)form1 form2:(CRRailForm*)form2 {
    if((form1 == crRailFormTurn_X_Y && form2 == crRailFormTurnXY) ||
            (form1 == crRailFormTurn_XY && form2 == crRailFormTurnX_Y)) return nil;
    return [[[CRSwitch alloc] initWithForm1:form1 form2:form2] autorelease];
}

- (int)state {
    return _state;
}

- (void)setState:(int)state {
    if(_state != state) {
        _state = state;
        [self updated];
    }
}
@end