#import "CRRailForm.h"


NSMutableDictionary * valuesDictionary;

@implementation CEEnum {
    NSUInteger _ordinal;
    NSString* _name;
}


- (id)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = [name retain];
        NSMutableArray * values = [valuesDictionary objectForKey:self.class];
        _ordinal = [values count];
        [values addObject:self];
    }

    return self;
}

+ (void)initialize {
    [super initialize];
    if (valuesDictionary == nil) {
        valuesDictionary = [[NSMutableDictionary dictionary] retain];
    }
    if ([self class] != [CEEnum class]) {
        NSMutableArray *values = [NSMutableArray array];
        [valuesDictionary setObject:values forKey:[self class]];
    }
}


+ (NSArray *)values {
    return [valuesDictionary objectForKey:self.class];
}

+ (id)valueWithOrdinal:(NSUInteger)ordinal {
    return [[self values] objectAtIndex:ordinal];
}

- (BOOL)isEqual:(id)other {
    return self == other;
}


- (NSUInteger)hash {
    return self.ordinal;
}

- (void)dealloc {
    [_name release];
    [super dealloc];
}
@end
