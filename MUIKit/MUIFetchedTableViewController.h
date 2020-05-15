//
//  MUIFetchedTableViewController.h
//  MUIKit
//
//  Created by Malcolm Hall on 05/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//
#import <MCoreData/MCoreData.h>
#import <MHFoundation/MHFoundation.h>
#import <UIKit/UIKit.h>
//#import <MUIKit/MUIDefines.h>
//#import <MUIKit/MUIFetchedDataSource.h>
#import <MUIKit/MUITableViewController.h>
//#import <MUIKit/MUIDataSource.h>
//#import <MUIKit/MUIMasterTable.h>

NS_ASSUME_NONNULL_BEGIN

//extern NSString * const MUIFetchedTableViewControllerSelectedObjectDidUpdateNotification;

@protocol MUIFetchedTableViewControllerDelegate;

// only put table stuff in here
@interface MUIFetchedTableViewController<ResultType:id<NSFetchRequestResult>> : MUITableViewController <NSFetchedResultsControllerDelegate, UIDataSourceModelAssociation>{
    //@protected
    //NSFetchedResultsController *_fetchedResultsController;
}

//- (instancetype)initWithTableViewController:(UITableViewController *)tableViewController;

//@property (strong, nonatomic, readonly) NSManagedObject *selectedObject;

@property (strong, nonatomic) NSFetchedResultsController<ResultType> *fetchedResultsController;

//@property (weak, nonatomic) id<NSFetchedResultsControllerDelegate> fetchedResultsDelegate;

//@property (weak, nonatomic, readonly) UITableViewController *tableViewController;

// the default implementation sets the accessory depending on push.
- (void)configureCell:(UITableViewCell *)cell withObject:(ResultType)object;

//- (void)selectObject:(id)object;

// calls tableViewDidEndEditing after the animations end, so table rows can be reselected.
//- (void)setEditing:(BOOL)editing animated:(BOOL)animated NS_REQUIRES_SUPER;

// disables the edit button
//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;

// enables the edit button and delay invokes tableViewDidEndEditing
//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath NS_REQUIRES_SUPER;

@property (assign, nonatomic) id<MUIFetchedTableViewControllerDelegate> delegate;

// removed this because its ok for it to be nil.
//- (void)createFetchedResultsController;

@end

@protocol MUIFetchedTableViewControllerDelegate<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
@optional

- (void)fetchedTableViewController:(MUIFetchedTableViewController *)fetchedTableViewController configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object;

@end

//@interface UITableViewController (MUIFetchedTableViewController)
//
//@property (strong, nonatomic) MUIFetchedTableViewController *mui_fetchedTableViewController;
//
//@end

NS_ASSUME_NONNULL_END
