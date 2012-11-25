#import "CRTrain.h"
#import "CRRailroad.h"
#import "CRCar.h"
#import "CRLevel.h"
#import "CRCity.h"
#import "CRRailroad+CRRailPoint.h"


@implementation CRTrain {
    CRRailroad *_railroad;
    CRCityColor _color;
    NSMutableArray* _cars;
    CRLevel *_level;

    CRRailPoint _railPoint;

    CRDirection _orientation;
    CRDirection _moveDirection;
    CGFloat _speed;
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
    [self addChild:car];
}

- (void)dealloc {
    [_cars release];
    [super dealloc];
}

- (void)startFromCityWithColor:(CRCityColor)color {
    CRCity * city = [_railroad cityForColor:color];
    _railPoint = [city startRailPoint];
    _orientation = [city startTrainOrientation];
    _moveDirection = crForward;
    [self updatePosition];
    [self scheduleUpdate];
}

- (CGFloat)updatePosition {
    CRRailPoint railPoint = _railPoint;
    CGPoint point = [_railroad calculateRailPoint:railPoint];
    CRDirection orientation = _orientation;
    int z = 100;
    CGFloat error = 0;
    CGFloat prevY = 0;
    for(CRCar * car in _cars) {
        CGPoint start;
        start = point;
        CRMoveRailPointResult moveResult;
        moveResult = [_railroad moveRailPoint:railPoint length:car.length * -orientation];
        error = moveResult.error;
        orientation = -moveResult.direction;
        railPoint = moveResult.railPoint;
        point = [_railroad calculateRailPoint:railPoint];
        if(error == 0) [car setStart:start end:point];

        if(car.position.y > prevY) z--;
        else z++;
        prevY = car.position.y;
        car.zOrder = z;
    }
    return error;
}

-(void) update:(ccTime)deltaTime
{
    if(_speed == 0) return;

    CGFloat length = _moveDirection * _speed * deltaTime;
    [self move:length];
}

- (void)move:(CGFloat)length {
    if(fabs(length) < FLT_EPSILON) return;

    _moveDirection = length < 0 ? crBackward : crForward;
    CRMoveRailPointResult result = [_railroad moveRailPoint:_railPoint length:length * _orientation];
    while (result.error > FLT_EPSILON) {
        self.moveDirection = -_moveDirection;
        result = [_railroad moveRailPoint:_railPoint length:result.error * _moveDirection * _orientation];
    }
    _orientation = _moveDirection * result.direction;
    _railPoint = result.railPoint;

    if(_moveDirection == crBackward) {
        CGFloat error;
        while((error = [self updatePosition]) > FLT_EPSILON) {
            self.moveDirection = -_moveDirection;
            [self move:error];
        }
    } else {
        [self updatePosition];
    }
}


@end