#import "CETileIndex.h"


@implementation CETileIndex {
    CEISize _size;
    NSMutableArray *_index;
    NSUInteger (^_block)(CEISize, CEIPoint);

}
@synthesize size = _size;

+ (id)tileIndexWithSize:(CEISize)size {
    return [[[CETileIndex alloc] initWithSize:size tileIndexBlock:^(CEISize size_, CEIPoint tile) {
        return (NSUInteger) (size_.width*tile.y + tile.x);
    }] autorelease];
}

+ (id)tileIndexForOrtoMapWithSize:(CEISize)size {
    return [[[CETileIndex alloc] initWithSize:size tileIndexBlock:^(CEISize size_, CEIPoint tile) {
        return (NSUInteger) (size_.width*(tile.y - tile.x - 1) + (tile.x + tile.y));
    }] autorelease];
}


- (id)initWithSize:(CEISize)size tileIndexBlock:(NSUInteger (^)(CEISize, CEIPoint))block {
    self = [super init];
    if(self) {
        _size = size;
        _block = [block copy];
        NSUInteger n = (NSUInteger) (size.width * size.height);
        _index = [[NSMutableArray alloc] initWithCapacity:n];
        for(int i = 0; i < n; i++) {
            [_index addObject:[NSMutableArray array]];
        }
    }
    return self;
}

- (void)addObject:(id)object toTile:(CEIPoint)tile {
    NSMutableArray * array = (NSMutableArray *) [self objectsAtTile:tile];
    [array addObject:object];
}

- (NSArray *)objectsAtTile:(CEIPoint)tile {
    return [_index objectAtIndex:_block(_size, tile)];
}

- (void)dealloc {
    [_index release];
    [_block release];
    [super dealloc];
}


- (void)removeObject:(CCNode *)node tile:(CEIPoint)tile {
    NSMutableArray * array = (NSMutableArray *) [self objectsAtTile:tile];
    [array removeObject:node];
}

- (void)clear {
    for(NSUInteger i = 0; i < _index.count; i++) {
        [[_index objectAtIndex:i] removeAllObjects];
    }
}
@end