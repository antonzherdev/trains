#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class CEOrtoSprite;


@interface CEOrtoSprite : CCSprite

@property (nonatomic)CGPoint shift;

- (id)initWithInfo:(NSString *)info frameName:(NSString *)name count:(NSUInteger)count;

- (void)setStart:(CGPoint)start end:(CGPoint)end;


@end