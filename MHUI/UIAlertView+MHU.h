//
//  UIAlertView+MHU.h
//  MHUI
//
//  Created by Malcolm Hall on 13/10/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MHUI/MHUDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertView (MHU)

+ (void)mhu_showAlertWithTitle:(NSString *)title message:(NSString *)message delegate:(nullable id<UIAlertViewDelegate>)delegate;
+ (void)mhu_showAlertWithTitle:(NSString *)title message:(NSString *)message;
+ (void)mhu_showAlertWithMessage:(NSString *)message delegate:(nullable id<UIAlertViewDelegate>)delegate;
+ (void)mhu_showAlertWithMessage:(NSString *)message;
+ (void)mhu_showAlertWithError:(NSError *)error;

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