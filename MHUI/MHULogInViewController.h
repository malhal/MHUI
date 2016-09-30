//
//  MHUIAuthActionViewController.h
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 30/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MHULogInViewControllerDelegate;

@interface MHULogInViewController : UITableViewController

@property (nonatomic, weak) id<MHULogInViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)logInButtonTapped:(id)sender;

// call when finished to dismiss the controller.
-(void)didFinish;

// shows the alert as an error.
- (void)didError:(NSError*)error;

@end

@protocol MHULogInViewControllerDelegate <NSObject>

@optional

- (void)logInViewControllerDidFinish:(MHULogInViewController *)viewController;

- (void)logInViewController:(MHULogInViewController *)viewController didError:(NSError *)error;

- (void)logInViewControllerDidTapLogInButton:(MHULogInViewController *)viewController;

@end

NS_ASSUME_NONNULL_END