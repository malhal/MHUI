#import "MUIAlertController.h"

@implementation MUIAlertController

- (void)dealloc{
    if(_dissmissWithoutActionBlock && !_didPerformAction){
        void (^block)(void) = [_dissmissWithoutActionBlock copy];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0), dispatch_get_main_queue(), block);
    }
}

@end
