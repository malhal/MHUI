//
//  UIAlertController+MUI.m
//  MUIKit
//
//  Created by Malcolm Hall on 04/02/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "UIAlertController+MUI.h"
#import <objc/runtime.h>

@implementation UIAlertController (MUI)

+ (UIAlertController *)mui_alertControllerWithTitle:(NSString *)title message:(NSString *)message{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                          }];
    // set loading after button pressed?
    [alert addAction:defaultAction];
    
    return alert;
}

// replace the implementation of viewDidDisappear via swizzling.
+ (void)load {
    static dispatch_once_t once_token;
    dispatch_once(&once_token,  ^{
        Method originalMethod = class_getInstanceMethod(self, @selector(viewDidDisappear:));
        Method extendedMethod = class_getInstanceMethod(self, @selector(mui_viewDidDisappear:));
        method_exchangeImplementations(originalMethod, extendedMethod);
    });
}

-(UIWindow*)mui_alertWindow{
    return objc_getAssociatedObject(self, "mui_alertWindow");
}

-(void)mui_setAlertWindow:(UIWindow*)window{
    objc_setAssociatedObject(self, "mui_alertWindow", window, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)mui_show{
    void (^showAlert)() = ^void() {
        UIWindow* w = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        // we need to retain the window so it can be set to hidden before it is dealloced so the observation fires.
        [self mui_setAlertWindow:w];
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

- (void)mui_viewDidDisappear:(BOOL)animated {
    [self mui_viewDidDisappear:animated]; // calls the original implementation
    [self mui_alertWindow].hidden = YES;
}

@end
