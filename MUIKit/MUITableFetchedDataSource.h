//
//  MUITableFetchedDataSource.h
//  MCoreData
//
//  Created by Malcolm Hall on 15/09/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <MHFoundation/MHFoundation.h>
#import <MCoreData/MCoreData.h>
#import <MUIKit/MUITableViewCellObject.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FetchedTableDataSourceDelegate;

@interface MUITableFetchedDataSource<CellObject : NSManagedObject<MUITableViewCellObject> *> : NSObject <UITableViewDataSource, NSFetchedResultsControllerDelegate>

//- (instancetype)initWithTableView:(UITableView *)tableView;

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController tableView:(UITableView *)tableView;

@property (nonatomic, assign) id<FetchedTableDataSourceDelegate> delegate;

@property (nonatomic, assign) id<NSFetchedResultsControllerDelegate> fetchedResultsControllerDelgate;

//@property (strong, nonatomic) NSFetchedResultsController<CellObject> *fetchedResultsController;

@property (assign, nonatomic, readonly) NSFetchedResultsController<CellObject> *fetchedResultsController;

//@property (weak, nonatomic, readonly) UITableView *tableView;

@property (nonatomic, assign) id<UITableViewDataSource> tableDataSource;

@end

@protocol FetchedTableDataSourceDelegate <NSObject>

@optional

//- (void)updateForFetchedDataSource:(MUITableFetchedDataSource *)fetchedDataSource;

- (void)fetchedTableDataSource:(MUITableFetchedDataSource *)fetchedTableDataSource configureCell:(UITableViewCell *)cell withObject:(NSManagedObject<MUITableViewCellObject> *)object;

@end

NS_ASSUME_NONNULL_END
