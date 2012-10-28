#import "CCNode+CENode.h"
#import "CCDirectorMac.h"


@implementation CCNode (CENode)
- (CGPoint)point:(NSEvent *)event {
    CGPoint gl = [[CCDirector sharedDirector] convertEventToGL:event];
    return [self convertToNodeSpace:gl];
}

@end