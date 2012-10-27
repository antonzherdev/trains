#import "CETileIndex.h"


@implementation CETileIndex {
    CGSize _size;
    NSMutableArray *_index;
    NSUInteger (^_block)(CGSize, CGPoint);

}
@synthesize size = _size;

+ (id)tileIndexWithSize:(CGSize)size {
    return [[[CETileIndex alloc] initWithSize:size tileIndexBlock:^(CGSize size_, CGPoint tile) {
        return (NSUInteger) (size_.width*tile.y + tile.x);
    }] autorelease];
}

+ (id)tileIndexForOrtoMapWithSize:(CGSize)size {
    return [[[CETileIndex alloc] initWithSize:size tileIndexBlock:^(CGSize size_, CGPoint tile) {
        return (NSUInteger) (size_.width*(tile.y - tile.x - 1) + (tile.x + tile.y));
    }] autorelease];
}


- (id)initWithSize:(CGSize)size tileIndexBlock:(NSUInteger (^)(CGSize, CGPoint))block {
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

- (void)addObject:(id)object toTile:(CGPoint)tile {
    NSMutableArray * array = (NSMutableArray *) [self objectsAtTile:tile];
    [array addObject:object];
}

- (NSArray *)objectsAtTile:(CGPoint)tile {
    return [_index objectAtIndex:_block(_size, tile)];
}

- (void)dealloc {
    [_index release];
    [super dealloc];
}


@end