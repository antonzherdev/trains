#import "CECtrl.h"

@implementation CECtrl {
    bool _atomic;
    bool _updated;
    id _view;
}

- (id)initWithView:(id)view {
    self = [super init];
    if (self) {
        _view = view;
        _atomic = false;
        _updated = false;
    }

    return self;
}


- (void)updated {
    if(_atomic) {
        _updated = true;
    } else {
        [self sendUpdated];
    }
}

- (void)sendUpdated {
    [_view updatedCtrl:self];
}

- (void)atomic:(void (^)())block {
    _atomic = true;
    @try {
        block();
    } @finally {
        _atomic = false;
        if(_updated) {
            _updated = false;
            [self updated];
        }
    }

}

@end

@implementation CEView
- (void)updatedCtrl:(CECtrl *)ctrl {

}
@end