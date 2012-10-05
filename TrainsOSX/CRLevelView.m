//
//  CRLevelView.m
//  TrainsOSX
//
//  Created by Anton Zherdev on 05.10.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CRLevelView.h"
#import "CETextureBackgroundLayer.h"


@implementation CRLevelView

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CETextureBackgroundLayer *layer = [CETextureBackgroundLayer layerWithFile:@"Grass.png"];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


@end
