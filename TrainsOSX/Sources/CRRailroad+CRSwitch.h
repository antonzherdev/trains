#import <Foundation/Foundation.h>
#import "CRRailroad.h"
#import "cr.h"

@interface CRRailroad (CRSwitch)
- (BOOL)canBuildRailWithForm:(CRRailForm)form tile:(CEIPoint)tile;

- (NSArray *)maybeCreateSwitchesForRailForm:(CRRailForm)form tile:(CEIPoint)tile;

- (void)updateSwitchesInTile:(CEIPoint)tile;
@end