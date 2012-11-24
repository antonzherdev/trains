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
    [line addAngle:1 x:48 shift:ccp(4, 4)];
    [line addAngle:0.9 x:96 shift:ccp(2, 5)];
    [line addAngle:0.8 x:144 shift:ccp(3, 5)];
    [line addAngle:0.7 x:190 shift:ccp(1, 6)];
    [line addAngle:0.6 x:234 shift:ccp(1, 6)];
    [line addAngle:0.45 x:276 shift:ccp(2, 6)];
    [line addAngle:0.3 x:312 shift:ccp(2, 4)];
    [line addAngle:0.15 x:342 shift:ccp(1, 4)];
    [line addAngle:0 x:365 shift:ccp(0, 4)];
    [line addAngle:0.08 x:389 shift:ccp(0, 4)];
    [line addAngle:0.22 x:422 shift:ccp(1, 4)];

    if(self) {
        _type = type;
        self.anchorPoint = ccp(0.5, 0.5);
    }
    return self;
}
@end