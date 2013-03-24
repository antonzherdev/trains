#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"
#import "cr.h"

@interface CRSwitch : CECtrl
@property (nonatomic, readonly)CRRailForm* form1;
@property (nonatomic, readonly)CRRailForm* form2;
@property(nonatomic, readonly) CEIPoint tile;
@property(nonatomic) int state;

- (id)initWithForm1:(CRRailForm*)form1 form2:(CRRailForm*)form2;

+ (id)switchWithForm1:(CRRailForm*)form1 form2:(CRRailForm*)form2;

@end