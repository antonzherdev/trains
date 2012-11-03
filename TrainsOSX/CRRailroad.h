#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"

@class CRLevel;
@class CRRail;
@class CRCity;

@interface CRRailroad : CEOrtoMap
+ (CRRailroad *)railroadForLevel:(CRLevel *)level dim:(CEOrtoMapDim)dim;

- (id)initWithLevel:(CRLevel *)level dim:(CEOrtoMapDim)dim;

- (void)addCity:(CRCity *)city tile:(CEIPoint)tile;

- (void)addRail:(CRRail *)rail tile:(CEIPoint)tile;

@end
