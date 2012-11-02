#import "CRCity.h"


@implementation CRCity {
    CRCityColor _cityColor;
}
@synthesize cityColor = _cityColor;

+ (id)cityWithColor:(CRCityColor)color {
    return [[[CRCity alloc] initWithColor:color] autorelease];
}

- (id)initWithColor:(CRCityColor)color {
    CGRect rect;
    switch(color) {
        case crOrangeCity:
            rect = CGRectMake(0, 0, 220, 110);
            break;
        case crGreenCity:
            rect = CGRectMake(220, 0, 220, 110);
            break;
        default:
            @throw @"Unknown city color";
    }
    self = [super initWithFile:@"City.png" rect:rect];
    if(self) {
        _cityColor = color;
    }
    return self;
}

@end