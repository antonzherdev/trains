#import <Foundation/Foundation.h>
#import "cr.h"
#import "CRRailroad.h"

@interface CRRailroad (CRRailPoint)
- (CRMoveRailPointResult)moveRailPoint:(CRRailPoint)railPoint length:(CGFloat)length;

- (CGPoint)calculateRailPoint:(CRRailPoint)point;
@end