#import "Kiwi.h"
#import "cr.h"
#import "CRRailroad.h"
#import "CRRailroad+CRRailPoint.h"

static const int TH = 110;
SPEC_BEGIN(CRRailRoadSpec)
describe(@"CRailRoad", ^{
    CEOrtoMapDim dim;
    dim.tileHeight = TH;
    dim.size = ceISize(14, 17);
    CRRailroad* road = [CRRailroad railroadForDim:dim];
    context(@"+CRRailPoint", ^{
        it(@"should appends length to point", ^{
            CRRailPoint p;
            p.x = 0.3;
            p.form = crRailFormX;
            CRMoveRailPointResult r = [road moveRailPoint:p length:TH*[crRailFormX length]*0.2];
            [[theValue(r.railPoint.x) should] equal:0.5 withDelta:0.0001];
            [[theValue(r.error) should] beZero];
            r = [road moveRailPoint:p length:-TH*[crRailFormX length]*0.2];
            [[theValue(r.railPoint.x) should] equal:0.1 withDelta:0.0001];
            [[theValue(r.error) should] beZero];
        });
    });
});
SPEC_END
