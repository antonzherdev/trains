#import "CRCar.h"


@implementation CRCar {
    CRCarType _type;
    CGFloat _length;
}
@synthesize length = _length;


+ (id)carWithType:(CRCarType)type color:(CRCityColor*)color {
    return [[[CRCar alloc] initWithType:type color:color] autorelease];
}

- (id)initWithType:(CRCarType)type color:(CRCityColor*)color {
    NSString *file;
    switch(type) {
        case crCarType1:
            file = @"Car1";
            _length = 45;
            break;
        default:
            @throw @"Unknown car type";
    }
    NSString* name = [NSString stringWithFormat:@"%@_%@", file, color.name];
    self = [super initWithInfo:name frameName:name count:60];
    self.shift = ccp(6, 6);

    if(self) {
        _type = type;
        self.anchorPoint = ccp(0.5, 0.5);
    }
    return self;
}
@end