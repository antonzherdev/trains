#import <Foundation/Foundation.h>
#import "cnTypes.h"

@class CNChain;


@interface NSArray (CNChain)
- (id) chain:(cnChainBuildBlock)block;
- (CNChain*) chain;
@end