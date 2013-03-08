#import "CNChainTest.h"
#import "chain.h"
#import "Kiwi.h"

SPEC_BEGIN(CNChainSpec)

  describe(@"The CNChain", ^{
      NSArray *s = [NSArray arrayWithObjects:@1, @3, @2, nil];
      it(@"should return the same array without any actions", ^{
          NSArray *r = [[CNChain chainWithCollection:s] array];
          [[r should] equal:s];
          r = [[s chain] array];
          [[r should] equal:s];
      });

      it(@"should filter items with condition", ^{
          NSArray *r = [[s filter:^BOOL(id x) {return [x intValue] <= 2;}] array];
          [[r should] equal:@[@1, @2]];
      });
      it(@"should modify values with map function", ^{
          NSArray *r = [[s map:^id(id x) {return [NSNumber numberWithInt:[x intValue] * 2];}] array];
          [[r should] equal:@[@2, @6, @4]];
      });
      it(@"should perform several operations in one chain", ^{
          NSArray *r = [[[s
                        filter:^BOOL(id x) {return [x intValue] <= 2;}]
                        map:^id(id x) {return [NSNumber numberWithInt:[x intValue] * 2];}]
                    array];
          [[r should] equal:@[@2, @4]];
      });
  });

SPEC_END