//
//  UIAlertView+MHU.m
//  MHUI
//
//  Created by Malcolm Hall on 13/10/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "UIAlertView+MHU.h"

@implementation UIAlertView (MHU)

+ (void)mhu_showAlertWithTitle:(NSString *)title message:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate{
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
        alert = [[UIAlertView alloc] initWithTitle:title
                                           message:message
                                          delegate:delegate
                                 cancelButtonTitle:@"Cancel"
                                 otherButtonTitles:@"OK", nil];
    }else{
        alert = [[UIAlertView alloc] initWithTitle:title
                                           message:message
                                          delegate:delegate
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
    }
    [alert show];
}

+ (void)mhu_showAlertWithTitle:(NSString *)title message:(NSString *)message{
    [UIAlertView mhu_showAlertWithTitle:title message:message delegate:nil];
}

+ (void)mhu_showAlertWithMessage:(NSString *)message{
    [UIAlertView mhu_showAlertWithTitle:nil message:message];
}


+ (void)mhu_showAlertWithError:(NSError *)error
{
    id reason = [error localizedFailureReason];
    if(!reason){
        reason = error.userInfo;
    }
    
    NSString *message = [NSString stringWithFormat:@"Error! %@ %@",
                         [error localizedDescription],
                         reason];
    
    [UIAlertView mhu_showAlertWithMessage:message];
}


+ (void)mhu_showAlertWithMessage:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate{
    [UIAlertView mhu_showAlertWithTitle:nil message:message delegate:nil];
}

@end
