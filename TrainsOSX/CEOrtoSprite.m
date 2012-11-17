#import "CEOrtoSprite.h"
#import "NSArray+BlocksKit.h"

@interface CEOrtoSpriteAngle : NSObject
{
    CGFloat _angle;
    CGRect _rect;
}
@property(nonatomic) CGFloat angle;
@property(nonatomic) CGRect rect;
- (id)initWithAngle:(CGFloat)angle rect:(CGRect)rect;
@end

@implementation CEOrtoSpriteAngle {

}
@synthesize angle = _angle;
@synthesize rect = _rect;


- (id)initWithAngle:(CGFloat)angle rect:(CGRect)rect {
    self = [super init];
    if(self) {
        _angle = angle;
        _rect = rect;
    }
    return self;
}
@end


@implementation CEOrtoSprite {
    CGPoint _shift;
    NSMutableArray *_angles;
}
@synthesize shift = _shift;

- (id)initWithTexture:(CCTexture2D *)texture rect:(CGRect)rect {
    self = [super initWithTexture:texture rect:rect];
    if (self) {
        _angles = [[NSMutableArray array] retain];
        [self addAngle:2 rect:rect];
    }

    return self;
}


- (void)setStart:(CGPoint)start end:(CGPoint)end {
    CGFloat angle = (end.x - start.x) / (end.y - start.y);
    [self setFlipX:angle > 0];
    angle = ABS(angle);
    CEOrtoSpriteAngle* a = [_angles reduce:nil withBlock:^CEOrtoSpriteAngle*(CEOrtoSpriteAngle* sum, CEOrtoSpriteAngle* obj) {
        if (sum == nil) return obj;
        return ABS(angle - [sum angle]) < ABS(angle - [obj angle]) ? sum : obj;
    }];
    [self setTextureRect:a.rect];
    self.position = ccp((end.x + start.x)/2 + _shift.x, (end.y + start.y)/2 + _shift.y);
}

- (void)addAngle:(CGFloat)angle rect:(CGRect)rect {
    CEOrtoSpriteAngle *a = [[[CEOrtoSpriteAngle alloc] initWithAngle:angle rect:rect] autorelease];
    [_angles addObject:a];
}

- (void)dealloc {
    [_angles release];
    [super dealloc];
}

@end