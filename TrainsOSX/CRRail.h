#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"

@class CRRailroad;

typedef enum {
    crRailFormX,
    crRailFormY,
    crRailFormTurn1,
    crRailFormTurn2,
    crRailFormTurn3,
    crRailFormTurn4
} CRRailForm;

@interface CRRail : CCSprite
+ (id)railWithForm:(CRRailForm)form;

- (id)initWithForm:(CRRailForm)form;
@end

