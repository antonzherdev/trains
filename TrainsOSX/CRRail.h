#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"
#import "CRRailForm.h"


@interface CRRail : CCSprite
+(id) railWithForm:(CRRailForm) form tile:(CGPoint) tile;

- (id)initWithForm:(CRRailForm)form tile:(CGPoint)tile;
@end

