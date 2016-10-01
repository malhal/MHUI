//
//  MHUSignUpViewController.m
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 30/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MHUSignUpViewController.h"
#import "UIViewController+MHU.h"
#import "MHUEditableTableCell.h"

@implementation MHUSignUpViewController
@dynamic delegate;

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.emailCell.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.emailCell.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.emailCell.alwaysEditable = YES;
}

- (IBAction)signUpButtonTapped:(id)sender{
    [self didTapSignUpButton];
}

- (void)didTapSignUpButton{
    self.mhu_loading = YES;
    
    if([self.delegate respondsToSelector:@selector(signUpViewControllerDidTapSignUpButton:)]){
        [self.delegate signUpViewControllerDidTapSignUpButton:self];
    }
}

@end
