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

- (void)applyYield:(id <CNYield>)yield {
    [CNYield yieldAll:_collection in:yield];
}

+ (id)linkWithCollection:(NSObject<NSFastEnumeration>*)collection {
    return [[[self alloc] initWithCollection:collection] autorelease];
}

@end