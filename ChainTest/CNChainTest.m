#import "CNChainTest.h"
#import "chain.h"

@implementation CNChainTest

- (void)testSource {
    NSArray *array = [NSArray arrayWithObjects:@1, @3, @2, nil];
    STAssertTrue(array == [[CNChain chainWithCollection:array] array], @"array == [[CNChain chainWithCollection:array] array]");
    STAssertTrue(array == [[array chain] array], @"array == [[array chain] array]");
}

@end
