#import "CRRailroadView.h"
#import "CRRailroadBuilder.h"
#import "CRCity.h"
#import "CRRail.h"
#import "CRRailroad.h"
#import "CRSwitch.h"
#import "CRSwitchView.h"

@implementation CRRailroadView {
    CRRailroadBuilder *_builder;
    CRRailroad * _ctrl;
}
@synthesize ctrl = _ctrl;


+ (CRRailroadView *)railroadForDim:(CEOrtoMapDim)dim {
    return [[[CRRailroadView alloc] initWithDim:dim] autorelease];
}


- (id)initWithDim:(CEOrtoMapDim)dim {
    self = [super initWithDim:dim];
    if (self) {
        _ctrl = [[CRRailroad ctrlWithView:self dim:dim] retain];
        _railsLayer = [self addLayer];
        _switchLayer = [self addLayer];
        _switchLayer.zOrder = 100;
        _builder = [CRRailroadBuilder builderForRailroad:_ctrl];
        [self addLayerWithNode:_builder];

//       self.drawMesh = YES;
    }

    return self;
}

- (void)updatedCtrl:(CECtrl *)ctrl {
    [_railsLayer clear];
    [_switchLayer clear];

    for(CRCity *city in _ctrl.cities) {
        [_railsLayer addChild:[self createSpriteForCity:city] tile:city.tile];
    }
    for(CRRail *rail in _ctrl.rails) {
        [_railsLayer addChild:[self createSpriteForRail:rail] tile:rail.tile];
    }
    for(CRSwitch *aSwitch in _ctrl.switches) {
        [_switchLayer addChild:[CRSwitchView viewWithCtrl:aSwitch] tile:aSwitch.tile];
    }
}



- (CCNode *)createSpriteForRail:(CRRail *)rail {
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"rails_rails.plist"];
    return [CCSprite spriteWithSpriteFrameName:rail.form.name];
}

- (CCSprite *)createSpriteForCity:(CRCity *)city {
    CGRect rect;
    CRCityColor *color = city.cityColor;
    if(color == crOrange) {
        rect = CGRectMake(0, 0, 220, 110);
    } else if(color == crGreen) {
        rect = CGRectMake(220, 0, 220, 110);
    } else {
        @throw @"Unknown city color";
    }
    return [CCSprite spriteWithFile:@"City.png" rect:rect];
}

- (void)dealloc {
    [_ctrl release];
    [super dealloc];
}

@end