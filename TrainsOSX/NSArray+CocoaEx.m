#import "NSArray+CocoaEx.h"


@implementation NSArray (CocoaEx)
- (NSArray *)subarrayFrom:(NSUInteger)start {
    return [self subarrayWithRange:NSMakeRange(start, self.count - start)];
}

@end