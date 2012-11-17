#import "CRCar.h"


@implementation CRCar {
    CRCarType _type;
    int _width;
    int _height;
    CGFloat _length;
}
@synthesize length = _length;


+ (id)carWithType:(CRCarType)type color:(CRCityColor)color {
    return [[[CRCar alloc] initWithType:type color:color] autorelease];
}

- (id)initWithType:(CRCarType)type color:(CRCityColor)color {
    NSString *file;
    switch(type) {
        case crCarType1:
            file = @"Car1.png";
            _width = 48;
            _height = 40;
            _length = 40;
            self.shift = ccp(5, 5);
            break;
        default:
            @throw @"Unknown car type";
    }
    self = [super initWithFile:file rect:CGRectMake(0, _height *color, _width, _height)];
    [self addAngle:23./18 rect:CGRectMake(_width, _height*color, _width, _height)];
    if(self) {
        _type = type;
        self.anchorPoint = ccp(0.5, 0.5);
    }
    return self;
}
@end