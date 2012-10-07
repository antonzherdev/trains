//
// Created by antonzherdev on 07.10.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "CCSprite+SpriteEx.h"


@implementation CCSprite (SpriteEx)
+ (id)spriteWithFile:(NSString *)fileName pixelFormat:(CCTexture2DPixelFormat)format {
    CCTexture2DPixelFormat oldFormat = [CCTexture2D defaultAlphaPixelFormat];
    [CCTexture2D setDefaultAlphaPixelFormat:format];
    @try {
        return [CCSprite spriteWithFile:fileName];
    }
    @finally {
        [CCTexture2D setDefaultAlphaPixelFormat:oldFormat];
    }
}

+ (id)spriteWithFile:(NSString *)fileName rect:(CGRect)rect pixelFormat:(CCTexture2DPixelFormat)format {
    CCTexture2DPixelFormat oldFormat = [CCTexture2D defaultAlphaPixelFormat];
    [CCTexture2D setDefaultAlphaPixelFormat:format];
    @try {
        return [CCSprite spriteWithFile:fileName rect:rect];
    }
    @finally {
        [CCTexture2D setDefaultAlphaPixelFormat:oldFormat];
    }
}


@end