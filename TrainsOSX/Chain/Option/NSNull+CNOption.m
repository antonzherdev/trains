#import "NSNull+CNOption.h"


@implementation NSNull (CNOption)
- (void)foreach:(void (^)(id))f {}

- (void)doesNotRecognizeSelector:(SEL)aSelector {

}

- (void)forwardInvocation:(NSInvocation *)anInvocation {

}


@end