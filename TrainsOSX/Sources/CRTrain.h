#import "cr.h"

@class CRRailroad;
@class CRLevel;
@class CRCity;

@protocol CRTrainDelegate
- (void)train:(CRTrain*) train goingToCity:(CRCity*)city;
- (void)train:(CRTrain*) train arrivedToCity:(CRCity*)city;
@end

@interface CRTrain : CCNode
@property(nonatomic, readonly) CRCityColor* color;
@property(nonatomic) CGFloat speed;
@property(nonatomic, assign) id<CRTrainDelegate> delegate;

+ (id)trainWithRailroad:(CRRailroad *)railroad color:(CRCityColor *)color;

- (id)initWithRailroad:(CRRailroad *)railroad color:(CRCityColor *)color;

- (void)addCarWithType:(CRCarType)type;

- (void)addCar:(CRCar *)car;

- (void)startFromCityWithColor:(CRCityColor*)color;

- (void)startFromVector:(CRRailVector)vector;

- (void)move:(CGFloat)length;

@end
