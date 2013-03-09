#import "CNNone.h"


@implementation CNNone {

}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if(signature != nil) return signature;
    signature = [NSMethodSignature signatureWithObjCTypes:"@"];
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {

}


+ (id)none {
    static CNNone *_sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        if (_sharedInstance == nil){
            _sharedInstance = [[super allocWithZone:NULL] init];
        }
    });

    return _sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self none];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return NSUIntegerMax;
}

- (oneway void)release {
}

- (id)autorelease {
    return self;
}

- (NSUInteger)hash {
    return 13;
}

- (BOOL)isEqual:(id)other {
    return other == nil || other == self;
}

+ (NSString *)description {
    return @"None";
}


@end