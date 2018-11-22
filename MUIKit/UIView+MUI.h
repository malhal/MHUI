//
//  UIView+MUI.h
//  MUIKit
//
//  Created by Malcolm Hall on 08/01/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MHViewAnimationTransitionSlide) {
    MHViewAnimationTransitionSlideToFromLeft,
    MHViewAnimationTransitionSlideToFromRight,
    MHViewAnimationTransitionSlideToFromTop,
    MHViewAnimationTransitionSlideToFromBottom,
};


@interface UIView (MUI)

// set this as backgroundView on tableView to have a table that matches the look of a nav bar or toolbar. Also set backgroundColor to clear.
- (UIVisualEffectView *)mui_createBlurredBackgroundView;

- (void)mui_setHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^ __nullable)(BOOL finished))completion;

// Slides a view on and off screen, using the width or height of the view as the amount to move, so it assumes the view is on the edge of the screen.
// This is designed to overcome the limitation of CATransitions that force a fade aswell as a move.
// The 
- (void)mui_transitionSlide:(MHViewAnimationTransitionSlide)transitionSlide completion:(void (^ __nullable)(BOOL finished))completion;

- (__kindof UIViewController *)mui_viewController;

- (BOOL)mui_isMemberOfViewControllerHierarchy:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
