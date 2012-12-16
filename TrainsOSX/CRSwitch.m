#import "CRSwitch.h"


@implementation CRSwitch {
    CRRailForm _form1;
    CRRailForm _form2;
    CCSprite *_sprite;
    BOOL _composite;
}

@synthesize form1 = _form1;
@synthesize form2 = _form2;

- (id)initWithForm1:(CRRailForm)form1 form2:(CRRailForm)form2 {
    self = [super init];
    if (self) {
        _form1 = form1;
        _form2 = form2;
    }

    return self;
}

- (void)onEnter {
    [super onEnter];
    [_sprite removeFromParentAndCleanup:YES];

    if(_composite) return;

    CGFloat x;
    CGFloat y = 110;
    BOOL flipX = NO;
    if(_form1 == crRailFormX && _form2 == crRailFormTurn_X_Y) {
        x = 0;
    } else if(_form1 == crRailFormY && _form2 == crRailFormTurnXY) {
        x = 0;
        flipX = YES;
    } else if(_form1 == crRailFormX && _form2 == crRailFormTurnXY) {
        x = 220;
    }else if(_form1 == crRailFormY && _form2 == crRailFormTurn_X_Y) {
        x = 220;
        flipX = YES;
    } else if(_form1 == crRailFormX && _form2 == crRailFormTurn_XY) {
        x = 440;
    } else if(_form1 == crRailFormX && _form2 == crRailFormTurnX_Y) {
        x = 660;
    } else if(_form1 == crRailFormX && _form2 == crRailFormY) {
        x = 880;
    } else {
        @throw @"Incorrect forms";
    }

    CGRect rect = CGRectMake(x, y, 220, 110);
    _sprite = [CCSprite spriteWithFile:@"Rails.png" rect:rect];
    if(flipX) [_sprite setFlipX:YES];
    [self addChild:_sprite];
}


+ (id)switchWithForm1:(CRRailForm)form1 form2:(CRRailForm)form2 {
    if((form1 == crRailFormTurn_X_Y && form2 == crRailFormTurnXY) ||
            (form1 == crRailFormTurn_XY && form2 == crRailFormTurnX_Y)) return nil;
    return [[[CRSwitch alloc] initWithForm1:form1 form2:form2] autorelease];
}

- (void)onExit {
    [super onExit];
    [_sprite removeFromParentAndCleanup:YES];
    _sprite = nil;
}


- (void)composite {
    _composite = YES;
    [_sprite removeFromParentAndCleanup:YES];
    _sprite = nil;
}

@end