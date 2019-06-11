//
//  MUIMasterTableSelectionController.h
//  MUIKit
//
//  Created by Malcolm Hall on 28/10/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//
// Selection can come from segue or from model changes. Also when in edit mode segues need to be disabled so rather than handle all that its best the table seclection delegate calls same method as the model changes.
#import <MHFoundation/MHFoundation.h>
#import <UIKit/UIKit.h>
#import <MUIKit/MUITableViewController.h>
#import <MUIKit/MUICollapseController.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MUIMasterTableSelectionControllerDelegate, MUIMasterTableSelectionControllerDataSource;

@interface MUIMasterTableSelectionController : NSObject <MUITableViewControllerDelegate>  //<MUIMasterCollapsing>//<UITableViewDelegate>

@property (nonatomic, assign) id<MUIMasterTableSelectionControllerDelegate> delegate;

@property (nonatomic, assign) id<MUIMasterTableSelectionControllerDataSource> dataSource;

@property (strong, nonatomic, readonly) MUITableViewController *tableViewController;

- (void)updateTableSelectionForCurrentSelectedDetailItem;

// if it was a table cell and editing then prevents the segue.
//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(nullable id)sender NS_REQUIRES_SUPER;

- (NSIndexPath *)indexPathForItem:(id)item;

- (instancetype)initWithTableViewController:(MUITableViewController *)tableViewController;

@end

@protocol MUIMasterTableSelectionControllerDelegate <NSObject>

- (void)masterTableSelectionController:(MUIMasterTableSelectionController *)masterTableSelectionController didSelectItem:(id)item;

@end

@protocol MUIMasterTableSelectionControllerDataSource <NSObject>

- (NSIndexPath *)masterTableSelectionController:(MUIMasterTableSelectionController *)masterTableSelectionController indexPathForItem:(id)item;

@end

NS_ASSUME_NONNULL_END
