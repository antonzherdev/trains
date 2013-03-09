#import "chain.h"
#import "Kiwi.h"

SPEC_BEGIN(CNOpionSpec)
    describe(@"CNOption", ^{
        it(@"should execute foreach one time for not null object and no one for null", ^{
            __block int ex = 0;
            [@2 foreach:^(id o) {
                ex++;
                [[o should] equal:@2];
            }];
            [[theValue(ex) should] equal:theValue(1)];
            id null = [NSNull null];
            ex = 0;
            [null foreach:^(id o) {
                ex++;
            }];
            [[theValue(ex) should] equal:theValue(0)];
        });
        it(@"should behave like nil with selectors when it empty", ^{
            [[[[CNOption opt:@"test"] substringFromIndex:3] should] equal:@"t"];
            [[theValue([[CNOption opt:@"test"] length]) should] equal:theValue(4)];

            [[[CNOption none] substringFromIndex:3] shouldBeNil];
            [[theValue([[CNOption none] length]) should] equal:theValue(0)];
        });
        it(@"should return empty option with nil value", ^{
            [[[CNOption opt:nil] should] equal:[CNOption none]];
        });
    });
SPEC_END