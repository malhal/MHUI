//
//  MCDFetchedResultsTableViewController.m
//  MCoreData
//
//  Created by Malcolm Hall on 7/12/13.
//  Copyright (c) 2013 Malcolm Hall. All rights reserved.
//
// clears selection on will appear (defaults yes).
// Trying if clears selection is off then means they want something always selected in landscape.

// Folders should not be selected like Notes when going back.

// We need the views updated in viewDidLoad instead of appear otherwise going back deselect row animation after restore doesn't appear.

// We can't have the folder remain selected

// If the most recent save is a background save then fetch controller cache is gone.

// Need to pick first cell in the table because otherwise get in a mess when collapsing.

#import "MUIPrimaryTableFetchedDataSource.h"
#import "MUITableFetchedDataSource.h"
//#import "NSManagedObjectContext+MCD.h"
#import <objc/runtime.h>

//static NSString * const kDefaultmessageWhenNoRows = @"There is no data available to display";
//static void * const kMCDFetchedResultsTableViewControllerKVOContext = (void *)&kMCDFetchedResultsTableViewControllerKVOContext;

@interface MUIPrimaryTableFetchedDataSource() <NSFetchedResultsControllerDelegate>

// used to help select a row close to the deleted one.
//@property (nonatomic, strong, nullable) NSIndexPath *selectionPathOfDeletedRow;
// used to differentiate between edit button and swipe to delete.
//@property (nonatomic, strong, nullable) NSIndexPath *tableViewEditingRowIndexPath;
// when entering edit the selected row is deselected so this hangs onto it so we can select a nearby row.
//@property (nonatomic, strong, nullable) NSIndexPath *selectedRowBeforeEditing;

//@property (nonatomic, assign) BOOL needsToUpdateViewsForCurrentFetchController;

//@property (strong, nonatomic, readwrite) MUITableFetchedDataSource *fetchedTableDataSource;

@property (nonatomic, strong, nullable) id detailItemBeforeChangingContent;
@property (strong, nonatomic) NSIndexPath *indexPathOfDeletedObject;

@end

@interface UITableViewCell()
- (id)selectionSegueTemplate;
@end

@implementation MUIPrimaryTableFetchedDataSource
@dynamic delegate;

//- (instancetype)initWithMasterController:(MUIPrimaryTableViewController *)masterSupport{
- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController primaryTableViewController:(MUIPrimaryTableViewController *)primaryTableViewController{
    self = [super initWithFetchedResultsController:fetchedResultsController tableView:primaryTableViewController.tableView];
    if (self) {
        primaryTableViewController.delegate = self;
        _primaryTableViewController = primaryTableViewController;
    }
    return self;
}

#pragma mark - Master Data Source

//- (id)primaryTableViewController:(MUIPrimaryTableViewController *)primaryTableViewController masterItemAtIndexPath:(NSIndexPath *)indexPath{
//    return [self.fetchedTableDataSource.fetchedResultsController objectAtIndexPath:indexPath];
//}

- (NSIndexPath *)primaryTableViewController:(MUIPrimaryTableViewController *)primaryTableViewController indexPathForItem:(id)item{
    return [self.fetchedResultsController indexPathForObject:item];
}

#pragma mark - Fetch Controller Delegate

//- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
  // self.detailItemBeforeChangingContent = [controller objectAtIndexPath:self.fetchedTableDataSource.selec]
//}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    [super controller:controller didChangeObject:anObject atIndexPath:indexPath forChangeType:type newIndexPath:newIndexPath];
    //UITableView *tableView = self.tableView;
    //NSIndexPath *selectedIndexPath = self.indexPathOfDetailItem;
    switch(type) {
        case NSFetchedResultsChangeDelete:
        {
            if(anObject == self.primaryTableViewController.secondaryViewController.secondaryItem){ //self.primaryTableViewController.selectedMasterItem){
                //Event *event = [controller objectAtIndexPath:indexPath];
                //self.highlightedEvent = event;
                //UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                //cell.
                self.indexPathOfDeletedObject = indexPath;
            }
            break;
        }
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [super controllerDidChangeContent:controller];
    NSLog(@"controllerDidChangeContent");
    //self.detailItemBeforeChangingContent = nil;
    if(self.indexPathOfDeletedObject){
        NSIndexPath *indexPath = [self.primaryTableViewController.tableView mui_indexPathNearIndexPath:self.indexPathOfDeletedObject];
        id object = [controller objectAtIndexPath:indexPath];
        self.primaryTableViewController.secondaryViewController.secondaryItem = object;
        [self.primaryTableViewController updateSelectionForCurrentSecondaryItem];
        
        //[self.primaryTableViewController selectMasterItem:object];
        
   //     [self.delegate selectionChangedByMasterTableFetchedDataSource:self];
        self.indexPathOfDeletedObject = nil;
    }
}

@end

