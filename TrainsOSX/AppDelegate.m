//
//  AppDelegate.m
//  TrainsOSX
//
//  Created by Anton Zherdev on 02.10.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "AppDelegate.h"
#import "CRLevel.h"

@implementation TrainsOSXAppDelegate
@synthesize window=window_, glView=glView_;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //Original size
    CGSize originalSize = CGSizeMake(1440, 900);


    CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];

	// enable FPS and SPF
	[director setDisplayStats:YES];

	// EXPERIMENTAL stuff.
	// 'Effects' don't work correctly when autoscale is turned on.
	// Use kCCDirectorResize_NoScale if you don't want auto-scaling.
    [director setOriginalWinSize:originalSize];
	[director setResizeMode:kCCDirectorResize_AutoScale];
	//[director setResizeMode:kCCDirectorResize_NoScale];

    // connect the OpenGL view with the director
    [director setView:glView_];
    [self toggleFullScreen:self];

	// Enable "moving" mouse event. Default no.
	[window_ setAcceptsMouseMovedEvents:YES];

	// Center main window
	//[window_ center];

    [director runWithScene:[CRLevel levelWithNumber:0]];
}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed: (NSApplication *) theApplication
{
	return YES;
}

- (void)dealloc
{
	[[CCDirector sharedDirector] end];
	[window_ release];
	[super dealloc];
}

#pragma mark AppDelegate - IBActions

- (IBAction)toggleFullScreen: (id)sender
{
    [glView_ setAcceptsTouchEvents:NO];
    CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];
    [director setFullScreen: ! [director isFullScreen] ];
    [glView_ setAcceptsTouchEvents:YES];
}

@end
