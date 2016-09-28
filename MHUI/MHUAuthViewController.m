//
//  MHUAuthViewController.m
//  MHUI
//
//  Created by Malcolm Hall on 11/04/2015.
//  Copyright (c) 2015 Malcolm Hall. All rights reserved.
//

#import "MHUAuthViewController.h"
#import "UINavigationItem+MHU.h"

@interface MHUAuthViewController ()

@end

@implementation MHUAuthViewController

/*
+(UINavigationController *)presentFromViewController:(UIViewController*)viewController{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Auth" bundle:nil];
    UINavigationController *nav = (UINavigationController*)[sb instantiateInitialViewController];
    [viewController presentViewController:nav animated:YES completion:nil];
    
    return nav;
}
*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    // pass through the delegate.
    MHUAuthViewController *auth = (MHUAuthViewController *)segue.destinationViewController;
    auth.delegate = self.delegate;
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
    //NSLog(@"loaded");
}

// only used from initial view
-(IBAction)cancelButtonTapped:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    if([self.delegate respondsToSelector:@selector(authViewControllerDidTapCancelButton:)]){
        [self.delegate authViewControllerDidTapCancelButton:self];
    }
}

// Match Calendar adding events and bring the keyboard up after the view appears.
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_usernameTextField becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setLoading:(BOOL)loading{
    if(_loading == loading){
        return;
    }
    self.view.userInteractionEnabled = !loading;
    self.navigationItem.rightBarButtonItem.enabled = !loading;
    self.navigationItem.hidesBackButton = loading;
    if(loading){
        [self.navigationItem mhu_beginTitleRefreshing];
    }else{
        [self.navigationItem mhu_endTitleRefreshing];
    }
    _loading = loading;
}

-(void)didError:(NSError*)error{
    NSString* message = @"Invalid credentials";
    // change if its another reason
    if(error){
        message = error.localizedDescription;
    }
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              
                                                              
                                                          }];
    // set loading after button pressed?
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    self.loading = NO;
    if([self.delegate respondsToSelector:@selector(authViewController:didError:)]){
        [self.delegate authViewController:self didError:error];
    }
}

-(IBAction)logInButtonTapped:(id)sender{
    if([self.delegate respondsToSelector:@selector(authViewControllerDidTapLogInButton:)]){
        [self.delegate authViewControllerDidTapLogInButton:self];
    }
}

-(IBAction)signUpButtonTapped:(id)sender{
    if([self.delegate respondsToSelector:@selector(authViewControllerDidTapSignUpButton:)]){
        [self.delegate authViewControllerDidTapSignUpButton:self];
    }
}

-(void)didFinish{
    [self dismissViewControllerAnimated:YES completion:nil];
    if([self.delegate respondsToSelector:@selector(authViewControllerDidFinish:)]){
        [self.delegate authViewControllerDidFinish:self];
    }
}

#pragma mark - Table view data source
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
