//
//  UISplitViewController+MUI.h
//  MUIKit
//
//  Created by Malcolm Hall on 08/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <MHFoundation/MHFoundation.h>
#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>


NS_ASSUME_NONNULL_BEGIN

@interface UISplitViewController (MUI)

@property (strong, nonatomic, nullable, readonly) UIViewController *mui_secondaryViewController;

@property (strong, nonatomic, nullable, readonly) UINavigationController *mui_secondaryNavigationController;



@end

NS_ASSUME_NONNULL_END
