//
//  UIAlertView+MUI.m
//  MUIKit
//
//  Created by Malcolm Hall on 13/10/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "UIAlertView+MUI.h"

@implementation UIAlertView (MUI)

+ (void)mui_showAlertWithTitle:(NSString *)title message:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate{
    if(!title){
        //use the app's name
        title = [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"];
        if(!title){
            title = [[NSProcessInfo processInfo] processName];
        }
    }
    
    /* open an alert with an OK button */
    UIAlertView *alert;
    if(delegate){
        alert = [UIAlertView.alloc initWithTitle:title
                                           message:message
                                          delegate:delegate
                                 cancelButtonTitle:@"Cancel"
                                 otherButtonTitles:@"OK", nil];
    }else{
        alert = [UIAlertView.alloc initWithTitle:title
                                           message:message
                                          delegate:delegate
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
    }
    [alert show];
}

+ (void)mui_showAlertWithTitle:(NSString *)title message:(NSString *)message{
    [UIAlertView mui_showAlertWithTitle:title message:message delegate:nil];
}

+ (void)mui_showAlertWithMessage:(NSString *)message{
    [UIAlertView mui_showAlertWithTitle:nil message:message];
}


+ (void)mui_showAlertWithError:(NSError *)error
{
    id reason = [error localizedFailureReason];
    if(!reason){
        reason = error.userInfo;
    }
    
    NSString *message = [NSString stringWithFormat:@"Error! %@ %@",
                         [error localizedDescription],
                         reason];
    
    [UIAlertView mui_showAlertWithMessage:message];
}


+ (void)mui_showAlertWithMessage:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate{
    [UIAlertView mui_showAlertWithTitle:nil message:message delegate:nil];
}

@end
