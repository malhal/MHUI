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

#import "MUIFetchedMasterTableSelectionController.h"
#import "MUIFetchedTableRowsController.h"
//#import "NSManagedObjectContext+MCD.h"
#import <objc/runtime.h>

//static NSString * const kDefaultmessageWhenNoRows = @"There is no data available to display";
//static void * const kMCDFetchedResultsTableViewControllerKVOContext = (void *)&kMCDFetchedResultsTableViewControllerKVOContext;

//@interface MUIMasterTableSelectionController()
//@property (weak, nonatomic) MUITableViewController *tableViewController;
//@end

@interface MUIFetchedMasterTableSelectionController() <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong, nullable) id detailItemBeforeChangingContent;

@property (strong, nonatomic) NSIndexPath *indexPathOfDeletedObject;

@end

@interface UITableViewCell()
- (id)selectionSegueTemplate;
@end

@implementation MUIFetchedMasterTableSelectionController

//- (instancetype)initWithMasterController:(MUIMasterTableViewController *)masterSupport{
- (instancetype)initWithFetchedTableRowsController:(MUIFetchedTableRowsController *)fetchedTableRowsController{
    self = [super initWithTableViewController:fetchedTableRowsController.tableViewController];
    if (self) {
        fetchedTableRowsController.fetchedResultsControllerDelegate = self;
        _fetchedTableRowsController = fetchedTableRowsController;

        //masterTableViewController.delegate = self;
        //_masterTableViewController = masterTableViewController;
    }
    return self;
}

#pragma mark - Master Data Source

//- (id)masterTableViewController:(MUIMasterTableViewController *)masterTableViewController masterItemAtIndexPath:(NSIndexPath *)indexPath{
//    return [self.fetchedTableDataSource.fetchedResultsController objectAtIndexPath:indexPath];
//}

//- (NSIndexPath *)masterTableViewController:(MUIMasterTableViewController *)masterTableViewController indexPathForItem:(id)item{
//    return [self.fetchedTableRowsController.fetchedResultsController indexPathForObject:item];
//}

- (NSIndexPath *)indexPathForItem:(id)item{
    return [self.fetchedTableRowsController.fetchedResultsController indexPathForObject:item];
}

#pragma mark - Fetch Controller Delegate

//- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
  // self.detailItemBeforeChangingContent = [controller objectAtIndexPath:self.fetchedTableDataSource.selec]
//}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    //[super controller:controller didChangeObject:anObject atIndexPath:indexPath forChangeType:type newIndexPath:newIndexPath];
    //UITableView *tableView = self.tableView;
    //NSIndexPath *selectedIndexPath = self.indexPathOfDetailItem;
    switch(type) {
        case NSFetchedResultsChangeDelete:
        {
            if(anObject == self.tableViewController.mui_collapseControllerForMaster.detailViewController.detailItem){ //self.masterTableViewController.selectedMasterItem){
                self.indexPathOfDeletedObject = indexPath;
            }
            break;
        }
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    NSLog(@"controllerDidChangeContent");
    //self.detailItemBeforeChangingContent = nil;
    NSIndexPath *indexPathOfDeletedObject = self.indexPathOfDeletedObject;
    if(indexPathOfDeletedObject){
        self.indexPathOfDeletedObject = nil;
        
        NSIndexPath *indexPath = [self.fetchedTableRowsController.fetchedResultsController mcd_indexPathNearIndexPath:indexPathOfDeletedObject];//[self.masterTableViewController.tableView mui_indexPathNearIndexPath:indexPathOfDeletedObject];
        id object = [controller objectAtIndexPath:indexPath];
        //self.masterTableViewController.masterDetailContext.detailItem = object;
       // [self performSelector:@selector(malc:) withObject:object afterDelay:0];
        [self.delegate masterTableSelectionController:self didSelectItem:object];
        [self updateTableSelectionForCurrentSelectedDetailItem];
    }
}

//- (void)malc:(id)object{
//    [self.delegate fetchedMasterTableSelectionController:self didSelectObject:object];
//}

@end

