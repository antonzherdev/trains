#import "CRRail.h"


@implementation CRRail {
    CRRailForm _form;
}
@synthesize form = _form;

+ (id)railWithForm:(CRRailForm)form {
    return [[[CRRail alloc] initWithForm:form] autorelease];
}


- (id)initWithForm:(CRRailForm)form {
    CGRect rect;
    if(form == crRailFormY || form == crRailFormX) {
        rect = CGRectMake(0, 0, 220, 110);
    } else if (form == crRailFormTurnX_Y || form == crRailFormTurn_XY){
        rect = CGRectMake(220, 0, 220, 110);
    } else if(form == crRailFormTurnXY){
        rect = CGRectMake(0, 110, 220, 110);
    } else {
        rect = CGRectMake(220, 110, 220, 110);
    }
    self = [self initWithFile:@"Rails.png" rect:rect];
    if (self) {
        if(form == crRailFormY || form == crRailFormTurn_XY) {
            [self setFlipX:YES];
        }
        _form = form;
    }

    return self;
}
@end
