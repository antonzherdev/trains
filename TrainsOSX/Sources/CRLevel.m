#import "CRLevel.h"
#import "CETextureBackgroundLayer.h"
#import "CRRailroad.h"
#import "CRTrain.h"
#import "CRCity.h"


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
