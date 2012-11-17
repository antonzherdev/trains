#import "CEOrtoSprite.h"
#import "NSArray+BlocksKit.h"

@interface CEOrtoSpriteAngle : NSObject
{
    CGFloat _angle;
    CGRect _rect;
    CGPoint _shift;
}
@property(nonatomic) CGFloat angle;
@property(nonatomic) CGRect rect;
@property(nonatomic) CGPoint shift;


- (id)initWithAngle:(CGFloat)angle rect:(CGRect)rect shift:(CGPoint)shift;
@end

@implementation CEOrtoSpriteAngle {

}
@synthesize angle = _angle;
@synthesize rect = _rect;
@synthesize shift = _shift;


- (id)initWithAngle:(CGFloat)angle rect:(CGRect)rect shift:(CGPoint)shift {
    self = [super init];
    if(self) {
        _angle = angle;
        _rect = rect;
        _shift = shift;
    }
    return self;
}
@end


@implementation CEOrtoSprite {
    
    NSMutableArray *_angles;
}

- (id)initWithTexture:(CCTexture2D *)texture rect:(CGRect)rect {
    self = [super initWithTexture:texture rect:rect];
    if (self) {
        _angles = [[NSMutableArray array] retain];
    }

    return self;
}



- (void)setStart:(CGPoint)start end:(CGPoint)end {
    CGFloat angle = (end.x - start.x) / (end.y - start.y);
    BOOL flipX = angle > 0;
//    CCLOG(@"angle = %f", angle);
    angle = ABS(angle);
    CEOrtoSpriteAngle* a = [_angles reduce:nil withBlock:^CEOrtoSpriteAngle*(CEOrtoSpriteAngle* sum, CEOrtoSpriteAngle* obj) {
        if (sum == nil) return obj;
        return ABS(angle - [sum angle]) < ABS(angle - [obj angle]) ? sum : obj;
    }];

    if(a.angle == 0) flipX = NO;
    [self setFlipX:flipX];
//    CCLOG(@"angle = %f, result = %f", angle, a.angle);
    [self setTextureRect:a.rect];
    self.position = ccp((end.x + start.x)/2 + (flipX ? -a.shift.x : a.shift.x), (end.y + start.y)/2 + a.shift.y);
}

- (void)addAngle:(CGFloat)angle rect:(CGRect)rect shift:(CGPoint)shift {
    CEOrtoSpriteAngle *a = [[[CEOrtoSpriteAngle alloc] initWithAngle:angle rect:rect shift:shift] autorelease];
    [_angles addObject:a];
}

- (void)dealloc {
    [_angles release];
    [super dealloc];
}

@end