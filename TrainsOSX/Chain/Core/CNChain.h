#import <Foundation/Foundation.h>
#import "cnTypes.h"

@interface CNChain : NSObject
+ (CNChain*)chainWithCollection:(NSObject<NSFastEnumeration>*)collection;

- (NSArray*)array;
- (NSSet*)set;

- (CNChain*)link:(id<CNChainLink>)link;
- (CNChain*)filter:(cnPredicate)predicate;
- (CNChain*)filter:(cnPredicate)predicate selectivity:(double)selectivity;

- (CNChain*)map:(cnF)f;

- (CNChain*)append:(NSObject<NSFastEnumeration>*)collection;
- (CNChain*)prepend:(NSObject<NSFastEnumeration>*)collection;

- (id) first;
@end
