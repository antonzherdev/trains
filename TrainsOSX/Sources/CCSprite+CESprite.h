#import <Foundation/Foundation.h>
#import "CCSprite.h"

@interface CCSprite (CESprite)
+ (id) spriteWithFile:(NSString *)fileName pixelFormat:(CCTexture2DPixelFormat)format;
+ (id) spriteWithFile:(NSString *)fileName rect:(CGRect)rect pixelFormat:(CCTexture2DPixelFormat)format;
@end