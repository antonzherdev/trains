#import "CRCity.h"


@implementation CRCity {
    CRCityColor _cityColor;
    CRCityOrientation _orientation;
    CEIPoint _tile;
}
@synthesize cityColor = _cityColor;
@synthesize tile = _tile;


+ (id)cityWithColor:(CRCityColor)color orientation:(CRCityOrientation)orientation tile:(CEIPoint)tile {
    return [[[CRCity alloc] initWithColor:color orientation:orientation tile:tile] autorelease];
}

- (id)initWithColor:(CRCityColor)color orientation:(CRCityOrientation)orientation tile:(CEIPoint)tile {
    CGRect rect;
    switch(color) {
        case crOrange:
            rect = CGRectMake(0, 0, 220, 110);
            break;
        case crGreen:
            rect = CGRectMake(220, 0, 220, 110);
            break;
        default:
            @throw @"Unknown city color";
    }
    self = [super initWithFile:@"City.png" rect:rect];
    if(self) {
        _cityColor = color;
        _orientation = orientation;
        _tile = tile;
        if(orientation == crCityOrientationY) {
            [self setFlipX:YES];
        }
    }
    return self;
}

- (CRRailPoint)startRailPoint {
    CRRailPoint result;
    result.tile = _tile;
    result.form = _orientation == crCityOrientationX ? crRailFormX : crRailFormY;
    result.x = (_tile.x + _tile.y == 0) || (_tile.y - _tile.x) == 0 ? 0 : 1.0;

    return result;
}

- (CRDirection)startTrainOrientation {
    return (_tile.x + _tile.y == 0) || (_tile.y - _tile.x) == 0 ? crForward : crBackward;
}

- (CRRailForm)form {
    return (_orientation == crCityOrientationX ? crRailFormX : crRailFormY);
}

@end