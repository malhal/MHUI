//
//  MCDFetchedResultsTableViewController.h
//  MCoreData
//
//  Created by Malcolm Hall on 7/12/13.
//  Copyright (c) 2013 Malcolm Hall. All rights reserved.
//

#import <MCoreData/MCoreData.h>
#import <MUIKit/MUIMasterTableSelectionController.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MUIFetchedMasterTableSelectionControllerDelegate;
@class MUIFetchedTableRowsController;

// default cell reuse identifier is Cell, so in storyboard set the table view to this or change it using the property.
// perform fetch is done in view will appear
// <ResultType : id<NSFetchRequestResult>>
@interface MUIFetchedMasterTableSelectionController : MUIMasterTableSelectionController // <NSFetchedResultsControllerDelegate, MUIMasterTableViewControllerDelegate> // <FetchedTableDataSourceDelegate, >

- (instancetype)initWithFetchedTableRowsController:(MUIFetchedTableRowsController *)fetchedTableRowsController;// masterTableViewController:(MUIMasterTableViewController *)masterTableViewController; //masterTableViewController:(MUIMasterTableViewController *)masterTableViewController;

- (instancetype)initWithTableViewController:(MUITableViewController *)tableViewController NS_UNAVAILABLE;

@property (strong, nonatomic) MUIFetchedTableRowsController *fetchedTableRowsController;

//@property (assign, nonatomic, readonly) MUIMasterTableViewController *masterTableViewController;

//@property (nonatomic, assign) id<MUIFetchedMasterTableSelectionControllerDelegate> delegate;

@end

//@protocol MUIFetchedMasterTableSelectionControllerDelegate <NSObject>
//
//- (void)fetchedMasterTableSelectionController:(MUIFetchedMasterTableSelectionController *)fetchedMasterTableSelectionController didSelectObject:(id)object;
//
//@end

NS_ASSUME_NONNULL_END
