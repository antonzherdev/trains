#import <Foundation/Foundation.h>


@interface CECtrl : NSObject
- (id)initWithView:(id)view;

- (void) updated;

- (void) atomic:(void(^)()) block;
@end

@protocol CEView
- (void) updatedCtrl: (CECtrl *) ctrl;
@end

@interface CEView : NSObject <CEView>
- (void) updatedCtrl: (CECtrl *) ctrl;
@end