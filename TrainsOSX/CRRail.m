#import "CRRail.h"
#import "CRRailroad.h"


@implementation CRRail {
    CRRailForm _form;
}

+ (id)railWithForm:(CRRailForm)form tile:(CGPoint)tile {
    return [[[CRRail alloc] initWithForm: form tile: tile] autorelease];
}


- (id)initWithForm:(CRRailForm)form tile:(CGPoint)tile {
    self = [CRRailFormObject initSprite:self forForm:form];
    if (self) {
        _form = form;
        self.anchorPoint = ccp(0, 0);
        self.position = [CRRailroad positionForTile:tile];
    }

    return self;
}

@end