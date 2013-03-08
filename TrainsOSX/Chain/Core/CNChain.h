#import <Foundation/Foundation.h>
#import "cnTypes.h"

@interface CNChain : NSObject
+ (CNChain*)chainWithCollection:(NSObject<NSFastEnumeration>*)collection;

- (NSArray*)array;

- (CNChain*)link:(id<CNChainLink>)link;
- (CNChain*)filter:(cnPredicate)predicate;
- (CNChain*)filter:(cnPredicate)predicate selectivity:(double)selectivity;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToChain:(CNChain *)chain;

- (NSUInteger)hash;
@end
