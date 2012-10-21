#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"

typedef enum {
    crRailFormHorizontal,
    crRailFormVertical,
    crRailFormTurn1,
    crRailFormTurn2,
    crRailFormTurn3,
    crRailFormTurn4
} CRRailForm;

@interface CRRail : CCSprite
+(id) railWithForm:(CRRailForm) form tile:(CGPoint) tile;

- (id)initWithForm:(CRRailForm)form tile:(CGPoint)tile;
@end

