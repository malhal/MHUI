//
//  MHUSignUpViewController.h
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 30/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <MHUI/MHULogInViewController.h>

NS_ASSUME_NONNULL_BEGIN

@class MHUSignUpViewController;

@protocol MHUSignUpViewControllerDelegate <NSObject, MHULogInViewControllerDelegate>

@optional

- (void)signUpViewControllerDidTapSignUpButton:(MHUSignUpViewController *)viewController;

@end

@interface MHUSignUpViewController : MHULogInViewController

@property (nonatomic, weak, nullable) id <MHUSignUpViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
//@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField; // todo

- (IBAction)signUpButtonTapped:(id)sender;

@end

NS_ASSUME_NONNULL_END