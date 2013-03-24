#import "CRRailroad+Mock.h"
#import "Kiwi.h"

@implementation CRRailroad (Mock)
+ (id)nullMock {
    id road = [super nullMock];
    [road stub:@selector(moveRailPoint:length:) withBlock:^id(NSArray *params) {
        CRRailPoint p;
        [[params objectAtIndex:0] getValue:&p];
        p.x += [[params objectAtIndex:1] doubleValue]/100.0;
        CRMoveRailPointResult r;
        r.railPoint = p;
        r.direction = crDirection([[params objectAtIndex:1] doubleValue]);
        r.error = 0;
        return theValue(r);
    }];
    [road stub:@selector(calculateRailPoint:) withBlock:^id(NSArray *params) {
        CRRailPoint p;
        [[params objectAtIndex:0] getValue:&p];
        CGPoint r = ccp(p.x, p.tile.x);
        return theValue(r);
    }];
    return road;
}

@end