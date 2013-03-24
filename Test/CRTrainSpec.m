#import "Kiwi.h"
#import "cr.h"
#import "CRTrain.h"
#import "CRRailroad.h"
#import "CRRailroad+Mock.h"
#import "CRCar.h"

SPEC_BEGIN(CRTrainSpec)
describe(@"CRTrain", ^{
    it(@"should distribute cars", ^{
        id road = [CRRailroad nullMock];

        CRTrain * train = [CRTrain trainWithRailroad:road color:crGreen];
        id car1 = [CRCar nullMock];
        [car1 stub:@selector(length) andReturn:theValue(33)];
        [train addCar:car1];
        id car2 = [CRCar nullMock];
        [car2 stub:@selector(length) andReturn:theValue(37)];
        [train addCar:car2];

        CRRailVector v;
        v.railPoint.x = 1.0;
        v.railPoint.tile = cei(0, 0);
        v.railPoint.type = crRailTypeRail;
        v.direction = crForward;
        [[[car1 should] receive] setStart:ccp(1.0, 0) end:ccp(0.77, 0)];
        [[[car2 should] receive] setStart:ccp(0.77, 0) end:ccp(0.4, 0)];
        [train startFromVector:v];
    });
});
SPEC_END