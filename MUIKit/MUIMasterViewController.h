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

@protocol MUIDetail;

// reason this is a subclass is so it has access to setEditing
@interface MUIMasterViewController : UIViewController <UIDataSourceModelAssociation, NSFetchedResultsControllerDelegate, MUIFetchedTableViewControllerDelegate>

//@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) MUIFetchedTableViewController *fetchedTableViewController;
 
// UI is bound to the detail item. It can't be because when tracking the deletes its no longer up to date.
// maybe it can cause we only want selected row when its showing.
//@property (strong, nonatomic) UIViewController<MUIDetail> *detailViewController;

@property (strong, nonatomic) NSPersistentContainer *persistentContainer;
//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext; // despite needing a master item it also needs this otherwise can fail when masterItem is deleted and has lost its context.

@property (strong, nonatomic, readonly) __kindof NSManagedObject *selectedObject;

- (instancetype)initWithCoder:(NSCoder *)coder persistentContainer:(NSPersistentContainer *)persistentContainer;

- (void)showDetailWithObject:(NSManagedObject *)object;

//@property (strong, nonatomic) NSManagedObject *detailViewControllerDetailItem;

@end

@protocol MUIDetail <NSObject>

//@property (strong, nonatomic) NSManagedObject *detailItem;

@end
