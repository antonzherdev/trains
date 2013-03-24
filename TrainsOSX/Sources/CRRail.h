#import "cr.h"

@interface CRRail : NSObject
@property(nonatomic, readonly) CRRailForm* form;
@property(nonatomic, readonly) CEIPoint tile;

+ (id)railWithForm:(CRRailForm*)form;

- (id)initWithForm:(CRRailForm*)form;

- (CRRailType)railType;
@end

