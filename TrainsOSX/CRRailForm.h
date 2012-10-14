#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"

@class CRRail;

typedef enum {
    crRailFormHorizontal,
    crRailFormVertical,
    crRailFormTurn1,
    crRailFormTurn2,
    crRailFormTurn3,
    crRailFormTurn4
} CRRailForm;

@interface CRRailFormObject : NSObject
+ (id)initSprite:(CCSprite *)sprite forForm:(CRRailForm)form;
@end


