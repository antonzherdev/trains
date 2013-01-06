#import "NSMutableArray+CocoaEx.h"


@implementation NSMutableArray (CocoaEx)
- (id)takeLastObject {
    id ret = [self lastObject];
    [self removeLastObject];
    return ret;
}

- (void)revert {
    NSUInteger n = [self count];
    for (NSUInteger i = 0; i < n >> 1; i ++) {
        id o = [self objectAtIndex:i];
        [self replaceObjectAtIndex:i withObject:[self objectAtIndex:n - i - 1]];
        [self replaceObjectAtIndex:n - i - 1 withObject:o];
    }
}

@end