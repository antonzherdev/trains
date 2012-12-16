#import <Foundation/Foundation.h>
#import "CCNode.h"

@class CRSwitch;


@interface CRSwitchesComposition : CCNode
- (id)initWithSwitch:(CRSwitch *)s;

+ (CRSwitchesComposition *)compositionWithSwitch:(CRSwitch *)s;

- (BOOL)maybeJoinSwitch:(CRSwitch *)s;
@end