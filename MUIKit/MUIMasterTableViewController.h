//
//  MUIMasterTableViewController.h
//  MUIKit
//
//  Created by Malcolm Hall on 28/10/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//
// Selection can come from segue or from model changes. Also when in edit mode segues need to be disabled so rather than handle all that its best the table seclection delegate calls same method as the model changes.
#import <MHFoundation/MHFoundation.h>
#import <UIKit/UIKit.h>
#import <MUIKit/MUITableViewController.h>
#import <MUIKit/MUIMasterDetailContext.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MUIMasterTableViewControllerDataSource, MUIMasterTableViewControllerDelegate;

@interface MUIMasterTableViewController : MUITableViewController <MUIMasterViewControlling>//<UITableViewDelegate>

@property (nonatomic, assign) id<MUIMasterTableViewControllerDelegate> delegate;

- (void)updateTableSelectionForCurrentSelectedDetailItem;

// if it was a table cell and editing then prevents the segue.
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(nullable id)sender NS_REQUIRES_SUPER;

@end

@protocol MUIMasterTableViewControllerDelegate <NSObject>

@optional
- (NSIndexPath *)masterTableViewController:(MUIMasterTableViewController *)masterTableViewController indexPathForItem:(id)item;

@end

@protocol MUIMasterTableViewControllerDataSource <NSObject>

@end

NS_ASSUME_NONNULL_END
