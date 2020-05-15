//
//  MUIMasterTableViewController.h
//  MUIKit
//
//  Created by Malcolm Hall on 04/03/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//
#import <MCoreData/MCoreData.h>
#import <MHFoundation/MHFoundation.h>
#import <UIKit/UIKit.h>
#import <MUIKit/MUIFetchedTableViewController.h>

NS_ASSUME_NONNULL_BEGIN

@interface MUIMasterTableViewController : MUIFetchedTableViewController <UINavigationControllerDelegate>

- (NSObject *)detailItemInDetailNavigationController:(UINavigationController *)navigation;

@property (strong, nonatomic) UINavigationController *detailNavigationController;

@end

@interface UIViewController (MUIMasterTableViewController)

- (UIViewController *)mui_currentDetailViewControllerWithSender:(id)sender;

@end

NS_ASSUME_NONNULL_END
