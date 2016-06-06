//
//  UIAlertController+MHU.m
//  MHUI
//
//  Created by Malcolm Hall on 04/02/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "UIAlertController+MHU.h"
#import <objc/runtime.h>

@implementation UIAlertController (MHU)

// replace the implementation of viewDidDisappear via swizzling.
+ (void)load {
    static dispatch_once_t once_token;
    dispatch_once(&once_token,  ^{
        Method originalMethod = class_getInstanceMethod(self, @selector(viewDidDisappear:));
        Method extendedMethod = class_getInstanceMethod(self, @selector(mhu_viewDidDisappear:));
        method_exchangeImplementations(originalMethod, extendedMethod);
    });
}

-(UIWindow*)mhu_alertWindow{
    return objc_getAssociatedObject(self, "mhu_alertWindow");
}

-(void)mhu_setAlertWindow:(UIWindow*)window{
    objc_setAssociatedObject(self, "mhu_alertWindow", window, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)mhu_show{
    void (^showAlert)() = ^void() {
        UIWindow* w = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        // we need to retain the window so it can be set to hidden before it is dealloced so the observation fires.
        [self mhu_setAlertWindow:w];
        w.rootViewController = [[UIViewController alloc] init];
        w.windowLevel = UIWindowLevelAlert;
        [w makeKeyAndVisible];
        [w.rootViewController presentViewController:self animated:YES completion:nil];
    };
    
    // check if existing key window is an alert already being shown. It could be our window or a UIAlertView's window.
    UIWindow* keyWindow = [UIApplication sharedApplication].keyWindow;
    if(keyWindow.windowLevel == UIWindowLevelAlert){
        // if it is, then delay showing this new alert until the previous has been dismissed.
        __block id observer;
        observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIWindowDidBecomeHiddenNotification object:keyWindow queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            [[NSNotificationCenter defaultCenter] removeObserver:observer];
            showAlert();
        }];
    }else{
        // otherwise show the alert immediately.
        showAlert();
    }
}

- (void)mhu_viewDidDisappear:(BOOL)animated {
    [self mhu_viewDidDisappear:animated]; // calls the original implementation
    [self mhu_alertWindow].hidden = YES;
}

@end
