#import "CRRailForm.h"

@interface CRRailFormHorizontal : NSObject <CRRailFormDescription>
@end

@implementation CRRailFormHorizontal
- (NSString *)file {
    return @"RailHorizontal.png";
}

- (CGPoint)spritePosition {
    return ccp(0, 0);
}
@end

@implementation CRRailFormDescriptionFactory
static CRRailFormHorizontal *horizontal;

+ (id <CRRailFormDescription>)descriptionForForm:(CRRailForm)form {
    switch (form) {
        case crRailFormHorizontal:
            if(!horizontal) horizontal = [[CRRailFormHorizontal alloc] init];
            return horizontal;
    }
    return nil;
}

@end

