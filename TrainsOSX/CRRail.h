#import "cr.h"

@interface CRRail : CCSprite
@property(nonatomic, readonly) CRRailForm form;

+ (CGPoint) calculateRailPoint:(CRRailPoint) railPoint railroad:(CRRailroad *) railroad;

+ (id)railWithForm:(CRRailForm)form;

- (id)initWithForm:(CRRailForm)form;
@end

