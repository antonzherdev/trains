#import "CNOption.h"
#import "CNNone.h"


@implementation CNOption {

}
+ (id)none {
    return [CNNone none];
}

+ (id)opt:(id)value {
    return value == nil ? [CNNone none] : value;
}


@end