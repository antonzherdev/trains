#import "CRCityColor.h"


CRCityColor * crGreen = nil;
CRCityColor * crOrange = nil;

@implementation CRCityColor

+ (void)load {
    CE_ENUM(CRCityColor, Orange);
    CE_ENUM(CRCityColor, Green);
}


@end

