#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"

@class CRRail;

typedef enum {
    crRailFormHorizontal,
    crRailFormVertical,
    crRailFormHorizontalTurnRight,
    crRailFormHorizontalTurnLeft,
    crRailFormVerticalTurnRight,
    crRailFormVerticalTurnLeft
} CRRailForm;

@interface CRRailFormObject : NSObject
+ (id)initSprite:(CCSprite *)sprite forForm:(CRRailForm)railForm;
@end


