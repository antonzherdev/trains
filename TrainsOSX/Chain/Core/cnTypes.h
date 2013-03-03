#import "CNYield.h"

@class CNChain;
typedef void (^cnChainBuildBlock)(CNChain *);


@protocol CNChainLink <NSObject>
- (void) applyYield:(id<CNYield>)yield;
@end