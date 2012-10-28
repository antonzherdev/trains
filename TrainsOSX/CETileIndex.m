#import "CETileIndex.h"


@implementation CETileIndex {
    CEMapSize _size;
    NSMutableArray *_index;
    NSUInteger (^_block)(CEMapSize, CETile);

}
@synthesize size = _size;

+ (id)tileIndexWithSize:(CEMapSize)size {
    return [[[CETileIndex alloc] initWithSize:size tileIndexBlock:^(CEMapSize size_, CETile tile) {
        return (NSUInteger) (size_.width*tile.y + tile.x);
    }] autorelease];
}

+ (id)tileIndexForOrtoMapWithSize:(CEMapSize)size {
    return [[[CETileIndex alloc] initWithSize:size tileIndexBlock:^(CEMapSize size_, CETile tile) {
        return (NSUInteger) (size_.width*(tile.y - tile.x - 1) + (tile.x + tile.y));
    }] autorelease];
}


- (id)initWithSize:(CEMapSize)size tileIndexBlock:(NSUInteger (^)(CEMapSize, CETile))block {
    self = [super init];
    if(self) {
        _size = size;
        _block = block;
        NSUInteger n = (NSUInteger) (size.width * size.height);
        _index = [[NSMutableArray alloc] initWithCapacity:n];
        for(int i = 0; i < n; i++) {
            [_index addObject:[NSMutableArray array]];
        }
    }
    return self;
}

- (void)addObject:(id)object toTile:(CETile)tile {
    NSMutableArray * array = (NSMutableArray *) [self objectsAtTile:tile];
    [array addObject:object];
}

- (NSArray *)objectsAtTile:(CETile)tile {
    return [_index objectAtIndex:_block(_size, tile)];
}

- (void)dealloc {
    [_index release];
    [super dealloc];
}


@end