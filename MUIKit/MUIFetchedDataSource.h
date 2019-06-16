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
//#import "DataSource.h"

NS_ASSUME_NONNULL_BEGIN

//@protocol FetchedDataSourceDelegate;
@class MUITableViewController;

@interface MUIFetchedDataSource : NSObject <UITableViewDataSource>//, MalcsProtocol>

@property (strong, nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;

//@property (nonatomic, assign) id<UITableViewDataSource> tableViewDataSource;

@property (weak, nonatomic) MUITableViewController *tableViewController;

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController;

@end

@protocol FetchedDataSourceDelegate <NSObject>

//- (void)FetchedDataSource:(TableChangeManager *)tableChangeManager configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object;

@end

NS_ASSUME_NONNULL_END
