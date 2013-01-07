#import <Foundation/Foundation.h>

@class CRRailForm;

#define CE_ENUM(cls, name) name = [[cls alloc] initWithName:@#name];


@interface CEEnum : NSObject
@property (nonatomic, readonly)NSUInteger ordinal;

@property (nonatomic, readonly)NSString *name;

- (id)initWithName:(NSString *)name;

+ (NSArray*) values;

+ (id)valueWithOrdinal:(NSUInteger)ordinal;
@end
