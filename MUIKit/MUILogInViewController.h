//
//  MUIKitAuthActionViewController.h
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 30/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@class MUIEditableTableCell;
@protocol MUILogInViewControllerDelegate;

@interface MUILogInViewController : UITableViewController

@property (nonatomic, weak) id<MUILogInViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet MUIEditableTableCell *usernameCell;
@property (weak, nonatomic) IBOutlet MUIEditableTableCell *passwordCell;

- (IBAction)logInButtonTapped:(id)sender;

- (void)didTapLogInButton;

// call when finished to dismiss the controller.
- (void)didFinish;

// shows the alert as an error.
- (void)didError:(NSError*)error;

@end

@protocol MUILogInViewControllerDelegate <NSObject>

@optional

- (void)logInViewControllerDidFinish:(MUILogInViewController *)viewController;
- (void)logInViewController:(MUILogInViewController *)viewController didError:(NSError *)error;
- (void)logInViewControllerDidTapLogInButton:(MUILogInViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
