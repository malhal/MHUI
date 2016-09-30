//
//  MHUSignUpViewController.m
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 30/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHUSignUpViewController.h"

@implementation MHUSignUpViewController
@dynamic delegate;

- (IBAction)signUpButtonTapped:(id)sender{
    self.mhu_loading = YES;
    
    if([self.delegate respondsToSelector:@selector(signUpViewControllerDidTapSignUpButton:)]){
        [self.delegate signUpViewControllerDidTapSignUpButton:self];
    }
}


@end
