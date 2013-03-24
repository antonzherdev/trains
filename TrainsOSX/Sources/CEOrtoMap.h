#import <Foundation/Foundation.h>
#import "CEMap.h"


struct CEOrtoMapDim {
    NSUInteger tileHeight;
    CEISize size;
};
typedef struct CEOrtoMapDim CEOrtoMapDim;

@interface CEOrtoMap : CEMap
@property(nonatomic) CEOrtoMapDim dim;

+ (CGPoint)pointForTile:(CEIPoint)tile dim:(CEOrtoMapDim)dim;

+ (CGPoint)tilePointForPoint:(CGPoint)point dim:(CEOrtoMapDim)dim;

+ (id)ortoMapWithDim:(CEOrtoMapDim)dim;

- (id)initWithDim:(CEOrtoMapDim)dim;
@end