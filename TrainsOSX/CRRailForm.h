#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"

typedef enum {
    crRailFormHorizontal,
    crRailFormVertical,
    crRailFormHorizontalTurnRight,
    crRailFormHorizontalTurnLeft,
    crRailFormVerticalTurnRight,
    crRailFormVerticalTurnLeft
} CRRailForm;

@protocol CRRailFormDescription
- (NSString *) file;

- (CGPoint)spritePosition;
@end

@interface CRRailFormDescriptionFactory : NSObject
+ (id <CRRailFormDescription>) descriptionForForm:(CRRailForm)form;
@end

