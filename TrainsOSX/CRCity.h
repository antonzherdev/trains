#import <Foundation/Foundation.h>
#import "cocos2d-ex.h"

typedef enum {
    crOrangeCity,
    crGreenCity,
} CRCityColor;

@interface CRCity : CCSprite
@property(nonatomic) CRCityColor cityColor;

+(id) cityWithColor:(CRCityColor)color;

- (id)initWithColor:(CRCityColor)color;
@end