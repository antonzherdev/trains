#import <cocos2d/CCSprite.h>
#import "CRSwitchView.h"
#import "CRSwitch.h"


@implementation CRSwitchView {
    CCSprite *_sprite;
    BOOL _composite;
    CCSprite *_stateSprite;
    CRSwitch *_ctrl;
}
@synthesize ctrl = _ctrl;

- (id)initWithCtrl:(CRSwitch *)ctrl {
    self = [super init];
    if (self) {
        _ctrl = [ctrl retain];
    }

    return self;
}

+ (id)viewWithCtrl:(CRSwitch *)ctrl {
    return [[[self alloc] initWithCtrl:ctrl] autorelease];
}


- (void)onEnter {
    [super onEnter];

    if(!_composite) {
        CGFloat x;
        CGFloat y = 110;
        BOOL flipX = NO;
        CRRailForm *form1 = _ctrl.form1;
        CRRailForm *form2 = _ctrl.form2;
        if(form1 == crRailFormX && form2 == crRailFormTurn_X_Y) {
            x = 0;
        } else if(form1 == crRailFormY && form2 == crRailFormTurnXY) {
            x = 0;
            flipX = YES;
        } else if(form1 == crRailFormX && form2 == crRailFormTurnXY) {
            x = 220;
        }else if(form1 == crRailFormY && form2 == crRailFormTurn_X_Y) {
            x = 220;
            flipX = YES;
        } else if(form1 == crRailFormX && form2 == crRailFormTurn_XY) {
            x = 440;
        } else if(form1 == crRailFormX && form2 == crRailFormTurnX_Y) {
            x = 660;
        } else if(form1 == crRailFormX && form2 == crRailFormY) {
            x = 880;
        } else {
            @throw @"Incorrect forms";
        }

        CGRect rect = CGRectMake(x, y, 220, 110);
        _sprite = [CCSprite spriteWithFile:@"Rails.png" rect:rect];
        if(flipX) [_sprite setFlipX:YES];
        [self addChild:_sprite];
    }

    [self updateStateSprite];
}

- (void)updateStateSprite {
    CRRailForm *form1 = _ctrl.form1;
    CRRailForm *form2 = _ctrl.form2;
    int state = _ctrl.state;
    if(form1 == crRailFormX && form2 == crRailFormY) return;

    [_stateSprite removeFromParentAndCleanup:YES];
    CRRailForm* form = state == 0 ? form1 : form2;
    CRRailForm* f2 = state == 0 ? form2 : form1;

    int y = 330;
    int x = 0;
    BOOL flipX;
    BOOL flipY;
    int px = 0;
    int py = 0;
    if(form == crRailFormX) {
        flipY = f2 == crRailFormTurnX_Y || f2 == crRailFormTurnXY;
        flipX = flipY;
        if(flipY) {px = 4; py = 1;}
    } else if (form == crRailFormY) {

        flipY = f2 == crRailFormTurnX_Y || f2 == crRailFormTurn_X_Y;
        flipX = !flipY;
        if(flipY) {px = -4; py = 1;}
    } else {
        return;
    }
    _stateSprite = [CCSprite spriteWithFile:@"Rails.png" rect:CGRectMake(x, y, 220, 110)];
    if(flipX) [_stateSprite setFlipX:YES];
    if(flipY) [_stateSprite setFlipY:YES];
    _stateSprite.position = ccp(px, py);
    [self addChild:_stateSprite];
}

- (void)onExit {
    [super onExit];
    [_sprite removeFromParentAndCleanup:YES];
    _sprite = nil;
    [_stateSprite removeFromParentAndCleanup:YES];
    _stateSprite = nil;
}


- (void)dealloc {
    [_ctrl release];
    [super dealloc];
}

@end