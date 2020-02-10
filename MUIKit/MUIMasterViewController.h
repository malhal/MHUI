//
//  MasterViewController.h
//  MUIFetchedMasterDetail
//
//  Created by Malcolm Hall on 16/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <MUIKit/MUIKit.h>
#import <CoreData/CoreData.h>

// URI

extern NSString * const MasterViewControllerStateRestorationDetailViewControllerKey;

// reason this is a subclass is so it has access to setEditing
@interface MUIMasterViewController : UIViewController <UIDataSourceModelAssociation, NSFetchedResultsControllerDelegate, MUIFetchedTableViewControllerDelegate>

//@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) MUIFetchedTableViewController *fetchedTableViewController;
 
// UI is bound to the detail item. It can't be because when tracking the deletes its no longer up to date.
// maybe it can cause we only want selected row when its showing.
//@property (strong, nonatomic) UIViewController<MUIDetail> *detailViewController;

//@property (strong, nonatomic) NSPersistentContainer *persistentContainer;
//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext; // despite needing a master item it also needs this otherwise can fail when masterItem is deleted and has lost its context.

@property (strong, nonatomic, readonly) __kindof NSManagedObject *selectedObject;

//@property (weak, assign) id<> delegate;

// - (instancetype)initWithCoder:(NSCoder *)coder persistentContainer:(NSPersistentContainer *)persistentContainer;

- (void)showViewControllerForObject:(NSManagedObject *)object;

// @property (strong, nonatomic) NSManagedObject *detailViewControllerDetailItem;

@property (strong, nonatomic) UISplitViewController *resolvedSplitViewController;

@end

@interface UIViewController (MUIMasterViewController)

//- (id)mui_detailItemWithSender:(id)sender;
//
//- (void)mui_setDetailItem:(id)detailItem sender:(id)sender;

@end
