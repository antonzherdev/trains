#import "CRLevel.h"
#import "CETextureBackgroundLayer.h"
#import "CRRailroadView.h"
#import "CRTrain.h"
#import "CRCity.h"
#import "CRRailroad.h"


@interface CRLevel () <CRTrainDelegate>
@end

@implementation CRLevel {
    CRRailroadView *_railroad;
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
    _railroad = [CRRailroadView railroadForDim:dim];
    
    _railroad.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
    _railroad.anchorPoint = ccp(0.5, 0.5);

    [_railroad.ctrl atomic:^{
        CRRailroad *ctrl = _railroad.ctrl;

        [ctrl addRailWithForm:crRailFormX tile:cei(0, 8)];
        [ctrl addRailWithForm:crRailFormX tile:cei(1, 8)];
        [ctrl addRailWithForm:crRailFormX tile:cei(2, 8)];
        [ctrl addRailWithForm:crRailFormTurn_X_Y tile:cei(3, 8)];
        [ctrl addRailWithForm:crRailFormY tile:cei(3, 7)];
        [ctrl addRailWithForm:crRailFormTurn_XY tile:cei(3, 6)];
        [ctrl addRailWithForm:crRailFormX tile:cei(2, 6)];
        [ctrl addRailWithForm:crRailFormX tile:cei(1, 6)];
        [ctrl addRailWithForm:crRailFormX tile:cei(0, 6)];
        [ctrl addRailWithForm:crRailFormTurnXY tile:cei(-1, 6)];
        [ctrl addRailWithForm:crRailFormY tile:cei(-1, 7)];
        [ctrl addRailWithForm:crRailFormTurnX_Y tile:cei(-1, 8)];

        [ctrl addCity:[CRCity cityWithColor:crOrange orientation:crCityOrientationX tile:cei(-6, 6)]];
        [ctrl addRailWithForm:crRailFormX tile:cei(-5, 6)];

        [ctrl addCity:[CRCity cityWithColor:crGreen orientation:crCityOrientationY tile:cei(1, 12)]];
        [ctrl addRailWithForm:crRailFormX tile:cei(0, 12)];
    }];
    
    [self addChild:_railroad];

    _trainsLayer = [CCNode node];
    _trainsLayer.contentSize = _railroad.contentSize;
    [_railroad addChild:_trainsLayer];

    _train = [CRTrain trainWithRailroad:_railroad.ctrl color:crGreen];
//    _train.speed = 0;
    [_train addCarWithType:crCarType1];
    [_train addCarWithType:crCarType1];
    [self addTrain:_train];
    [_train startFromCityWithColor:crOrange];

    _train = [CRTrain trainWithRailroad:_railroad.ctrl color:crOrange];
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
