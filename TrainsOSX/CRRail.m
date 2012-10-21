#import "CRRail.h"
#import "CRRailroad.h"


@implementation CRRail {
    CRRailForm _form;
}

+ (id)railWithForm:(CRRailForm)form tile:(CGPoint)tile {
    return [[[CRRail alloc] initWithForm: form tile: tile] autorelease];
}


- (id)initWithForm:(CRRailForm)form tile:(CGPoint)tile {
    CGRect rect;
    if(form == crRailFormVertical || form == crRailFormHorizontal) {
        rect = CGRectMake(0, 0, 192, 96);
    } else {
        rect = CGRectMake(0, 96, 192, 96);
    }
    self = [self initWithFile:@"Rails.png" rect:rect];
    if (self) {
        switch (form) {
            case crRailFormHorizontal:
                break;
            case crRailFormVertical:
                [self setFlipX:YES];
                break;
            case crRailFormTurn1:
                break;
            case crRailFormTurn2:
                [self setFlipX:YES];;
                break;
            case crRailFormTurn3:
                [self setFlipX:YES];
                [self setFlipY:YES];
                break;
            case crRailFormTurn4:
                [self setFlipY:YES];
                break;
            default:
                @throw @"Unknown form";
        }

        _form = form;
        self.anchorPoint = ccp(0, 0);
        self.position = [CRRailroad positionForTile:tile];
    }

    return self;
}

@end