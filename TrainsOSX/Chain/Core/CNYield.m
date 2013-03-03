#import "CNYield.h"


@implementation CNYield {

}
+ (void)yieldAll:(id <NSFastEnumeration>)collection in:(id<CNYield>)yield{
    if([yield respondsToSelector:@selector(yieldAll:)]) {
        [yield yieldAll:collection];
    } else {
        CNYieldResult result = [yield beginYieldWithSize:[collection count]];
        if(result == cnYieldContinue) {
            for(id item in collection) {
                result = [yield yieldItem:item];
                if(result == cnYieldBreak) break;
            }
        }
        [yield endYieldWithResult:result];
    }
}

@end