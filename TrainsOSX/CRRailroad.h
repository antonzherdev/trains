#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"

@class CRLevel;

@interface CRRailroad : CEOrtoMap
+ (CRRailroad *)railroadForLevel:(CRLevel *)level dim:(CEOrtoMapDim)dim;

- (id)initWithLevel:(CRLevel *)level dim:(CEOrtoMapDim)dim;
@end
