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
            _length = 41;
            break;
        default:
            @throw @"Unknown car type";
    }
    self = [super initWithFile:file];
    CEOrtoSpriteLine *line = [self lineWithStartRect:CGRectMake(0, _height * color, _width, _height)];
    [line addAngle:1 shift:ccp(4, 4)];
    [line addAngle:0.6 shift:ccp(4, 4)];
    [line addAngle:0.45 shift:ccp(2, 4)];
    [line addAngle:0.3 shift:ccp(-2, 4)];
    [line addAngle:0.15 shift:ccp(0, 4)];
    [line addAngle:0 shift:ccp(0, 4)];

    if(self) {
        _type = type;
        self.anchorPoint = ccp(0.5, 0.5);
    }
    return self;
}
@end