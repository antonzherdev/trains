#import "CEOrtoSprite.h"
#import "NSArray+BlocksKit.h"

@interface CEOrtoSpriteAngle : NSObject
{
    CGFloat _angleTn;
    CGFloat _angleAtn;
    CGRect _rect;
    CGPoint _shift;
}
@property(nonatomic) CGFloat angleTn;
@property(nonatomic) CGRect rect;
@property(nonatomic) CGPoint shift;
@property(nonatomic) CGFloat angleAtn;


- (id)initWithAngleTn:(CGFloat)angle rect:(CGRect)rect shift:(CGPoint)shift;
- (id)initWithAngleAtn:(CGFloat)angle rect:(CGRect)rect shift:(CGPoint)shift;
@end

@implementation CEOrtoSpriteAngle {

}
@synthesize angleTn = _angleTn;
@synthesize rect = _rect;
@synthesize shift = _shift;
@synthesize angleAtn = _angleAtn;


- (id)initWithAngleTn:(CGFloat)angle rect:(CGRect)rect shift:(CGPoint)shift {
    self = [super init];
    if(self) {
        _angleTn = angle;
        _angleAtn = 1/_angleTn;
        _rect = rect;
        _shift = shift;
    }
    return self;
}

- (id)initWithAngleAtn:(CGFloat)angle rect:(CGRect)rect shift:(CGPoint)shift {
    self = [super init];
    if(self) {
        _angleAtn = angle;
        _angleTn = 1/_angleAtn;
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

- (void)addAngleTn:(CGFloat)angle shift:(CGPoint)shift {
    [_ortoSprite addAngleTn:angle rect:_rect shift:shift];
    _rect.origin.x += _rect.size.width;
}

- (void)addAngleTn:(CGFloat)angle x:(CGFloat)x shift:(CGPoint)shift {
    _rect.size.width = x - _rect.origin.x;
    [_ortoSprite addAngleTn:angle rect:_rect shift:shift];
    _rect.origin.x += _rect.size.width;
}

- (void)addAngleAtn:(CGFloat)angle shift:(CGPoint)shift {
    [_ortoSprite addAngleAtn:angle rect:_rect shift:shift];
    _rect.origin.x += _rect.size.width;
}

- (void)addAngleAtn:(CGFloat)angle x:(CGFloat)x shift:(CGPoint)shift {
    _rect.size.width = x - _rect.origin.x;
    [_ortoSprite addAngleAtn:angle rect:_rect shift:shift];
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
    CGFloat dx = end.x - start.x;
    CGFloat dy = (end.y - start.y) * 2;
    BOOL tn = ABS(dy) >= ABS(dx);
    CGFloat angle = tn ? dx/dy : dy/dx;

    BOOL flipX = angle > 0;
//    CCLOG(@"angle = %f", angle);
    angle = ABS(angle);
    CEOrtoSpriteAngle* a;
    if(tn) {
        a = [_angles reduce:nil withBlock:^CEOrtoSpriteAngle*(CEOrtoSpriteAngle* sum, CEOrtoSpriteAngle* obj) {
            if (sum == nil) return obj;
            return ABS(angle - [sum angleTn]) < ABS(angle - [obj angleTn]) ? sum : obj;
        }];
    } else {
        a = [_angles reduce:nil withBlock:^CEOrtoSpriteAngle*(CEOrtoSpriteAngle* sum, CEOrtoSpriteAngle* obj) {
            if (sum == nil) return obj;
            return ABS(angle - [sum angleAtn]) < ABS(angle - [obj angleAtn]) ? sum : obj;
        }];
    }

    if(a.angleTn == 0) flipX = NO;
    [self setFlipX:flipX];
//    CCLOG(@"angle = %f, tn = %c, result = %f", angle, tn ? 't' : 'f', tn ? a.angleTn : a.angleAtn);
    [self setTextureRect:a.rect];
    self.position = ccp((end.x + start.x)/2 + (flipX ? -a.shift.x : a.shift.x), (end.y + start.y)/2 + a.shift.y);
}

- (void)addAngleTn:(CGFloat)angle rect:(CGRect)rect shift:(CGPoint)shift {
    CEOrtoSpriteAngle *a = [[[CEOrtoSpriteAngle alloc] initWithAngleTn:angle rect:rect shift:shift] autorelease];
    [_angles addObject:a];
}

- (void)addAngleAtn:(CGFloat)angle rect:(CGRect)rect shift:(CGPoint)shift {
    CEOrtoSpriteAngle *a = [[[CEOrtoSpriteAngle alloc] initWithAngleAtn:angle rect:rect shift:shift] autorelease];
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