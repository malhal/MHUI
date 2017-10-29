//
//  UIViewController+MUI.h
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 29/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MUI)

@property (nonatomic, assign, setter=mui_setLoading:) BOOL mui_loading;

@property (nonatomic, assign, readonly) BOOL mui_isViewVisible;

@end

NS_ASSUME_NONNULL_END
