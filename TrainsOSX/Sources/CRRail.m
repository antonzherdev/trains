#import "CRRail.h"


@implementation CRRail {
    CRRailForm* _form;
    CEIPoint _tile;
}
@synthesize form = _form;
@synthesize tile = _tile;


+ (id)railWithForm:(CRRailForm *)form tile:(CEIPoint)tile {
    return [[[CRRail alloc] initWithForm:form tile:tile] autorelease];
}


- (id)initWithForm:(CRRailForm *)form tile:(CEIPoint)tile {
    self = [super init];
    if (self) {
        _form = form;
        _tile=tile;
    }

    return self;
}

- (CRRailType)railType {
    return crRailTypeRail;
}

@end
