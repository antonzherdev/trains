//
//  HelloWorldLayer.m
//  TrainsOSX
//
//  Created by Anton Zherdev on 02.10.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import "CETextureBackgroundLayer.h"

@implementation CETextureBackgroundLayer

+(CETextureBackgroundLayer*)layerWithFile:(NSString *)fileName
{
    return [[CETextureBackgroundLayer alloc] initWithFile:fileName];
}

-(id) initWithFile:(NSString *)fileName
{
	if( (self=[super init]) ) {
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCSprite *sprite = [CCSprite spriteWithFile:fileName rect:CGRectMake(0, 0, size.width, size.height)];
        
        ccTexParams params = {GL_LINEAR,GL_LINEAR,GL_REPEAT,GL_REPEAT};
        [sprite.texture setTexParameters: &params];
    
		sprite.position =  ccp( size.width /2 , size.height/2 );
		
		[self addChild: sprite];
	}
	return self;
}

@end
