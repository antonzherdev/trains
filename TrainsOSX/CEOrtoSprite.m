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

@implementation CEOrtoSpriteLine {
    CGRect _rect;
    CEOrtoSprite* _ortoSprite;
}
- (id)initWithOrtoSprite:(CEOrtoSprite *)ortoSprite rect:(CGRect)rect {
    self = [super init];
    if (self) {
        _ortoSprite = ortoSprite;
        _rect = rect;
    }

    return self;
}

+ (id)lineWithOrtoSprite:(CEOrtoSprite *)ortoSprite rect:(CGRect)rect {
    return [[[CEOrtoSpriteLine alloc] initWithOrtoSprite:ortoSprite rect:rect] autorelease];
}

- (void)addAngle:(CGFloat)angle shift:(CGPoint)shift {
    [_ortoSprite addAngle:angle rect:_rect shift:shift];
    _rect.origin.x += _rect.size.width;
}

- (void)addAngle:(CGFloat)angle x:(CGFloat)x shift:(CGPoint)shift {
    _rect.size.width = x - _rect.origin.x;
    [_ortoSprite addAngle:angle rect:_rect shift:shift];
    _rect.origin.x += _rect.size.width;

}
@end

@implementation CEOrtoSprite {
    NSMutableArray *_angles;
}


- (id)init {
    self = [super init];
    if (self) {
        _angles = [[NSMutableArray alloc] init];
    }

    return self;
}

- (id)initWithTexture:(CCTexture2D *)texture rect:(CGRect)rect {
    self = [super initWithTexture:texture rect:rect];
    if (self) {
        _angles = [[NSMutableArray array] retain];
    }

    return self;
}


- (void)setStart:(CGPoint)start end:(CGPoint)end {
    CGFloat angle = (end.x - start.x) / ((end.y - start.y)*2);
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

- (CEOrtoSpriteLine *)lineWithStartRect:(CGRect)rect {
    return [CEOrtoSpriteLine lineWithOrtoSprite:self rect:rect];
}

- (void)dealloc {
    [_angles release];
    [super dealloc];
}

@end