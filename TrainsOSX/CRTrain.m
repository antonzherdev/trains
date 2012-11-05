#import "CRTrain.h"
#import "CRRailroad.h"
#import "CRCar.h"
#import "CRLevel.h"
#import "CRCity.h"
#import "CRRail.h"


@implementation CRTrain {
    CRRailroad *_railroad;
    CRCityColor _color;
    NSMutableArray* _cars;
    CRLevel *_level;

    CRRailPoint _railPoint;

    CRDirection _orientation;
    CRDirection _moveDirection;
}
@synthesize color = _color;


+ (id)trainWithLevel:(CRLevel *)level railroad:(CRRailroad *)railroad color:(CRCityColor)color {
    return [[[CRTrain alloc] initWithLevel:level railroad:railroad color:color] autorelease];
}

- (id)initWithLevel:(CRLevel *)level railroad:(CRRailroad *)railroad color:(CRCityColor)color {
    self = [super init];
    if(self) {
        _level = level;
        _railroad = railroad;
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
}

- (void)updatePosition {
    CRRailPoint railPoint = _railPoint;
    CGPoint point = [CRRail calculateRailPoint:_railPoint railroad:_railroad];
    for(CRCar * car in _cars) {
        CGPoint start = point;
        CRMoveRailPointResult moveResult = [_railroad moveRailPoint:railPoint length:car.length * _orientation];
        point = [CRRail calculateRailPoint:moveResult.railPoint railroad:_railroad];
        [car setStart:start end:point];
    }
}
@end