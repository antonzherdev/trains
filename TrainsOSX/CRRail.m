#import "CRRail.h"
#import "CRRailroad.h"


@implementation CRRail {
    id<CRRailFormDescription> _railFormDescription;
}

+ (id)railWithForm:(CRRailForm)form tile:(CGPoint)tile {
    return [[[CRRail alloc] initWithForm: form tile: tile] autorelease];
}


- (id)initWithForm:(CRRailForm)form tile:(CGPoint)tile {
    id<CRRailFormDescription> description = [CRRailFormDescriptionFactory descriptionForForm:form];
    NSString *file = [description file];

    self = [super initWithFile:file];
    if (self) {
        _railFormDescription = description;
        self.anchorPoint = ccp(0, 0);
        self.position = ccpAdd([CRRailroad positionForTile:tile], [description spritePosition]);
    }

    return self;
}

@end