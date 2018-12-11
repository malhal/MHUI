//
//  MCDFetchedResultsTableViewController.h
//  MCoreData
//
//  Created by Malcolm Hall on 7/12/13.
//  Copyright (c) 2013 Malcolm Hall. All rights reserved.
//

#import <MCoreData/MCoreData.h>
#import <MUIKit/MUIKit.h>
#import <MUIKit/MUITableFetchedDataSource.h>

NS_ASSUME_NONNULL_BEGIN

@class MUITableFetchedDataSource;
//@protocol MUIPrimaryTableFetchedDataSourceDelegate;

// default cell reuse identifier is Cell, so in storyboard set the table view to this or change it using the property.
// perform fetch is done in view will appear
// <ResultType : id<NSFetchRequestResult>>
@interface MUIPrimaryTableFetchedDataSource : MUITableFetchedDataSource <MUIMasterTableViewControllerDelegate> //<FetchedTableDataSourceDelegate, NSFetchedResultsControllerDelegate>

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController primaryTableViewController:(MUIMasterTableViewController *)primaryTableViewController;

//@property (strong, nonatomic, readonly) MUITableFetchedDataSource *fetchedTableDataSource;

@property (weak, nonatomic, readonly) MUIMasterTableViewController *primaryTableViewController;

//@property (nonatomic, assign) id<MUIPrimaryTableFetchedDataSourceDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
