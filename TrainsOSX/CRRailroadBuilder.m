#import "CRRailroadBuilder.h"
#import "CRRailroad.h"
#import "CCNode+CENode.h"


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
    CGPoint point = [self point:event];
    CCLOG(@"Mouse down on point (%f,%f)", point.x, point.y);
    CETile tile = [_railroad tileForPoint:point];
    if(![_railroad isValidTile:tile]) return NO;

    CCLOG(@"Mouse down on tile (%d,%d)", tile.x, tile.y);

    return NO;
}

- (BOOL)ccMouseMoved:(NSEvent *)event {
    return NO;
}

- (BOOL)ccMouseUp:(NSEvent *)event {
    return NO;
}


@end