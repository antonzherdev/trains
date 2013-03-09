#import "NSObject+CNOption.h"


@implementation NSObject (CNOption)
- (void)foreach:(void (^)(id))f {
    f(self);
}


@end