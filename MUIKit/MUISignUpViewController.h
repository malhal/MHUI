//
//  MUISignUpViewController.h
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 30/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>
#import <MUIKit/MUILogInViewController.h>

NS_ASSUME_NONNULL_BEGIN

@class MUISignUpViewController;
@class MUIEditableTableCell;

@protocol MUISignUpViewControllerDelegate <NSObject, MUILogInViewControllerDelegate>

@optional

- (void)signUpViewControllerDidTapSignUpButton:(MUISignUpViewController *)viewController;

@end

@interface MUISignUpViewController : MUILogInViewController

@property (nonatomic, weak, nullable) id <MUISignUpViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet MUIEditableTableCell *emailCell;

//@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField; // todo

- (IBAction)signUpButtonTapped:(id)sender;

- (void)didTapSignUpButton;

@end

NS_ASSUME_NONNULL_END
