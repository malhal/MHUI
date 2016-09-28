//
//  MHUAuthViewController.h
//  MHUI
//
//  Created by Malcolm Hall on 11/04/2015.
//  Copyright (c) 2015 Malcolm Hall. All rights reserved.
//

// this controller is used for all 3 views in the Auth storyboard. So that the cancel button can be hooked up to an action to dismiss. Adn so the same logic can be used for the textfields that are duplicated.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MHUAuthViewControllerDelegate;

@interface MHUAuthViewController : UITableViewController

// presents the auth UI with log in and sign up options. The AuthViewController to set the container on is in topViewController.
//+(UINavigationController *)presentFromViewController:(UIViewController*)viewController;

// the alert will be presented from the supplied view controller. Completion handler is fired after the alert is closed which you can use to refresh UI.
//-(void)logoutWithConfirmationFromViewController:(UIViewController*)viewController completionHandler:(void(^)(void))completionHandler;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (nonatomic, weak) id<MHUAuthViewControllerDelegate> delegate;

@property (assign, nonatomic) BOOL loading;

// shows the alert as an error.
- (void)didError:(NSError*)error;

-(IBAction)logInButtonTapped:(id)sender;

-(IBAction)signUpButtonTapped:(id)sender;

-(IBAction)cancelButtonTapped:(id)sender;

// call after login succeeds, then use the delegate to dismiss.
-(void)didFinish;

@end

@protocol MHUAuthViewControllerDelegate <NSObject>

@optional

- (void)authViewControllerDidFinish:(MHUAuthViewController *)authViewController;

- (void)authViewControllerDidTapCancelButton:(MHUAuthViewController *)authViewController;

- (void)authViewController:(MHUAuthViewController *)authViewController didError:(NSError *)error;

- (void)authViewControllerDidTapSignUpButton:(MHUAuthViewController *)authViewController;

- (void)authViewControllerDidTapLogInButton:(MHUAuthViewController *)authViewController;

@end

NS_ASSUME_NONNULL_END