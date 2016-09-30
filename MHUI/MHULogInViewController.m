//
//  MHUIAuthActionViewController.m
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 30/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHULogInViewController.h"
#import "UIViewController+MHU.h"
#import "UIAlertController+MHU.h"

@implementation MHULogInViewController
 
-(IBAction)logInButtonTapped:(id)sender{
    self.mhu_loading = YES;
    
    if([self.delegate respondsToSelector:@selector(logInViewControllerDidTapLogInButton:)]){
        [self.delegate logInViewControllerDidTapLogInButton:self];
    }
}
    
-(void)didError:(NSError*)error{
    self.mhu_loading = NO;
    
    UIAlertController *alert = [UIAlertController mhu_alertControllerWithTitle:@"Auth Error" message:error.localizedDescription];
    [self presentViewController:alert animated:YES completion:nil];
    
    if([self.delegate respondsToSelector:@selector(logInViewController:didError:)]){
        [self.delegate logInViewController:self didError:error];
    }
}

// Match Calendar adding events and bring the keyboard up after the view appears.
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_usernameTextField becomeFirstResponder];
}

-(void)didFinish{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if([self.delegate respondsToSelector:@selector(logInViewControllerDidFinish:)]){
        [self.delegate logInViewControllerDidFinish:self];
    }
}

@end
