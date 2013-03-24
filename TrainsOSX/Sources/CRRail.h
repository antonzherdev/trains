#import "cr.h"

@interface CRRail : NSObject
@property(nonatomic, readonly) CRRailForm* form;
@property(nonatomic, readonly) CEIPoint tile;

+ (id)railWithForm:(CRRailForm *)form tile:(CEIPoint)tile;

- (id)initWithForm:(CRRailForm *)form tile:(CEIPoint)tile;

- (CRRailType)railType;
@end

