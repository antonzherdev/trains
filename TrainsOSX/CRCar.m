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
    [line addAngleTn:1 x:48 shift:ccp(4, 4)];
    [line addAngleTn:0.9 x:96 shift:ccp(2, 5)];
    [line addAngleTn:0.8 x:144 shift:ccp(3, 5)];
    [line addAngleTn:0.7 x:190 shift:ccp(1, 6)];
    [line addAngleTn:0.6 x:234 shift:ccp(1, 6)];
    [line addAngleTn:0.45 x:276 shift:ccp(2, 6)];
    [line addAngleTn:0.3 x:312 shift:ccp(2, 4)];
    [line addAngleTn:0.15 x:342 shift:ccp(1, 4)];
    [line addAngleTn:0 x:365 shift:ccp(0, 4)];
    [line addAngleTn:0.08 x:389 shift:ccp(0, 4)];
    [line addAngleTn:0.22 x:422 shift:ccp(1, 4)];
    [line addAngleTn:0.37 x:458 shift:ccp(2, 6)];
    [line addAngleTn:0.52 x:498 shift:ccp(1, 6)];
    [line addAngleTn:0.95 x:546 shift:ccp(2, 5)];

    [line addAngleAtn:0 x:600 shift:ccp(2, 5)];
    [line addAngleAtn:0.9 x:653 shift:ccp(2, 4)];
    [line addAngleAtn:0.8 x:706 shift:ccp(2, 4)];
    [line addAngleAtn:0.7 x:760 shift:ccp(2, 4)];
    [line addAngleAtn:0.6 x:815 shift:ccp(2, 4)];
    [line addAngleAtn:0.5 x:870 shift:ccp(2, 4)];
    [line addAngleAtn:0.4 x:928 shift:ccp(2, 4)];
    [line addAngleAtn:0.3 x:984 shift:ccp(2, 5)];
    [line addAngleAtn:0.2 x:1039 shift:ccp(2, 5)];
    [line addAngleAtn:0.1 x:1094 shift:ccp(2, 6)];

    if(self) {
        _type = type;
        self.anchorPoint = ccp(0.5, 0.5);
    }
    return self;
}
@end