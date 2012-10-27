#import "CRRailroadBuilder.h"
#import "CRRailroad.h"


@implementation CRRailroadBuilder {
    CRRailroad *_railroad;
}

+ (id)builderForRailroad:(CRRailroad *)railroad {
    return [[[CRRailroadBuilder alloc] initWithRailroad:railroad] autorelease];
}

- (id)initWithRailroad:(CRRailroad *)railroad {
    self = [super init];
    if(self) {
        _railroad = railroad;
        self.isMouseEnabled = YES;
    }
    return self;
}

- (BOOL)ccMouseDown:(NSEvent *)event {
    return NO;
}

- (BOOL)ccMouseMoved:(NSEvent *)event {
    return NO;
}

- (BOOL)ccMouseUp:(NSEvent *)event {
    return NO;
}


@end