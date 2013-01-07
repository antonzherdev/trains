#import "CRRailForm.h"

CRRailForm * crRailFormX = nil;
CRRailForm * crRailFormY = nil;
CRRailForm * crRailFormTurnX_Y = nil;
CRRailForm * crRailFormTurnXY = nil;
CRRailForm * crRailFormTurn_XY = nil;
CRRailForm * crRailFormTurn_X_Y = nil;

@implementation CRRailForm {

}


- (id)initWithName:(NSString *)name length:(CGFloat)length v1:(CRDirectionVector)v1 v2:(CRDirectionVector)v2 {
    self = [super initWithName:name];
    if (self) {
        _length = length;
        _v1 = v1;
        _v2 = v2;
    }

    return self;
}

+ (void)load {
    crRailFormX = [[CRRailForm alloc] initWithName:@"x" length:1.12 v1:dirVec(crBackward, crNilDirection) v2:dirVec(crForward, crNilDirection)];
    crRailFormY = [[CRRailForm alloc] initWithName:@"y" length:1.12 v1:dirVec(crNilDirection, crBackward) v2:dirVec(crNilDirection, crForward)];
    crRailFormTurnXY = [[CRRailForm alloc] initWithName:@"+x+y" length:0.9 v1:dirVec(crForward, crNilDirection) v2:dirVec(crNilDirection, crForward)];
    crRailFormTurn_X_Y = [[CRRailForm alloc] initWithName:@"-x-y" length:0.9 v1:dirVec(crBackward, crNilDirection) v2:dirVec(crNilDirection, crBackward)];
    crRailFormTurnX_Y = [[CRRailForm alloc] initWithName:@"+x-y" length:0.9 v1:dirVec(crForward, crNilDirection) v2:dirVec(crNilDirection, crBackward)];
    crRailFormTurn_XY = [[CRRailForm alloc] initWithName:@"-x+y" length:0.82 v1:dirVec(crBackward, crNilDirection) v2:dirVec(crNilDirection, crForward)];
}

- (CEIPoint)nextTilePoint:(CEIPoint)point direction:(CRDirection)direction {
    if(direction == crBackward) {
        point.x += _v1.x;
        point.y += _v1.y;
    } else {
        point.x += _v2.x;
        point.y += _v2.y;
    }
    return point;
}

- (BOOL)couldBeNextForm:(CRRailForm *)form direction:(CRDirection)direction {
    CRDirectionVector v = direction == crBackward ? _v1 : _v2;
    return (form.v1.x == -v.x && form.v1.y == -v.y) || (form.v2.x == -v.x && form.v2.y == -v.y);
}

- (BOOL)shouldInvertDirectionForNextForm:(CRRailForm *)form direction:(CRDirection)direction {
    CRDirectionVector v = direction == crBackward ? _v1 : _v2;
    if(form.v1.x == -v.x && form.v1.y == -v.y) {
        return direction == crBackward;
    }
    return direction == crForward;
}
@end