//
//  MHUFlipController.h
//  MHUI
//
//  Created by Malcolm Hall on 03/01/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//
// Use in a storyboard as a Tab controller custom class. Add a button to the nav bar and hook its selector up to the flip method. Then make the tab bar hidden. Add two child controllers to flip between. Set the flipButton outlet to have the title updated to the title of the tab item when flipping, you have to set the label yourself for the default.

// Didn't figure how to default the button to the initial tab item. selectedViewController isnt set until viewDidAppear.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHUFlipController : UITabBarController

@property (nonatomic, readonly) UIBarButtonItem *flipButton;

// called like prepareForSegue before flipping.
-(void)willFlipToViewController:(UIViewController*)viewController;

@end

@interface UIViewController (MHUFlipControllerItem)

//@property(null_resettable, nonatomic, strong) UITabBarItem *tabBarItem; // Automatically created lazily with the view controller's title if it's not set explicitly.

@property(nullable, nonatomic, readonly, strong) MHUFlipController *flipController; // If the view controller has a tab bar controller as its ancestor, return it. Returns nil otherwise.

@end

NS_ASSUME_NONNULL_END