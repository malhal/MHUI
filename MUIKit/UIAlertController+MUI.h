//
//  UIAlertController+MUI.h
//  MUIKit
//
//  Created by Malcolm Hall on 04/02/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (MUI)

+ (UIAlertController *)mui_alertControllerWithTitle:(NSString *)title message:(NSString *)message;

// Gives previous behavior of UIAlertView in that alerts are queued up.
-(void)mui_show;

@end

NS_ASSUME_NONNULL_END
