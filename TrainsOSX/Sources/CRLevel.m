#import "CRLevel.h"
#import "CETextureBackgroundLayer.h"
#import "CRRailroad.h"
#import "CRTrain.h"
#import "CRCity.h"
#import "CRRail.h"


@interface CRLevel () <CRTrainDelegate>
@end

@implementation CRLevel {
    CRRailroad *_railroad;
    CCNode *_trainsLayer;
    CRTrain *_train;
}

+ (CRLevel *)level {
	return [[[CRLevel alloc] init] autorelease];
}

- (id)init {
    self = [super init];
    if (!self) return nil;

    CETextureBackgroundLayer *layer = [CETextureBackgroundLayer layerWithFile:@"Grass.png"];
    [self addChild: layer];

    CEOrtoMapDim dim;
    dim.tileHeight = 110;
    dim.size = ceISize(14, 17);
    _railroad = [CRRailroad railroadForDim:dim];
    _railroad.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
    _railroad.anchorPoint = ccp(0.5, 0.5);

    [_railroad addRail:[CRRail railWithForm:crRailFormX] tile:cei(0, 8)];
    [_railroad addRail:[CRRail railWithForm:crRailFormX] tile:cei(1, 8)];
    [_railroad addRail:[CRRail railWithForm:crRailFormX] tile:cei(2, 8)];
    [_railroad addRail:[CRRail railWithForm:crRailFormTurn_X_Y] tile:cei(3, 8)];
    [_railroad addRail:[CRRail railWithForm:crRailFormY] tile:cei(3, 7)];
    [_railroad addRail:[CRRail railWithForm:crRailFormTurn_XY] tile:cei(3, 6)];
    [_railroad addRail:[CRRail railWithForm:crRailFormX] tile:cei(2, 6)];
    [_railroad addRail:[CRRail railWithForm:crRailFormX] tile:cei(1, 6)];
    [_railroad addRail:[CRRail railWithForm:crRailFormX] tile:cei(0, 6)];
    [_railroad addRail:[CRRail railWithForm:crRailFormTurnXY] tile:cei(-1, 6)];
    [_railroad addRail:[CRRail railWithForm:crRailFormY] tile:cei(-1, 7)];
    [_railroad addRail:[CRRail railWithForm:crRailFormTurnX_Y] tile:cei(-1, 8)];

    [_railroad addCity:[CRCity cityWithColor:crOrange orientation:crCityOrientationX tile:cei(-6, 6)]];
    [_railroad addRail:[CRRail railWithForm:crRailFormX] tile:cei(-5, 6)];

    [_railroad addCity:[CRCity cityWithColor:crGreen orientation:crCityOrientationY tile:cei(1, 12)]];
    [_railroad addRail:[CRRail railWithForm:crRailFormX] tile:cei(0, 12)];
    [self addChild:_railroad];

    _trainsLayer = [CCNode node];
    _trainsLayer.contentSize = _railroad.contentSize;
    [_railroad addChild:_trainsLayer];

    _train = [CRTrain trainWithLevel:self railroad:_railroad color:crGreen];
//    _train.speed = 0;
    [_train addCarWithType:crCarType1];
    [_train addCarWithType:crCarType1];
    [self addTrain:_train];
    [_train startFromCityWithColor:crOrange];

    _train = [CRTrain trainWithLevel:self railroad:_railroad color:crOrange];
    [_train addCarWithType:crCarType1];
    [_train addCarWithType:crCarType1];
    [_train addCarWithType:crCarType1];
    [self addTrain:_train];
    [_train startFromCityWithColor:crGreen];


    [[[CCDirector sharedDirector] eventDispatcher] addKeyboardDelegate:self priority:0];

    return self;
}

- (void)addTrain:(CRTrain *)train {
    train.zOrder = 100;
    [_trainsLayer addChild:train];
    train.delegate = self;
}

- (BOOL)ccKeyDown:(NSEvent *)event {
    if([[event characters] isEqualToString:@"s"]) {
        if([[CCDirector sharedDirector] isPaused]) {
            [[CCDirector sharedDirector] resume];
        }  else {
            [[CCDirector sharedDirector] pause];
        }
    } else if([[event characters] isEqualToString:@"w"]) {
        _train.speed = 0;
        [_train move:10];
    } else if([[event characters] isEqualToString:@"q"]) {
        _train.speed = 0;
        [_train move:-10];
    } else if([[event characters] isEqualToString:@"r"]) {
        _train.speed = 0;
        [_train move:1];
    } else if([[event characters] isEqualToString:@"e"]) {
        _train.speed = 0;
        [_train move:-1];
    }
    return NO;
}

- (void)train:(CRTrain *)train goingToCity:(CRCity *)city {

}

- (void)train:(CRTrain *)train arrivedToCity:(CRCity *)city {
    if(city.cityColor == train.color) {
        [train removeFromParentAndCleanup:YES];
    }
}


@end
