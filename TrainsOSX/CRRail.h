#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"

@class CRRailroad;

typedef enum {
    crRailFormUnknown,
    crRailFormX,
    crRailFormY,
    crRailFormTurn1,
    crRailFormTurn2,
    crRailFormTurn3,
    crRailFormTurn4
} CRRailForm;

@interface CRRail : CCSprite
@property(nonatomic, readonly) CRRailForm form;

+ (id)railWithForm:(CRRailForm)form;

- (id)initWithForm:(CRRailForm)form;
@end

