#import "CRRail.h"


@implementation CRRail {
    CRRailForm* _form;
}
@synthesize form = _form;

+ (id)railWithForm:(CRRailForm*)form {
    return [[[CRRail alloc] initWithForm:form] autorelease];
}


- (id)initWithForm:(CRRailForm*)form {
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"rails_rails.plist"];
    self = [self initWithSpriteFrameName:form.name];
    if (self) {
        _form = form;
    }

    return self;
}

- (CRRailType)railType {
    return crRailTypeRail;
}

@end
