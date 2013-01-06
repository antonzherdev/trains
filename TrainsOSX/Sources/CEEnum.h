#import <Foundation/Foundation.h>

#define CE_ENUM(cls, name) cr ## name = [[cls alloc] initWithName:@#name];


@interface CEEnum : NSObject
@property (nonatomic, readonly)NSUInteger ordinal;

@property (nonatomic, readonly)NSString *name;

- (id)initWithName:(NSString *)name;

+ (NSArray*) values;
@end
