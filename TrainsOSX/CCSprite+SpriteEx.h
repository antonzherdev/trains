//
// Created by antonzherdev on 07.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "CCSprite.h"

@interface CCSprite (SpriteEx)
+ (id) spriteWithFile:(NSString *)fileName pixelFormat:(CCTexture2DPixelFormat)format;
+ (id) spriteWithFile:(NSString *)fileName rect:(CGRect)rect pixelFormat:(CCTexture2DPixelFormat)format;
@end