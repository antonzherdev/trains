#import "CNChain.h"
#import "CNSourceLink.h"
#import "CNChainItem.h"
#import "CNFilterLink.h"
#import "CNMapLink.h"
#import "CNOption.h"


@implementation CNChain {
    CNChainItem* _first;
    CNChainItem* _last;
}
+ (CNChain*)chainWithCollection:(NSObject<NSFastEnumeration>*)collection {
    CNChain *chain = [[CNChain alloc] init];
    [chain link:[CNSourceLink linkWithCollection:collection]];
    return [chain autorelease];
}

- (NSArray *)array {
    __block id ret;
    CNYield *yield = [CNYield yieldWithBegin:^CNYieldResult(NSUInteger size) {
        ret = [NSMutableArray arrayWithCapacity:size];
        return cnYieldContinue;
    } yield:^CNYieldResult(id item) {
        [ret addObject:item];
        return cnYieldContinue;
    } end:nil all:^CNYieldResult(NSObject<NSFastEnumeration>* collection) {
        if([collection isKindOfClass:[NSArray class]]) {
            ret = collection;
            return cnYieldContinue;
        }
        return cnYieldBreak;
        //return [CNYield yieldAll:collection byItemsTo:yield];
    }];
    [self apply:yield];
    return ret;
}

- (CNChain *)filter:(cnPredicate)predicate {
    return [self link:[CNFilterLink linkWithPredicate:predicate selectivity:0]];
}

- (CNChain *)filter:(cnPredicate)predicate selectivity:(double)selectivity {
    return [self link:[CNFilterLink linkWithPredicate:predicate selectivity:selectivity]];
}

- (CNChain *)map:(cnF)f {
    return [self link:[CNMapLink linkWithF:f]];
}

- (id)first {
    __block id ret = [CNOption none];
    [self apply:[CNYield yieldWithBegin:nil yield:^CNYieldResult(id item) {
        ret = item;
        return cnYieldBreak;
    } end:nil all:nil]];
    return ret;
}


- (CNYieldResult)apply:(CNYield *)yield {
    CNYield *y = [_first buildYield:yield];
    CNYieldResult result = [y beginYieldWithSize:0];
    return [y endYieldWithResult:result];
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

- (void)dealloc {
    [_first release];
    [super dealloc];
}

@end