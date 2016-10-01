//
//  MHUIAuthActionViewController.h
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 30/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MHUI/MHUDefines.h>

NS_ASSUME_NONNULL_BEGIN

@class MHUEditableTableCell;
@protocol MHULogInViewControllerDelegate;

@interface MHULogInViewController : UITableViewController

@property (nonatomic, weak) id<MHULogInViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet MHUEditableTableCell *usernameCell;
@property (weak, nonatomic) IBOutlet MHUEditableTableCell *passwordCell;

- (IBAction)logInButtonTapped:(id)sender;

- (void)didTapLogInButton;

// call when finished to dismiss the controller.
- (void)didFinish;

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