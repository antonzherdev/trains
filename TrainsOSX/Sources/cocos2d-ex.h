#import "cocos2d.h"
#import "CCSprite+CESprite.h"
#import "CETileIndex.h"
#import "CEOrtoMap.h"
#import "CCNode+CENode.h"
#import "CECurve.h"
#import "CEBezier.h"
#import "CEOrtoSprite.h"

static inline CGPoint
cepAdd3(const CGPoint v1, const CGPoint v2, const CGPoint v3)
{
    return ccp(v1.x + v2.x + v3.x, v1.y + v2.y + v3.y);
}

static inline CGPoint
cepAdd4(const CGPoint v1, const CGPoint v2, const CGPoint v3, const CGPoint v4)
{
    return ccp(v1.x + v2.x + v3.x + v4.x, v1.y + v2.y + v3.y + v4.y);
}