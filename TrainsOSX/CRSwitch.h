#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"
#import "cr.h"

@interface CRSwitch : CCNode
@property (nonatomic)CRRailForm form1;
@property (nonatomic)CRRailForm form2;

- (id)initWithForm1:(CRRailForm)form1 form2:(CRRailForm)form2 form3:(CRRailForm)form3;

+ (id)switchWithForm1:(CRRailForm)form1 form2:(CRRailForm)form2 form3:(CRRailForm)form3;

@end