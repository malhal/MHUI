//
//  TableDataSource.h
//  ScrollPosition
//
//  Created by Malcolm Hall on 09/04/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <MCoreData/MCoreData.h>
#import <MHFoundation/MHFoundation.h>
#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@class MUIFetchedTableDataSource;

//@protocol MUIFetchedTableDataSourceDelegate<NSObject>
//
//- (void)fetchedTableDataSource:(MUIFetchedTableDataSource *)fetchedTableDataSource configureCell:(UITableViewCell *)cell withObject:(id)object;
//
//@end

@interface MUIFetchedTableDataSource : NSObject<UITableViewDataSource>

@property (strong, nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)controller;

// defaults to NSObject : Cell
//@property (strong, nonatomic) NSDictionary *cellIdentifiersByClassName;

//@property (weak, nonatomic) id<MUIFetchedTableDataSourceDelegate> delegate;

- (UITableViewCell *)cellForObject:(id)object atIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView;

- (void)configureCell:(UITableViewCell *)cell withObject:(id)object inTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
