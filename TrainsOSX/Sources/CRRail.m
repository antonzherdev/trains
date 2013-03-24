#import "CRRail.h"


@implementation CRRail {
    CRRailForm* _form;
    CEIPoint _tile;
}
@synthesize form = _form;
@synthesize tile = _tile;


+ (id)railWithForm:(CRRailForm*)form {
    return [[[CRRail alloc] initWithForm:form] autorelease];
}


- (id)initWithForm:(CRRailForm*)form {
    self = [super init];
    if (self) {
        _form = form;
    }

    return self;
}

- (CRRailType)railType {
    return crRailTypeRail;
}

@end
