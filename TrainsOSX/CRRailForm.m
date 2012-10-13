#import "CRRailForm.h"

@implementation CRRailFormObject

+ (id)initSprite:(CCSprite *)sprite forForm:(CRRailForm)railForm {
    NSString *filename = (railForm == crRailFormHorizontal || railForm == crRailFormVertical)
            ? @"StraightRail.png" : @"";

    CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: filename];
    if(!texture) return nil;

    CGRect rect = CGRectZero;
    if(railForm == crRailFormVertical) {
        rect.size.width = texture.contentSize.height;
        rect.size.height = texture.contentSize.width;
    } else {
        rect.size = texture.contentSize;
    }

    return [sprite initWithTexture:texture rect:rect rotated:railForm == crRailFormVertical];
}


@end

