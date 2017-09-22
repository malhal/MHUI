//
//  UIAlertView+MUI.h
//  MUIKit
//
//  Created by Malcolm Hall on 13/10/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertView (MUI)

+ (void)mui_showAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id<UIAlertViewDelegate>)delegate;
+ (void)mui_showAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message;
+ (void)mui_showAlertWithMessage:(nullable NSString *)message delegate:(nullable id<UIAlertViewDelegate>)delegate;
+ (void)mui_showAlertWithMessage:(nullable NSString *)message;
+ (void)mui_showAlertWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END

//this is an example of the delegate method you could have
/*
 - (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
 {
	if (buttonIndex == 0) {
 //the user clicked the Cancel button
 return;
 }
	
	//the user clicked OK so do something
 }
 */
