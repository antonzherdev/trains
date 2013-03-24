#import "CRCity.h"
#import "CRRailroad.h"


@implementation CRCity {
    CRCityColor* _cityColor;
    CRCityOrientation _orientation;
    CEIPoint _tile;
}
@synthesize cityColor = _cityColor;
@synthesize tile = _tile;
@synthesize orientation = _orientation;


+ (id)cityWithColor:(CRCityColor*)color orientation:(CRCityOrientation)orientation tile:(CEIPoint)tile {
    return [[[CRCity alloc] initWithColor:color orientation:orientation tile:tile] autorelease];
}

- (id)initWithColor:(CRCityColor*)color orientation:(CRCityOrientation)orientation tile:(CEIPoint)tile {
    self = [super init];
    if(self) {
        _cityColor = color;
        _orientation = orientation;
        _tile = tile;
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
    return (self.orientation == crCityOrientationX ? crRailFormX : crRailFormY);
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