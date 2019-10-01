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
@interface MUIMasterViewController : UIViewController <UIDataSourceModelAssociation, NSFetchedResultsControllerDelegate>

//@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) UIViewController<MUIDetail> *detailViewController;

@property (strong, nonatomic) NSPersistentContainer *persistentContainer;
//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext; // despite needing a master item it also needs this otherwise can fail when masterItem is deleted and has lost its context.

@property (strong, nonatomic, readonly) __kindof NSManagedObject *objectForShowDetail;

- (instancetype)initWithCoder:(NSCoder *)coder persistentContainer:(NSPersistentContainer *)persistentContainer;

- (void)performShowDetailWithObject:(NSManagedObject *)object;

@end

@protocol MUIDetail <NSObject>

@property (strong, nonatomic) NSManagedObject *detailItem;

@end
