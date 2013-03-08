#import "CNChainTest.h"
#import "chain.h"

@implementation CNChainTest

- (void)testSource {
    NSArray *array = [NSArray arrayWithObjects:@1, @3, @2, nil];
    STAssertTrue(array == [[CNChain chainWithCollection:array] array], @"array == [[CNChain chainWithCollection:array] array]");
    STAssertTrue(array == [[array chain] array], @"array == [[array chain] array]");
}

- (void)testFilter {
    NSArray *array = [NSArray arrayWithObjects:@2, @3, @1, nil];
    CNChain *chain = [array filter:^BOOL(id x) {
        return [x intValue] <= 2;
    }];
    NSArray *exp = [NSArray arrayWithObjects:@2, @1, nil];
    NSArray *result = [chain array];
    STAssertEquals(exp, result, @"Arrays");
}

@end
