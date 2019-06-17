//
//  FetchedDataSource.h
//  CloudEvents
//
//  Created by Malcolm Hall on 05/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <MUIKit/MUIDefines.h>
//#import <MUIKit/MUITableViewController.h>
#import <MUIKit/MUIObjectDataSource.h>

NS_ASSUME_NONNULL_BEGIN

//@protocol MUIFetchedDataSourceDelegate;
@class MUITableViewController, MUIFetchedSelectionManager;

@interface MUIFetchedDataSource : MUIObjectDataSource <NSFetchedResultsControllerDelegate>//, MalcsProtocol>

@property (strong, nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController;

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object;

//@property (weak, nonatomic) id<NSFetchedResultsControllerDelegate> fetchedResultsControllerDelegate;

//@property (weak, nonatomic) id<MUIFetchedDataSourceDelegate> delegate;

- (void)registerReuseIdentifier:(NSString *)reuseIdentifier forObjectOfClass:(Class)class;

@property (strong, nonatomic) MUIFetchedSelectionManager *fetchedSelectionManager;

@end



NS_ASSUME_NONNULL_END
