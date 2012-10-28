#import <Foundation/Foundation.h>
#import "CEMap.h"


struct CEOrtoMapDim {
    NSUInteger tileHeight;
    CGSize size;
    CGPoint zeroPoint;
};
typedef struct CEOrtoMapDim CEOrtoMapDim;

@interface CEOrtoMap : CEMap
@property(nonatomic) CEOrtoMapDim dim;

+ (id)ortoMapWithDim:(CEOrtoMapDim)dim;

- (id)initWithDim:(CEOrtoMapDim)dim;
@end