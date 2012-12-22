#import <Foundation/Foundation.h>
#import "cocos2d.h"

struct CEIPoint {
    int x;
    int y;
};
typedef struct CEIPoint CEIPoint;

CG_INLINE CEIPoint
cei(int x, int y)
{
    CEIPoint p; p.x = x; p.y = y; return p;
}

CG_INLINE BOOL
ceiEq(const CEIPoint a, const CEIPoint b)
{
    return a.x == b.x && a.y == b.y;
}

CG_INLINE int
ceiDistance(const CEIPoint a, const CEIPoint b)
{
   return abs(a.x - b.x) + abs(a.y - b.y);
}

CG_INLINE CEIPoint
ceiSub(const CEIPoint a, const CEIPoint b)
{
    return cei(a.x - b.x, a.y - b.y);
}

CG_INLINE CGPoint
cepMul(const CGPoint a, const CEIPoint b)
{
    return ccp(a.x*b.x, a.y*b.y);
}


struct CEISize {
    int width;
    int height;
};
typedef struct CEISize CEISize;

CG_INLINE CEISize
ceISize(int width, int height)
{
    CEISize p; p.width = width; p.height = height; return p;
}


@interface CETileIndex : NSObject
@property(nonatomic, readonly) CEISize size;

+ (id) tileIndexWithSize:(CEISize) size;
+ (id)tileIndexForOrtoMapWithSize:(CEISize) size;

- (id)initWithSize:(CEISize)size tileIndexBlock:(NSUInteger (^)(CEISize, CEIPoint))block;

-(void) addObject:(id)object toTile:(CEIPoint) tile;
-(NSArray*)objectsAtTile:(CEIPoint) tile;

- (void)removeObject:(CCNode *)node tile:(CEIPoint)tile;
@end