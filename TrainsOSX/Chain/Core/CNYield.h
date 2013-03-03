#import <Foundation/Foundation.h>

typedef enum {
    cnYieldContinue,
    cnYieldBreak,
} CNYieldResult;

@protocol CNYield <NSObject>
- (CNYieldResult) beginYieldWithSize:(NSUInteger)size;
- (CNYieldResult) yieldItem:(id)item;
- (void) endYieldWithResult:(CNYieldResult)result;
@optional
- (CNYieldResult) yieldAll:(id<NSFastEnumeration>)collection;
@end

@interface CNYield
+ (void) yieldAll:(id<NSFastEnumeration>)collection in:(id<CNYield>)yield;
@end