#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class CEOrtoSprite;

@interface CEOrtoSpriteLine : NSObject
- (id)initWithOrtoSprite:(CEOrtoSprite *)ortoSprite rect:(CGRect)rect;

+ (id)lineWithOrtoSprite:(CEOrtoSprite *)ortoSprite rect:(CGRect)rect;

- (void)addAngleTn:(CGFloat)angle shift:(CGPoint)shift;


- (void)addAngleTn:(CGFloat)angle x:(CGFloat)x shift:(CGPoint)shift;

- (void)addAngleAtn:(CGFloat)angle shift:(CGPoint)shift;

- (void)addAngleAtn:(CGFloat)angle x:(CGFloat)x shift:(CGPoint)shift;

@end

@interface CEOrtoSprite : CCSprite

- (void)setStart:(CGPoint)start end:(CGPoint)end;

- (void)addAngleTn:(CGFloat)angle rect:(CGRect)rect shift:(CGPoint)shift;

- (void)addAngleAtn:(CGFloat)angle rect:(CGRect)rect shift:(CGPoint)shift;


- (CEOrtoSpriteLine*)lineWithStartRect:(CGRect) rect;
@end