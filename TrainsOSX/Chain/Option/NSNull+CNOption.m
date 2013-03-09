#import "NSNull+CNOption.h"


@implementation NSNull (CNOption)
- (void)foreach:(void (^)(id))f {}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if(signature != nil) return signature;
    signature = [NSMethodSignature signatureWithObjCTypes:"@"];
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {

}

@end