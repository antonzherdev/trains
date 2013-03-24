#import "CNYield.h"


@implementation CNYield {
    cnYield _yield;
    cnYieldBegin _begin;
    cnYieldEnd _end;
    cnYieldAll _all;
}
- (id)initWithBegin:(cnYieldBegin)begin yield:(cnYield)yield end:(cnYieldEnd)end all:(cnYieldAll)all {
    self = [super init];
    if (self) {
        _begin = [begin copy];
        _yield = [yield copy];
        _end = [end copy];
        _all = [all copy];
    }

    return self;
}

+ (CNYield*)yieldWithBegin:(cnYieldBegin)begin yield:(cnYield)yield end:(cnYieldEnd)end all:(cnYieldAll)all {
    return [[[self alloc] initWithBegin:begin yield:yield end:end all:all] autorelease];
}

+ (CNYield *)decorateYield:(CNYield *)base begin:(cnYieldBegin)begin yield:(cnYield)yield end:(cnYieldEnd)end all:(cnYieldAll)all {
    if(begin == nil) {
        begin = ^CNYieldResult(NSUInteger size) {
            return [base beginYieldWithSize:size];
        };
    }
    if(yield == nil) {
        yield = ^CNYieldResult(id item) {
            return [base yieldItem:item];
        };
    }
    if(end == nil) {
        end = ^CNYieldResult(CNYieldResult result) {
            return [base endYieldWithResult:result];
        };
    }

    return [CNYield yieldWithBegin:begin yield:yield end:end all:all];
}


+ (CNYieldResult)yieldAll:(id <NSFastEnumeration>)collection byItemsTo:(CNYield *)yield {
    NSUInteger size = [collection count];
    CNYieldResult result = [yield beginYieldWithSize:size];
    if (result == cnYieldContinue) {
        for (id item in collection) {
            result = [yield yieldItem:item];
            if (result == cnYieldBreak) break;
        }
    }
    return [yield endYieldWithResult:result];
}

- (CNYieldResult)beginYieldWithSize:(NSUInteger)size {
    if(_begin == nil) return cnYieldContinue;
    return _begin(size);
}

- (CNYieldResult)yieldItem:(id)item {
    if(_yield == nil) return cnYieldContinue;
    return _yield(item);
}

- (CNYieldResult)endYieldWithResult:(CNYieldResult)result {
    if(_end == nil) return result;
    return _end(result);
}

- (CNYieldResult)yieldAll:(id <NSFastEnumeration>)collection {
    if(_all != nil) return _all(collection);

    return [CNYield yieldAll:collection byItemsTo:self];
}


- (void)dealloc {
    [_begin release];
    [_end release];
    [_yield release];
    [_all release];
    [super dealloc];
}


@end