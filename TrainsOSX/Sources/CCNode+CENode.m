#import "CCNode+CENode.h"
#import "CCDirectorMac.h"


@implementation CCNode (CENode)
- (CGPoint)point:(NSEvent *)event {
    CCDirectorMac *dir = (CCDirectorMac *) [CCDirectorMac sharedDirector];
    CGPoint gl = [dir convertEventToGL:event];
    return [self convertToNodeSpace:gl];
}

@end