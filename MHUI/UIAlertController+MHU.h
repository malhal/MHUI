//
//  UIAlertController+MHU.h
//  MHUI
//
//  Created by Malcolm Hall on 04/02/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MHUI/MHUDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (MHU)

+ (UIAlertController *)mhu_alertControllerWithTitle:(NSString *)title message:(NSString *)message;

// Gives previous behavior of UIAlertView in that alerts are queued up.
-(void)mhu_show;

@end

NS_ASSUME_NONNULL_END