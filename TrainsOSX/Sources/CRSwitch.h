#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"
#import "cr.h"

@interface CRSwitch : CCNode
@property (nonatomic, readonly)CRRailForm* form1;
@property (nonatomic, readonly)CRRailForm* form2;

- (id)initWithForm1:(CRRailForm*)form1 form2:(CRRailForm*)form2;

+ (id)switchWithForm1:(CRRailForm*)form1 form2:(CRRailForm*)form2;

- (void)composite;

@end