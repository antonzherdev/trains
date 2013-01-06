#import "CEOrtoSprite.h"

@implementation CEOrtoSprite {
    NSString *_name;
    NSUInteger _count;
    CGPoint _shift;
}


- (id)initWithInfo:(NSString *)info frameName:(NSString *)name count:(NSUInteger)count {
    NSString *infoFileName = [info stringByAppendingString:@".plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:infoFileName];
    NSString *frameName = [self spriteNameForNumber:0 name:name];
    self = [super initWithSpriteFrameName:frameName];
    if (self) {
        _shift = ccp(0, 0);
        _name = [name copy];
        _count = count;
    }

    return self;
}


- (void)setStart:(CGPoint)start end:(CGPoint)end {
    CGPoint p = ccp(end.x - start.x, (end.y - start.y)*2);
    CGFloat angle = ccpToAngle(p);

    if(angle < 0) angle = 2*M_PI + angle;
    angle -= 0.785398185253143;

    NSInteger i = (NSInteger) round(((angle/(2*M_PI))*_count));
    if(i < 0) i = _count + i;

    NSString *spriteName = [self spriteNameForNumber:(NSUInteger)i name:_name];
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:spriteName];
    [self setDisplayFrame:frame];

    self.position = ccpAdd(ccpLerp(start, end, 0.5), _shift);
}

- (NSString *)spriteNameForNumber:(NSUInteger)i name:(id)name {
    return [NSString stringWithFormat:@"%@_%.5u", name, (unsigned int)i];
}

- (void)dealloc {
    [_name release];
    [super dealloc];
}

@end