#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class CEOrtoSprite;

@interface CEOrtoSpriteLine : NSObject
- (id)initWithOrtoSprite:(CEOrtoSprite *)ortoSprite rect:(CGRect)rect;

+ (id)lineWithOrtoSprite:(CEOrtoSprite *)ortoSprite rect:(CGRect)rect;

- (void)addAngle:(CGFloat)angle shift:(CGPoint)shift;


@end

@interface CEOrtoSprite : CCSprite

- (void)setStart:(CGPoint)start end:(CGPoint)end;

- (void)addAngle:(CGFloat)angle rect:(CGRect)rect shift:(CGPoint)shift;

- (CEOrtoSpriteLine*)lineWithStartRect:(CGRect) rect;
@end