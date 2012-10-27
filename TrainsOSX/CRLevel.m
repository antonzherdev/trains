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

    _railroad = [CRRailroad railroadForLevel:self zeroPoint:ccp(0, 0) tileHeight:110 size:CGSizeMake(10, 10)];
    [self addChild:_railroad];

    return self;
}

@end
