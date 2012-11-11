#import "cocos2d-ex.h"


CGPoint ceBezierPoint(const CEBezier b, CGFloat t) {
    if(t == 0) return b.p0;
    if(t == 1) {
        switch (b.level) {
            case 1:
                return b.p1;
            case 2:
                return b.p2;
            case 3:
                return b.p3;
            default:
                @throw @"Invalid points count";
        }
    }

    switch (b.level) {
        case 1:
            return ccpLerp(b.p0, b.p1, (float)t);
        case 2:
            return cepAdd3(ccpMult(b.p0, pow(1 - t, 2)), ccpMult(b.p1, 2*t*(1 - t)), ccpMult(b.p2, pow(t, 2)));
        case 3:
            return cepAdd4(ccpMult(b.p0, pow(1 - t, 3)), ccpMult(b.p1, 3*t*pow(1 - t, 2)),
                    ccpMult(b.p2, 3*pow(t, 2)*(1 - t)), ccpMult(b.p3, pow(t, 3)));
        default:
            @throw @"Invalid points count";
    }
}

