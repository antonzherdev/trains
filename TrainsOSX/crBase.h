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

CG_INLINE CRDirectionVector dirVec(const CRDirection x, const CRDirection y) {
    CRDirectionVector ret; ret.x = x; ret.y = y;
    return ret;
}
