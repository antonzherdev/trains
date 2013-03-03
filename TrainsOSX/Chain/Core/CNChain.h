#import <Foundation/Foundation.h>
#import "cnTypes.h"

@interface CNChain : NSObject
+ (CNChain*)chainWithCollection:(NSObject<NSFastEnumeration>*)collection;

- (NSArray*)array;

- (CNChain*)link:(id<CNChainLink>)link;
@end
