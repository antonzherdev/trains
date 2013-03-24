#import <Foundation/Foundation.h>
#import "cr.h"

@class CRSwitch;


@interface CRSwitchView : CCNode
@property (readonly, nonatomic) CRSwitch * ctrl;

- (id)initWithCtrl:(CRSwitch *)ctrl;
+ (id)viewWithCtrl:(CRSwitch *)ctrl;

@end