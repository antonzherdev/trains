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
+ (id)trainWithLevel:(CRLevel *)level railroad:(CRRailroad *)railroad color:(CRCityColor*)color;

- (id)initWithLevel:(CRLevel *)level railroad:(CRRailroad *)railroad color:(CRCityColor*)color;

- (void)addCarWithType:(CRCarType)type;

- (void)startFromCityWithColor:(CRCityColor*)color;

- (void)move:(CGFloat)length;

@end
