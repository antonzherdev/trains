#import "CRTrain.h"
#import "CRRailroad.h"
#import "CRCar.h"
#import "CRLevel.h"
#import "CRCity.h"
#import "CRRailroad+CRRailPoint.h"
#import "NSMutableArray+CocoaEx.h"


@implementation CRTrain {
    CRRailroad *_railroad;
    CRCityColor _color;
    NSMutableArray* _cars;
    CRLevel *_level;

    CRRailVector _v1;
    CRRailVector _v2;

    CRDirection _moveDirection;
    CGFloat _speed;
    CGFloat _length;
}
@synthesize color = _color;
@synthesize speed = _speed;
@synthesize moveDirection = _moveDirection;


+ (id)trainWithLevel:(CRLevel *)level railroad:(CRRailroad *)railroad color:(CRCityColor)color {
    return [[[CRTrain alloc] initWithLevel:level railroad:railroad color:color] autorelease];
}

- (id)initWithLevel:(CRLevel *)level railroad:(CRRailroad *)railroad color:(CRCityColor)color {
    self = [super init];
    if(self) {
        _speed = 30;
        _length = 0;
        _level = level;
        _railroad = railroad;
        _moveDirection = crForward;
        _color = color;
        _cars = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setParent:(CCNode *)parent {
    parent_ = parent;
    self.contentSize = parent.contentSize;
}


- (void)addCarWithType:(CRCarType)type {
    CRCar *car = [CRCar carWithType:type color:_color];
    [_cars addObject:car];
    _length += car.length;
    [self addChild:car];
}

- (void)dealloc {
    [_cars release];
    [super dealloc];
}

- (void)startFromCityWithColor:(CRCityColor)color {
    CRCity * city = [_railroad cityForColor:color];
    _v1 = [city startRailVectorForRailroad:_railroad];
    _moveDirection = crForward;
    [self updatePosition];
    [self scheduleUpdate];
}

- (void)updatePosition {
    CRRailVector v = _v1;
    CGPoint point = [_railroad calculateRailPoint:v.railPoint];
    int z = 100;
    CGFloat error = 0;
    CGFloat prevY = 0;
    for(CRCar * car in _cars) {
        CGPoint start;
        start = point;
        CRMoveRailPointResult moveResult;
        moveResult = [_railroad moveRailPoint:v.railPoint length:car.length * -v.direction];
        error = moveResult.error;
        v.direction = -moveResult.direction;
        v.railPoint = moveResult.railPoint;
        point = [_railroad calculateRailPoint:v.railPoint];
        if(error == 0) [car setStart:start end:point];

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

    CGFloat length = _moveDirection * _speed * deltaTime;
    [self move:length];
}

- (void)move:(CGFloat)length {
    if(fabs(length) < FLT_EPSILON) return;

    self.moveDirection = length < 0 ? crBackward : crForward;
    CRMoveRailPointResult result = [_railroad moveRailPoint:_v1.railPoint length:ABS(length) * _v1.direction];
    while (1) {
        _v1.railPoint = result.railPoint;
        _v1.direction = result.direction;
        [self updatePosition];
        if(result.error < FLT_EPSILON) return;

        self.moveDirection = -_moveDirection;
        result = [_railroad moveRailPoint:_v1.railPoint length:result.error * _v1.direction];
    }
}

- (void)setMoveDirection:(CRDirection)moveDirection {
    if(_moveDirection == moveDirection) return;
    _moveDirection = moveDirection;
    CC_SWAP(_v1, _v2);
    [_cars revert];
}


@end