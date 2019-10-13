//
//  UINavigationController+MUI.h
//  MUIKit
//
//  Created by Malcolm Hall on 28/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <MHFoundation/MHFoundation.h>
#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>


//NS_ASSUME_NONNULL_BEGIN


MUIKIT_EXTERN NSNotificationName const MUINavigationControllerWillShowViewControllerNotification;
MUIKIT_EXTERN NSNotificationName const MUINavigationControllerDidShowViewControllerNotification;
MUIKIT_EXTERN NSString * const MUINavigationControllerNextVisibleViewController;
MUIKIT_EXTERN NSString * const MUINavigationControllerLastVisibleViewController;

//}
//NS_ASSUME_NONNULL_END

@interface UINavigationController (MUI)



@end
