//
//  MUIAccountViewController.h
//  MUIKit
//
//  Created by Malcolm Hall on 11/04/2015.
//  Copyright (c) 2015 Malcolm Hall. All rights reserved.
//

// this controller is used for all 3 views in the Auth storyboard. So that the cancel button can be hooked up to an action to dismiss. Adn so the same logic can be used for the textfields that are duplicated.

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>
#import <MUIKit/MUILogInViewController.h>
#import <MUIKit/MUISignUpViewController.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MUIAccountViewControllerDelegate;

@interface MUIAccountViewController : UITableViewController <MUILogInViewControllerDelegate, MUISignUpViewControllerDelegate>

// presents the auth UI with log in and sign up options. The AuthViewController to set the container on is in topViewController.
//+(UINavigationController *)presentFromViewController:(UIViewController*)viewController;

// the alert will be presented from the supplied view controller. Completion handler is fired after the alert is closed which you can use to refresh UI.
//-(void)logoutWithConfirmationFromViewController:(UIViewController*)viewController completionHandler:(void(^)(void))completionHandler;

@property (nonatomic, weak) id <MUIAccountViewControllerDelegate> delegate;

@end

@protocol MUIAccountViewControllerDelegate <NSObject>

@optional

- (void)accountViewControllerDidCancel:(MUIAccountViewController *)accountViewController;

- (void)accountViewController:(MUIAccountViewController *)accountViewController logInViewController:(MUILogInViewController *)logInOrSignUp didError:(NSError *)error;
- (void)accountViewController:(MUIAccountViewController *)accountViewController logInViewControllerDidTapLogInButton:(MUILogInViewController *)logInOrSignUp;
- (void)accountViewController:(MUIAccountViewController *)accountViewController logInViewControllerDidFinish:(MUILogInViewController *)logInOrSignUp;
- (void)accountViewController:(MUIAccountViewController *)accountViewController signUpViewControllerDidTapSignUpButton:(MUISignUpViewController *)signUp;

@end

NS_ASSUME_NONNULL_END
