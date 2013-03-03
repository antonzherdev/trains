#import "CNSourceLink.h"


@implementation CNSourceLink {
    NSObject<NSFastEnumeration>* _collection;
}
- (id)initWithCollection:(NSObject<NSFastEnumeration>*)collection {
    self = [super init];
    if (self) {
        _collection = [collection retain];
    }

    return self;
}

- (void)dealloc {
    [_collection release];
    [super dealloc];
}

- (CNYield *)buildYield:(CNYield *)yield {
    [yield retain];
    return [CNYield yieldWithBegin:nil yield:nil end:^CNYieldResult(CNYieldResult result) {
        if (result == cnYieldContinue) {
            [yield yieldAll:_collection];
        }
        [yield release];
        return cnYieldContinue;
    } all:nil];
}

+ (id)linkWithCollection:(NSObject<NSFastEnumeration>*)collection {
    return [[[self alloc] initWithCollection:collection] autorelease];
}

@end