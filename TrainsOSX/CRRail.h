#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"

@class CRRailroad;

typedef enum {
    crRailFormUnknown,
    crRailFormX,
    crRailFormY,
    crRailFormTurnX_Y,
    crRailFormTurnXY,
    crRailFormTurn_XY,
    crRailFormTurn_X_Y
} CRRailForm;

@interface CRRail : CCSprite
@property(nonatomic, readonly) CRRailForm form;

+ (id)railWithForm:(CRRailForm)form;

- (id)initWithForm:(CRRailForm)form;
@end

