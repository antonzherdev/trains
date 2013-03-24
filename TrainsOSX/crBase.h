#import "cocos2d-ex.h"


typedef enum {
    crForward = 1,
    crNilDirection = 0,
    crBackward = -1
} CRDirection;

struct CRDirectionVector {
    CRDirection x;
    CRDirection y;
};
typedef struct CRDirectionVector CRDirectionVector;

CG_INLINE CRDirection crDirection(CGFloat vec) {
    return vec > 0 ? crForward : (vec == 0 ? crNilDirection : crBackward);
}

CG_INLINE CRDirectionVector crDirVec(const CRDirection x, const CRDirection y) {
    CRDirectionVector ret; ret.x = x; ret.y = y;
    return ret;
}

CG_INLINE bool crDirVecEq(CRDirectionVector v1, CRDirectionVector v2) {
    return v1.x == v2.x && v1.y == v2.y;
}

CG_INLINE CRDirectionVector crDirVecInvert(CRDirectionVector v) {
    return crDirVec(-v.x, -v.y);
}