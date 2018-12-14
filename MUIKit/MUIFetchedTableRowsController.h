//
//  MUIFetchedTableRowsController.h
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

@interface MUIFetchedTableRowsController<CellObject : NSManagedObject<MUITableViewCellObject> *> : NSObject <UITableViewDataSource, NSFetchedResultsControllerDelegate>

// todo delegates might need reset after changing stuff since the classes cache them.

- (instancetype)initWithTableView:(UITableView *)tableView;

@property (nonatomic, assign) id<FetchedTableDataSourceDelegate> delegate;

@property (nonatomic, assign) id<NSFetchedResultsControllerDelegate> fetchedResultsControllerDelgate;

//@property (strong, nonatomic) NSFetchedResultsController<CellObject> *fetchedResultsController;

@property (strong, nonatomic) NSFetchedResultsController<CellObject> *fetchedResultsController;

@property (weak, nonatomic, readonly) UITableView *tableView;

@property (nonatomic, assign) id<UITableViewDataSource> tableDataSource;

@end

@protocol FetchedTableDataSourceDelegate <NSObject>

@optional

//- (void)updateForFetchedDataSource:(MUIFetchedTableRowsController *)fetchedDataSource;

- (void)fetchedTableRowsController:(MUIFetchedTableRowsController *)fetchedTableRowsController configureCell:(UITableViewCell *)cell withObject:(NSManagedObject<MUITableViewCellObject> *)object;

@end

NS_ASSUME_NONNULL_END
