#import <Foundation/Foundation.h>
#import "cnTypes.h"

@interface CNChain : NSObject
+ (CNChain*)chainWithCollection:(NSObject<NSFastEnumeration>*)collection;

- (id)apply;

- (CNChain*)link:(id<CNChainLink>)link;
@end
