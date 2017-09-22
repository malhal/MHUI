//
//  MUIAccountViewController.m
//  MUIKit
//
//  Created by Malcolm Hall on 11/04/2015.
//  Copyright (c) 2015 Malcolm Hall. All rights reserved.
//

#import "MUIAccountViewController.h"

@implementation MUIAccountViewController

/*
+(UINavigationController *)presentFromViewController:(UIViewController*)viewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Auth" bundle:nil];
    UINavigationController *nav = (UINavigationController*)[sb instantiateInitialViewController];
    [viewController presentViewController:nav animated:YES completion:nil];
    
    return nav;
}
*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:[MUISignUpViewController class]]){
        MUISignUpViewController *signUp = (MUISignUpViewController *)segue.destinationViewController;
        signUp.delegate = self;
    }
    else if([segue.destinationViewController isKindOfClass:[MUILogInViewController class]]){
        MUILogInViewController *logIn = (MUILogInViewController *)segue.destinationViewController;
        logIn.delegate = self;
    }
}

/*
-(void)logoutWithConfirmationFromViewController:(UIViewController*)viewController completionHandler:(void(^)(void))completionHandler{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Log Out"
                                                                   message:@"Are you sure you would like to log out?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             completionHandler();
                                                         }];
    [alert addAction:cancelAction];
    
    UIAlertAction* defaultAction =
    [UIAlertAction actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               [self.container.cloudDatabase logoutWithCompletionHandler:nil];
                               // the session is cleared when the logout operation starts so wait til after that to complete so by then the current session is gone.
                               dispatch_async(dispatch_get_main_queue(), ^{
                                    completionHandler();
                               });
                           }];
    
    [alert addAction:defaultAction];
    [viewController presentViewController:alert animated:YES completion:nil];
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)cancelButtonTapped:(id)sender{
    if([self.delegate respondsToSelector:@selector(accountViewControllerDidCancel:)]){
        [self.delegate accountViewControllerDidCancel:self];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)logInViewControllerDidTapLogInButton:(MUILogInViewController *)logInOrSignUp{
    if([self.delegate respondsToSelector:@selector(accountViewController:logInViewControllerDidTapLogInButton:)]){
        [self.delegate accountViewController:self logInViewControllerDidTapLogInButton:logInOrSignUp];
    }
}

- (void)logInViewController:(MUILogInViewController *)logInOrSignUp didError:(NSError *)error{
    if([self.delegate respondsToSelector:@selector(accountViewController:logInViewController:didError:)]){
        [self.delegate accountViewController:self logInViewController:logInOrSignUp didError:error];
    }
}

- (void)logInViewControllerDidFinish:(MUILogInViewController *)logInOrSignUp{
    if([self.delegate respondsToSelector:@selector(accountViewController:logInViewControllerDidFinish:)]){
        [self.delegate accountViewController:self logInViewControllerDidFinish:logInOrSignUp];
    }
}

-(void)signUpViewControllerDidTapSignUpButton:(MUISignUpViewController *)signUp{
    if([self.delegate respondsToSelector:@selector(accountViewController:signUpViewControllerDidTapSignUpButton:)]){
        [self.delegate accountViewController:self signUpViewControllerDidTapSignUpButton:signUp];
    }
}



#pragma mark - Table view data source

//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
//{
//    if(section != 0){
//        return;
//    }
//    UITableViewHeaderFooterView* headerView = (UITableViewHeaderFooterView *)view;
//    [self willDisplayHeaderView:headerView];
//}
//
//- (void)willDisplayHeaderView:(UITableViewHeaderFooterView *)headerView{
//    headerView.textLabel.text = @"Sign up for a free account in seconds.";
//    headerView.textLabel.textAlignment = NSTextAlignmentCenter;
//    if([self.delegate respondsToSelector:@selector(accountViewController:willDisplayHeaderView:)]){
//        [self.delegate accountViewController:self willDisplayHeaderView:headerView];
//    }
//}
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}
*/
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
