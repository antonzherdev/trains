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
@property(nonatomic) CGPoint tile;

+ (id)railInRailroad:(CRRailroad *)railroad form:(CRRailForm)form tile:(CGPoint)tile;

- (id)initWithRailroad:(CRRailroad *)railroad form:(CRRailForm)form tile:(CGPoint)tile;
@end

