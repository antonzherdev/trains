#import <Foundation/Foundation.h>

struct CETile {
    int x;
    int y;
};
typedef struct CETile CETile;

CG_INLINE CETile
ceTile(int x, int y)
{
    CETile p; p.x = x; p.y = y; return p;
}

CG_INLINE BOOL
ceTileEq(const CETile a, const CETile b)
{
    return a.x == b.x && a.y == b.y;
}

struct CEMapSize {
    int width;
    int height;
};
typedef struct CEMapSize CEMapSize;

CG_INLINE CEMapSize
ceMapSize(int width, int height)
{
    CEMapSize p; p.width = width; p.height = height; return p;
}


@interface CETileIndex : NSObject
@property(nonatomic, readonly) CEMapSize size;

+ (id) tileIndexWithSize:(CEMapSize) size;
+ (id)tileIndexForOrtoMapWithSize:(CEMapSize) size;

- (id)initWithSize:(CEMapSize)size tileIndexBlock:(NSUInteger (^)(CEMapSize, CETile))block;

-(void) addObject:(id)object toTile:(CETile) tile;
-(NSArray*)objectsAtTile:(CETile) tile;

@end