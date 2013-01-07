#import "CRCityColor.h"


CRCityColor * crGreen = nil;
CRCityColor * crOrange = nil;

@implementation CRCityColor

+ (void)load {
    crGreen = [[CRCityColor alloc] initWithName:@"Green"];
    crOrange = [[CRCityColor alloc] initWithName:@"Orange"];
}


@end

