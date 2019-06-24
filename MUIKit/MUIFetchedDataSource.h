//
//  FetchedDataSource.h
//  CloudEvents
//
//  Created by Malcolm Hall on 05/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MCoreData/MCoreData.h>
#import <MUIKit/MUIDefines.h>
//#import <MUIKit/MUITableViewController.h>
#import <MUIKit/MUIDataSource.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MUIFetchedDataSourceDelegate;
@class MUITableViewController;

@interface MUIFetchedDataSource : MUIDataSource <NSFetchedResultsControllerDelegate>//, MalcsProtocol>

@property (strong, nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController;

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object;

//@property (weak, nonatomic) id<NSFetchedResultsControllerDelegate> fetchedResultsControllerDelegate;

//@property (weak, nonatomic) id<MUIFetchedDataSourceDelegate> delegate;

@end

@protocol MUIFetchedDataSourceDelegate <NSObject>

- (void)fetchedDataSourceDidSetDelegate:(MUIFetchedDataSource *)fetchedDataSource;

@end


NS_ASSUME_NONNULL_END
