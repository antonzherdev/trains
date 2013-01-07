#import "CRCity.h"
#import "CRRailroad.h"


@implementation CRCity {
    CRCityColor* _cityColor;
    CRCityOrientation _orientation;
    CEIPoint _tile;
}
@synthesize cityColor = _cityColor;
@synthesize tile = _tile;


+ (id)cityWithColor:(CRCityColor*)color orientation:(CRCityOrientation)orientation tile:(CEIPoint)tile {
    return [[[CRCity alloc] initWithColor:color orientation:orientation tile:tile] autorelease];
}

- (id)initWithColor:(CRCityColor*)color orientation:(CRCityOrientation)orientation tile:(CEIPoint)tile {
    CGRect rect;
    if(color == crOrange) {
        rect = CGRectMake(0, 0, 220, 110);
    } else if(color == crGreen) {
        rect = CGRectMake(220, 0, 220, 110);
    } else {
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

+ (CRDirection)directionForCityInTile:(CEIPoint)tile form:(CRRailForm*)form railroad:(CRRailroad *)railroad {
    if(tile.x + tile.y == 0) return crForward;
    if(tile.y - tile.x == 1) return form == crRailFormX ? crBackward : crForward;
    if(tile.y + tile.x == railroad.dim.size.width - 1) return crBackward;
    return form == crRailFormX ? crForward : crBackward;
}

- (CRRailForm*)form {
    return (_orientation == crCityOrientationX ? crRailFormX : crRailFormY);
}

- (CRRailType)railType {
    return crRailTypeCity;
}


- (CRRailVector)startRailVectorForRailroad:(CRRailroad *)railroad {
    CRRailVector v;
    v.railPoint.tile = _tile;
    v.railPoint.form = [self form];
    v.railPoint.type = crRailTypeCity;
    v.direction = [CRCity directionForCityInTile:_tile form:v.railPoint.form railroad:railroad];
    v.railPoint.x = v.direction == crForward ? 0 : 1.0;

    return v;
}
@end