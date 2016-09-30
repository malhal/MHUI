//
//  MHUAuthViewController.h
//  MHUI
//
//  Created by Malcolm Hall on 11/04/2015.
//  Copyright (c) 2015 Malcolm Hall. All rights reserved.
//

// this controller is used for all 3 views in the Auth storyboard. So that the cancel button can be hooked up to an action to dismiss. Adn so the same logic can be used for the textfields that are duplicated.

#import <UIKit/UIKit.h>
#import <MHUI/MHULogInViewController.h>
#import <MHUI/MHUSignUpViewController.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const MHUAuthLogInSegueIdentifier;
FOUNDATION_EXPORT NSString * const MHUAuthSignUpSegueIdentifier;

@protocol MHUAuthViewControllerDelegate;

@interface MHUAuthViewController : UITableViewController<MHULogInViewControllerDelegate, MHUSignUpViewControllerDelegate>

// presents the auth UI with log in and sign up options. The AuthViewController to set the container on is in topViewController.
//+(UINavigationController *)presentFromViewController:(UIViewController*)viewController;

// the alert will be presented from the supplied view controller. Completion handler is fired after the alert is closed which you can use to refresh UI.
//-(void)logoutWithConfirmationFromViewController:(UIViewController*)viewController completionHandler:(void(^)(void))completionHandler;

@property (nonatomic, weak) id<MHUAuthViewControllerDelegate> delegate;

-(IBAction)cancelButtonTapped:(id)sender;

@end

@protocol MHUAuthViewControllerDelegate <NSObject>

@optional

- (void)authViewControllerDidCancel:(MHUAuthViewController *)authViewController;

- (void)authViewController:(MHUAuthViewController *)authViewController logInViewController:(MHULogInViewController *)viewController didError:(NSError *)error;
- (void)authViewController:(MHUAuthViewController *)authViewController logInViewControllerDidTapLogInButton:(MHULogInViewController *)viewController;
- (void)authViewController:(MHUAuthViewController *)authViewController logInViewControllerDidFinish:(MHULogInViewController *)viewController;
- (void)authViewController:(MHUAuthViewController *)authViewController signUpViewControllerDidTapSignUpButton:(MHUSignUpViewController *)viewController;

@end

NS_ASSUME_NONNULL_END