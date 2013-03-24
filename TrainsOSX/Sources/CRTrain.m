#import "CRTrain.h"
#import "CRCar.h"
#import "CRCity.h"
#import "NSMutableArray+CocoaEx.h"
#import "CRRailroad.h"


@implementation CRTrain {
    CRRailroad *_railroad;
    CRCityColor* _color;
    NSMutableArray* _cars;

    CRRailVector _v1;
    CRRailVector _v2;

    CGFloat _speed;
    CGFloat _length;
    CGFloat _cityError;
    CRDirection _cityDirection;
}
@synthesize color = _color;
@synthesize speed = _speed;
@synthesize delegate;


+ (id)trainWithRailroad:(CRRailroad *)railroad color:(CRCityColor *)color {
    return [[[CRTrain alloc] initWithRailroad:railroad color:color] autorelease];
}

- (id)initWithRailroad:(CRRailroad *)railroad color:(CRCityColor *)color {
    self = [super init];
    if(self) {
        _speed = 30;
        _length = 0;
        _cityError = 0;
        _railroad = railroad;
        _color = color;
        _cars = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setParent:(CCNode *)parent {
    _parent = parent;
    self.contentSize = parent.contentSize;
}


- (void)addCarWithType:(CRCarType)type {
    CRCar *car = [CRCar carWithType:type color:_color];
    [self addCar:car];
}

- (void)addCar:(CRCar *)car {
    [_cars addObject:car];
    _length += car.length;
    [self addChild:car];
}

- (void)dealloc {
    [_cars release];
    [super dealloc];
}

- (void)startFromCityWithColor:(CRCityColor*)color {
    CRCity * city = [_railroad cityForColor:color];
    CRRailVector v = [city startRailVectorForRailroad:_railroad];
    [self startFromVector:v];
}

- (void)startFromVector:(CRRailVector)vector {
    _v1 = vector;
    [self updatePosition];
    [self scheduleUpdate];
}

//zTODO: Recreate with functional style
- (void)updatePosition {
    CRRailVector v = _v1;
    CGPoint point = [_railroad calculateRailPoint:v.railPoint];
    NSInteger z = [self zOrder];
    CGFloat error = 0;
    CGFloat prevY = 0;
    CGFloat cityError = _cityError;
    for(CRCar * car in _cars) {
        CGPoint start;
        start = point;
        if(cityError >= car.length) {
            cityError -= car.length;
            continue;
        }
        CRMoveRailPointResult moveResult;
        moveResult = [_railroad moveRailPoint:v.railPoint length:(car.length - cityError) * -v.direction];
        error = moveResult.error;
        v.direction = -moveResult.direction;
        v.railPoint = moveResult.railPoint;
        point = [_railroad calculateRailPoint:v.railPoint];
        if(cityError > 0) {
            [car setVisible:NO];
            cityError = 0;
        } else if(error == 0) {
            [car setVisible:YES];
            [car setStart:start end:point];
        } else {
            [car setVisible:NO];
        }

        if(car.position.y > prevY) z--;
        else z++;
        prevY = car.position.y;
        car.zOrder = z;
    }
    _v2 = v;
    _v2.direction = -v.direction;
}

-(void) update:(ccTime)deltaTime
{
    if(_speed == 0) return;

    [self move:_speed * deltaTime];
}

//zTODO: Recreate with functional style
- (void)move:(CGFloat)length {
    if(length < FLT_EPSILON) return;

    if(_cityError > FLT_EPSILON) {
        if(_cityDirection == _v1.direction) {
            _cityError -= length;
            if(_cityError < FLT_EPSILON) {
                _cityError = 0;
                length = -_cityError;
                if(length < FLT_EPSILON) {
                    [self updatePosition];
                    return;
                }
            } else {
                [self updatePosition];
                return;
            }
        } else {
            _cityError += length;
            if (_cityError >= _length) {
                [delegate train:self arrivedToCity:[_railroad cityInTile:_v1.railPoint.tile]];
                [self invertMoveDirection];
            }
            [self updatePosition];
            return;
        }
    }
    CRMoveRailPointResult result = [_railroad moveRailPoint:_v1.railPoint length:length * _v1.direction];
    while (1) {
        _v1.railPoint = result.railPoint;
        _v1.direction = result.direction;
        [self updatePosition];
        if(result.error < FLT_EPSILON) return;

        if(result.railPoint.type == crRailTypeCity) {
            _cityDirection = [CRCity directionForCityInTile:result.railPoint.tile form:result.railPoint.form railroad:_railroad];
            if(_cityDirection != _v1.direction) {
                _cityError = result.error;
                [delegate train:self goingToCity:[_railroad cityInTile:result.railPoint.tile]];
                [self updatePosition];
                return;
            }
        }

        [self invertMoveDirection];
        result = [_railroad moveRailPoint:_v1.railPoint length:result.error * _v1.direction];
    }
}

- (void)invertMoveDirection {
    CC_SWAP(_v1, _v2);
    [_cars revert];
}

@end