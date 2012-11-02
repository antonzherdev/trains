#import "CRLevel.h"
#import "CETextureBackgroundLayer.h"
#import "CRRailroad.h"


@implementation CRLevel {
    CRRailroad *_railroad;
}

+ (CRLevel *)levelWithNumber:(int)number {
	return [[[CRLevel alloc] initWithNumber:number] autorelease];
}

- (id)initWithNumber:(int)number {
    self = [super init];
    if (!self) return nil;

    CETextureBackgroundLayer *layer = [CETextureBackgroundLayer layerWithFile:@"Grass.png"];
    [self addChild: layer];

    CEOrtoMapDim dim;
    dim.tileHeight = 110;
    dim.size.width = 14;
    dim.size.height = 17;
    _railroad = [[CRRailroad railroadForLevel:self dim:dim] retain];
    _railroad.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
    _railroad.anchorPoint = ccp(0.5, 0.5);

    [self addChild:_railroad];

    return self;
}

- (void)dealloc {
    [_railroad release];
    [super dealloc];
}

@end
