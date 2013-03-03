#import "CNChain.h"
#import "CNSourceLink.h"
#import "CNChainItem.h"


@implementation CNChain {
    CNChainItem* _first;
    CNChainItem* _last;
}

+ (CNChain*)chainWithCollection:(NSObject<NSFastEnumeration>*)collection {
    CNChain *chain = [[CNChain alloc] init];
    [chain link:[CNSourceLink linkWithCollection:collection]];
    return [chain autorelease];
}

- (CNChain*)link:(id <CNChainLink>)link {
    CNChainItem *next = [CNChainItem itemWithLink:link];
    if(_first == nil) {
        _first = [next retain];
        _last = _first;
    } else {
        _last.next = next;
        _last = next;
    }
    return self;
}

- (id)apply {
    return nil;
}

- (void)dealloc {
    [_first release];
    [super dealloc];
}
@end