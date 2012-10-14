#import "CRRailForm.h"

@implementation CRRailFormObject

+ (id)initSprite:(CCSprite *)sprite forForm:(CRRailForm)form {
    CGRect rect;
    switch (form) {
        case crRailFormHorizontal:
            rect = CGRectMake(0, 0, 100, 23);
            break;
        case crRailFormVertical:
            rect = CGRectMake(200, 0, 23, 100);
            break;
        case crRailFormTurn1:
            rect = CGRectMake(100, 23, 100, 100);
            break;
        case crRailFormTurn2:
            rect = CGRectMake(0, 23, 100, 100);
            break;
        case crRailFormTurn3:
            rect = CGRectMake(0, 123, 100, 100);
            break;
        case crRailFormTurn4:
            rect = CGRectMake(100, 123, 100, 100);
            break;
        default:
            @throw @"Unknown form";
    }

    return [sprite initWithFile:@"Rails.png" rect:rect];
}


@end

