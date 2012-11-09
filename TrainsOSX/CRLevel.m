#import "CRLevel.h"
#import "CETextureBackgroundLayer.h"
#import "CRRailroad.h"
#import "CRTrain.h"


@implementation CRLevel {
    CRRailroad *_railroad;
    CCNode *_trainsLayer;
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

    CRTrain *train = [CRTrain trainWithLevel:self railroad:_railroad color:crGreen];
    [train addCarWithType:crCarType1];
    [train addCarWithType:crCarType1];
    [train startFromCityWithColor:crOrange];
    [_trainsLayer addChild:train];

    return self;
}

@end
