#import "cr.h"

@interface CRRail : CCSprite
@property(nonatomic, readonly) CRRailForm form;

+ (id)railWithForm:(CRRailForm)form;

- (id)initWithForm:(CRRailForm)form;
@end

