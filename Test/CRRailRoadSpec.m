#import "Kiwi.h"
#import "cr.h"
#import "CRRailroad.h"
#import "CRRail.h"
#import "CRRailroad+CRRailPoint.h"

static const int TH = 110;
SPEC_BEGIN(CRRailRoadSpec)
describe(@"CRailRoad", ^{
    CEOrtoMapDim dim;
    dim.tileHeight = TH;
    dim.size = ceISize(14, 17);
    CRRailroad* road = [CRRailroad railroadForDim:dim];

    void (^addRail)(CRRailForm*, CEIPoint) = ^(CRRailForm *form, CEIPoint tile) {
        id rail = [CRRail nullMock];
        [rail stub:@selector(form) andReturn:form];

        [road addRail:rail tile:tile];
    };


    context(@"+CRRailPoint", ^{
        CGFloat (^xLen)(CGFloat) = ^CGFloat(CGFloat x) {
            return TH*[crRailFormX length]*x;
        };
        addRail(crRailFormTurnXY, cei(-1, 8));
        addRail(crRailFormX, cei(0, 8));
        addRail(crRailFormX, cei(1, 8));

        it(@"should appends length to point", ^{
            CRRailPoint p;
            p.x = 0.3;
            p.form = crRailFormX;
            CRMoveRailPointResult r = [road moveRailPoint:p length:xLen(0.2)];
            [[theValue(r.railPoint.x) should] equal:0.5 withDelta:0.0001];
            [[theValue(r.error) should] beZero];
            [[theValue(r.direction) should] equal:theValue(crForward)];
            r = [road moveRailPoint:p length:xLen(-0.2)];
            [[theValue(r.railPoint.x) should] equal:0.1 withDelta:0.0001];
            [[theValue(r.error) should] beZero];
            [[theValue(r.direction) should] equal:theValue(crBackward)];
        });
        it(@"should move point to next rail", ^{
            CRRailPoint p;
            p.tile = cei(0, 8);
            p.type = crRailTypeRail;
            p.x = 0.9;
            p.form = crRailFormX;
            CRMoveRailPointResult r = [road moveRailPoint:p length:xLen(0.2)];
            [[theValue(r.railPoint.x) should] equal:0.1 withDelta:0.0001];
            [[theValue(r.railPoint.tile.x) should] equal:theValue(1)];
            [[theValue(r.railPoint.tile.y) should] equal:theValue(8)];
            [[theValue(r.error) should] beZero];
            [[theValue(r.direction) should] equal:theValue(crForward)];

            r = [road moveRailPoint:r.railPoint length:xLen(-0.2)];
            [[theValue(r.railPoint.x) should] equal:0.9 withDelta:0.0001];
            [[theValue(r.railPoint.tile.x) should] equal:theValue(0)];
            [[theValue(r.railPoint.tile.y) should] equal:theValue(8)];
            [[theValue(r.error) should] beZero];
            [[theValue(r.direction) should] equal:theValue(crBackward)];
        });
        it(@"should return error if there are no rails", ^{
            CRRailPoint p;
            p.tile = cei(1, 8);
            p.type = crRailTypeRail;
            p.x = 0.9;
            p.form = crRailFormX;
            CRMoveRailPointResult r = [road moveRailPoint:p length:xLen(0.2)];
            [[theValue(r.railPoint.x) should] equal:1.0 withDelta:0.0001];
            [[theValue(r.railPoint.tile.x) should] equal:theValue(1)];
            [[theValue(r.railPoint.tile.y) should] equal:theValue(8)];
            [[theValue(r.error) should] equal:xLen(0.1) withDelta:0.0001];
            [[theValue(r.direction) should] equal:theValue(crForward)];
        });
        it(@"should invert direction if move point from x back to +x+y rail form", ^{
            CRRailPoint p;
            p.tile = cei(0, 8);
            p.type = crRailTypeRail;
            p.x = 0.1;
            p.form = crRailFormX;
            CRMoveRailPointResult r = [road moveRailPoint:p length:xLen(-0.2)];
            [[theValue(r.railPoint.x) should] equal:0.1*[crRailFormX length]/[crRailFormTurnXY length] withDelta:0.0001];
            [[theValue(r.railPoint.tile.x) should] equal:theValue(-1)];
            [[theValue(r.railPoint.tile.y) should] equal:theValue(8)];
            [[theValue(r.error) should] beZero];
            [[theValue(r.direction) should] equal:theValue(crForward)];
        });
    });
});
 SPEC_END


