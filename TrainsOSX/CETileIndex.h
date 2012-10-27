#import <Foundation/Foundation.h>


@interface CETileIndex : NSObject
@property(nonatomic, readonly) CGSize size;

+ (id) tileIndexWithSize:(CGSize) size;
+ (id)tileIndexForOrtoMapWithSize:(CGSize) size;

- (id)initWithSize:(CGSize)size tileIndexBlock:(NSUInteger (^)(CGSize, CGPoint))block;

-(void) addObject:(id)object toTile:(CGPoint) tile;
-(NSArray*)objectsAtTile:(CGPoint) tile;

@end