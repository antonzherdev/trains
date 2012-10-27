#import "CRRail.h"
#import "CRRailroad.h"


@implementation CRRail {
    CRRailForm _form;
    CRRailroad *_railroad;
}

+ (id)railInRailroad:(CRRailroad *)railroad form:(CRRailForm)form tile:(CGPoint)tile {
    return [[[CRRail alloc] initWithRailroad:railroad form:form tile:tile] autorelease];
}


- (id)initWithRailroad:(CRRailroad *)railroad form:(CRRailForm)form tile:(CGPoint)tile {
    CGRect rect;
    if(form == crRailFormY || form == crRailFormX) {
        rect = CGRectMake(0, 0, 220, 110);
    } else if (form == crRailFormTurn1 || form == crRailFormTurn3){
        rect = CGRectMake(220, 0, 220, 110);
    } else if(form == crRailFormTurn2){
        rect = CGRectMake(0, 110, 220, 110);
    } else {
        rect = CGRectMake(220, 110, 220, 110);
    }
    self = [self initWithFile:@"Rails.png" rect:rect];
    if (self) {
        if(form == crRailFormY || form == crRailFormTurn3) {
            [self setFlipX:YES];
        }

        _form = form;
        _railroad = railroad;
        self.anchorPoint = ccp(0, 0);
        self.position = [railroad positionForTile:tile];
    }

    return self;
}

@end