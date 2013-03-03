#import "NSArray+CNChain.h"
#import "CNChain.h"


@implementation NSArray (CNChain)
- (id)chain:(void (^)(CNChain *))block {
    CNChain *chain = [CNChain chainWithCollection:self];
    block(chain);
    return [chain array];
}

- (CNChain *)chain {
    return [CNChain chainWithCollection:self];
}


@end