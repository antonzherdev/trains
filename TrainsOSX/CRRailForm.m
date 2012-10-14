#import "CRRailForm.h"

@implementation CRRailFormObject

+ (id)initSprite:(CCSprite *)sprite forForm:(CRRailForm)form {
    CGRect rect;
    switch (form) {
        case crRailFormHorizontal:
            rect = CGRectMake(0, 0, 160, 25);
            break;
        case crRailFormVertical:
            rect = CGRectMake(357, 0, 37, 100);
            break;
        case crRailFormTurn1:
            rect = CGRectMake(160, 25, 197, 125);
            break;
        case crRailFormTurn2:
            rect = CGRectMake(0, 25, 160, 125);
            break;
        case crRailFormTurn3:
            rect = CGRectMake(0, 150, 160, 100);
            break;
        case crRailFormTurn4:
            rect = CGRectMake(160, 150, 197, 100);
            break;
        default:
            @throw @"Unknown form";
    }

    return [sprite initWithFile:@"Rails.png" rect:rect];
}


@end

