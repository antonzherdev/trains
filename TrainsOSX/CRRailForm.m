#import "CRRailForm.h"

@implementation CRRailFormObject

+ (id)initSprite:(CCSprite *)sprite forForm:(CRRailForm)form {
    CGRect rect;
    if(form == crRailFormVertical || form == crRailFormHorizontal) {
        rect = CGRectMake(0, 0, 192, 96);
    } else {
        rect = CGRectMake(0, 96, 192, 96);
    }
    CCSprite *ret = [sprite initWithFile:@"Rails.png" rect:rect];
    switch (form) {
        case crRailFormHorizontal:
            break;
        case crRailFormVertical:
            [ret setFlipX:YES];
            break;
        case crRailFormTurn1:
            break;
        case crRailFormTurn2:
            [ret setFlipX:YES];;
            break;
        case crRailFormTurn3:
            [ret setFlipX:YES];
            [ret setFlipY:YES];
            break;
        case crRailFormTurn4:
            [ret setFlipY:YES];
            break;
        default:
            @throw @"Unknown form";
    }

    return ret;
}


@end

