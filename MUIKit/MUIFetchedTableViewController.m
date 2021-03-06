//
//  MUIFetchedTableViewController.m
//  MUIKit
//
//  Created by Malcolm Hall on 05/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUIFetchedTableViewController.h"
//#import "MUIDataSource_Internal.h"
#import "MUITableView.h"
#import "UITableView+MUI.h"
#import "UIViewController+MUIShowing.h"
#import "UIViewController+MUI.h"
#import "UINavigationController+MUI.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import "UITableViewController+MUI.h"
#import "MUIFetchedTableDataSource.h"

//NSString * const MUIFetchedTableViewControllerSelectedObjectDidUpdateNotification = @"MUIFetchedTableViewControllerSelectedObjectDidUpdateNotification";

@interface MUIFetchedTableViewController()

//@property (strong, nonatomic, readwrite) NSManagedObject *selectedObject;
@property (assign, nonatomic) BOOL sectionsCountChanged;

//@property (strong, nonatomic) NSBlockOperation *tableUpdates;

//@property (assign, nonatomic) BOOL didBeginUpdatingFromFetchedResultsController;
//@property (assign, nonatomic) BOOL wasDisplayed;
//@property (assign, nonatomic) BOOL needsTableViewUpdates;
//@property (assign, nonatomic) BOOL tableViewBeginUpdatesWasCalled;
//@property (assign, nonatomic) BOOL reloadTableOnNextAppear;
@property (assign, nonatomic) BOOL isEditingRow;
//@property (strong, nonatomic) UIViewController *shownViewController;
@property (strong, nonatomic) NSMutableArray *selectedObjects;

//@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation MUIFetchedTableViewController

- (void)setFetchedTableDataSource:(MUIFetchedTableDataSource *)fetchedTableDataSource{
    if(fetchedTableDataSource == _fetchedTableDataSource){
        return;
    }
    _fetchedTableDataSource = fetchedTableDataSource;
    UITableView *tableView = (UITableView *)self.viewIfLoaded;
    tableView.dataSource = fetchedTableDataSource;
    [tableView reloadData];
}

//- (void)setFetchRequest:(NSFetchRequest *)fetchRequest{
//    if([fetchRequest isEqual:_fetchRequest]){ // does deep compare
//        return;
//    }
//    _fetchRequest = fetchRequest;
//    self.fetchedTableDataSource.fetchedResultsController = [self newFetchedResultsController];
//    [self configureView];
//}

//- (NSManagedObject *)objectAtIndexPath:(NSIndexPath *)indexPath{
//    return [self.fetchedTableDataSource.fetchedResultsController objectAtIndexPath:indexPath];
//}
//
//- (NSManagedObject *)selectedObject{
//    return self.selectedObjects.firstObject;
//}
//
//- (NSArray *)fetchedObjects{
//    return self.fetchedTableDataSource.fetchedResultsController.fetchedObjects;
//}
//
//- (NSMutableArray *)selectedObjects{
//    if(!_selectedObjects){
//        _selectedObjects = NSMutableArray.array;
//    }
//    return _selectedObjects;
//}

//- (void)selectObject:(NSManagedObject *)object{
//    [self selectObject:object userDriven:NO];
//}
//
// cant do this cause need way to remember the selection
//- (void)selectObject:(NSManagedObject *)object userDriven:(BOOL)userDriven{
//    if(self.tableView.isEditing){
//        if(!self.tableView.allowsMultipleSelectionDuringEditing){
//            [self.selectedObjects removeAllObjects];
//        }
//    }else{
//        if(!self.tableView.allowsMultipleSelection){
//            [self.selectedObjects removeAllObjects];
//        }
//    }
//    [self.selectedObjects addObject:object];
//    if(!userDriven){
//        NSIndexPath *indexPath = [self.fetchedTableDataSource.fetchedResultsController indexPathForObject:object];
//        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//    }
//}

- (void)setSelectedObject:(NSManagedObject *)selectedObject{
    if(selectedObject == _selectedObject){
        return;
    }
    _selectedObject = selectedObject;
    //NSIndexPath *indexPath = [self.fetchedTableDataSource.fetchedResultsController indexPathForObject:selectedObject];
    //[self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

//- (void)deselectObject:(NSManagedObject *)object{
//    [self deselectObject:object userDriven:NO];
//}
//
//- (void)deselectObject:(NSManagedObject *)object userDriven:(BOOL)userDriven{
//    [self.selectedObjects removeObject:object];
//    if(!userDriven){
//        NSIndexPath *indexPath = [self.fetchedTableDataSource.fetchedResultsController indexPathForObject:object];
//        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
//    }
//}

//- (void)setFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController{
//    if(fetchedResultsController == _fetchedResultsController){
//        return;
//    }
//    else if(_fetchedResultsController.delegate == self){
//        _fetchedResultsController.delegate = nil;
//        fetchedResultsController.delegate = self;
//    }
//    _fetchedResultsController = fetchedResultsController;
//    [self configureView];
//}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
//    if(!editing){
//        [self.selectedObjects removeAllObjects];
//    }
    [super setEditing:editing animated:animated];
    //    if(self.isEditingRow){
    //        self.isEditingRow = NO;
    //        return;
    //    }
}


//- (void)selectObject:(NSManagedObject *)object{
//    [self selectObject:object notifyWithSender:nil selectRow:YES];
//}

//- (void)selectObject:(id)object notifyWithSender:(nullable id)sender selectRow:(BOOL)selectRow{
//    self.selectedObject = object;
//    if(selectRow && self.isViewLoaded){
//        [self updateTableViewForSelectedObjectIfNecessary];
//    }
//    if(sender){
//        [self didSelectObject:object sender:sender];
//    }
//    [self reselectTableRowIfNecessaryScrollToSelection:YES];
//}

//- (void)didSelectObject:(id)object sender:(id)sender{
//    if([self.delegate respondsToSelector:@selector(fetchedTableViewController:didSelectObject:sender:)]){
//        [self.delegate fetchedTableViewController:self didSelectObject:object sender:sender];
//    }
//}

//- (void)updateTableViewForSelectedObjectIfNecessary{
    
//    if(!self.isFetchedResultsControllerCreated){
//        return;
//    }
   // id object = self.selectedObject;
//    if(self.navigationController.topViewController == self && [self shouldPushForObject:object]){
//        return;
//    }
//    else
//    if([self.fetchedTableDataSource.fetchedResultsController.fetchedObjects containsObject:object]){
//        [self selectTableRowIfNecessaryForObject:object scrollToSelection:NO];
//    }
//    else if(object){
//        id o = self.fetchedTableDataSource.fetchedResultsController.fetchedObjects.firstObject;
//        [self selectObject:o notifyWithSender:self selectRow:YES];
//    }
    
    //    NSIndexPath *indexPath = [self.dataSource indexPathForObject:object inView:self.tableView];
    //    if(!indexPath){
    //        return;
    //    }
    
    // this needs to reselect if we are the top controller and in landscape or we are pushed on the stack.
    //    UIViewController *vc = self.tableViewController;
    //    if(vc.navigationController.topViewController == vc){
    //        if([self shouldPushForIndexPath:indexPath]){
    //            return;
    //        }
    //    }
    //  [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:];
//    [self updateTableViewForSelectedObject];
//
//}

//- (void)updateTableViewForSelectedObject{
//
//}

//- (void)selectTableRowIfNecessaryForObject:(id)object scrollToSelection:(BOOL)scrollToSelection{
//    if(self.tableView.isEditing){
//        return;
//    }
//    [self selectTableRowForObject:object scrollToSelection:scrollToSelection];
//}

//- (void)selectTableRowForObject:(id)object scrollToSelection:(BOOL)scrollToSelection{
//    NSIndexPath *indexPath = [self.fetchedTableDataSource.fetchedResultsController indexPathForObject:object];
//    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:scrollToSelection ? UITableViewScrollPositionMiddle : UITableViewScrollPositionNone];
//}

//- (BOOL)shouldSelectRowForObject:(id)object{
//    return YES;
//}
//- (void)tableViewDidMoveToWindow:(MUITableView *)tableView{
//    if(!tableView.window){
//        return;
//    }
//    NSLog(@"NOW");
//    id object = self.selectedObject;
//    if(object){
//        if([self.tableObjectsController indexPathForObject:object]){
//            // if the object is in the data source nothing to do
//            return;
//        }
//    }
//    else if(!self.tableObjectsController.objects.count){
//        // we don't have a selected object and there is none to select
//        return;
//    }
//    object = self.tableObjectsController.objects.firstObject; // we might have had a selected object but now might have none
//    if(object){
//        NSIndexPath *ip = [self.tableObjectsController indexPathForObject:object];
//        if(![self shouldShowDetailForIndexPath:ip]){
//            return;
//        }
//    }
//[self updateCurrentObject:object notifyDelegate:YES];
//[self reselectTableRowIfNecessary];
//}


//- (id<MUIDataSourceObjectShowing>)dataSource{
//    return (id<MUIDataSourceObjectShowing>)self.tableView.dataSource;
//}


//- (BOOL)shouldPushForObject:(id)object{
//    if([self shouldShowDetailForObject:object]){
//        return [self mui_willShowingDetailViewControllerPushWithSender:self];
//    }else{
//        return [self mui_willShowingViewControllerPushWithSender:self];
//    }
//}

//- (BOOL)shouldShowDetailForObject:(id)object{
//    if([self.delegate respondsToSelector:@selector(fetchedTableViewController:shouldShowDetailForObject:)]){
//        return [self.delegate fetchedTableViewController:self shouldShowDetailForObject:object];
//    }
//    return YES;
//}

//#pragma mark - View Controller

//- (void)showViewController:(UIViewController *)vc sender:(id)sender{
//    [self.parentViewController showViewController:vc sender:sender];
//    self.shownViewController = vc;
//    NSString *s = UIViewControllerShowDetailTargetDidChangeNotification;
//    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(navigationControllerDidShowViewController:) name:MUINavigationControllerDidShowViewControllerNotification object:self.navigationController];
//}

// called after child's didMoveToParentViewController
//- (void)navigationControllerDidShowViewController:(NSNotification *)notification{
//    UIViewController *nextVisible = notification.userInfo[@"UINavigationControllerNextVisibleViewController"];
//    if(nextVisible != self){
//        return;
//    }
//    UIViewController *lastVisible = notification.userInfo[@"UINavigationControllerLastVisibleViewController"];
//    UIViewController *shownViewController = self.shownViewController;
//    if(lastVisible == shownViewController){
//        [NSNotificationCenter.defaultCenter removeObserver:self name:@"UINavigationControllerDidShowViewControllerNotification" object:self.navigationController];
//        [self.shownViewController willMoveToParentViewController:self];
//        [self addChildViewController:self.shownViewController];
//        [self.shownViewController didMoveToParentViewController:self];
//    }
//}

- (void)viewWillAppear:(BOOL)animated{

 //NSArray *a = self.navigationController.viewControllers;
  //  [self.tableView reloadData];
    
   // BOOL b = self.currentDetailNavigationController.mui_isViewVisible;
    
//    if(self.isEditing || self.clearsSelectionOnViewWillAppear){
//
//    }
   // self.clearsSelectionOnViewWillAppear = !self.isMovingToParentViewController;
    
    //[self configureView];
    
    /*
    if(self.clearsSelectionOnViewWillAppear){
        id <UIViewControllerTransitionCoordinator> transitionCoordinator;
        if((transitionCoordinator = self.transitionCoordinator)){
            [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                for(NSIndexPath *indexPath in self.tableView.indexPathsForSelectedRows){
                    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                    if(cell){
                        [cell setNeedsLayout];
                    }
                }
            } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                if(context.cancelled){
                    
                }
                else{
                    [self.selectedObjects removeAllObjects];
                 //   [self configureView];
                }
            }];
        }
    }else{
      //  [self.selectedObjects removeAllObjects];
    //    [self configureView];
    }
    */
    [super viewWillAppear:animated];
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//
    // runs all the changes since the fetch controller was cached.
    //[self.managedObjectContext processPendingChanges];
//}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
  //  self.fetchedTableDataSource.fetchedResultsController.delegate = nil;
   // [NSNotificationCenter.defaultCenter removeObserver:self name:UIViewControllerShowDetailTargetDidChangeNotification object:nil];
    //self.fetchedTableDataSource.fetchedResultsController.delegate = nil;
}

- (void)configureView{
    UITableView *tableView = self.mui_tableViewIfLoaded;
    if(!tableView){
        return;
    }
    NSFetchedResultsController *fetchedResultsController = self.fetchedTableDataSource.fetchedResultsController;
    if(!fetchedResultsController.delegate){
        fetchedResultsController.delegate = self;
        NSError *error;
        if(![fetchedResultsController performFetch:&error]){
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [tableView reloadData];
    }
    tableView.separatorStyle = fetchedResultsController.fetchedObjects.count ? UITableViewCellSeparatorStyleSingleLine : UITableViewCellSeparatorStyleNone;
    
//    for(NSManagedObject *selectedObject in self.selectedObjects){
//        NSIndexPath *indexPath = [self.fetchedTableDataSource.fetchedResultsController indexPathForObject:selectedObject];
//        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//    }
}



#pragma mark Table Delegate

//- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UIContextualAction *delete = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive
//                                                                         title:@"Delete"
//                                                                       handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
//        completionHandler(YES);
//    }];
//    delete.backgroundColor = [UIColor redColor];
//    UISwipeActionsConfiguration *swipeActionConfig = [UISwipeActionsConfiguration configurationWithActions:@[delete]];
//    return swipeActionConfig;
//}



- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 //   if(!tableView.isEditing){
        // todo check if it is a selectable one
     //   id object = [self.fetchedTableDataSource.fetchedResultsController objectAtIndexPath:indexPath];
      //  [self selectObject:object notifyWithSender:tableView selectRow:NO];
    //}
  //  NSManagedObject *object = [self.fetchedTableDataSource.fetchedResultsController objectAtIndexPath:indexPath];
   // [self selectObject:object userDriven:YES];
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!self.isEditing){
        NSManagedObject *object = [self.fetchedTableDataSource.fetchedResultsController objectAtIndexPath:indexPath];
        // don't show if in landscape and the object is already selected.
        //self.selectionIsUserDriven = YES;
        //[self setSelectedObject:object show:YES];
      //  self.selectedObject = object;
        //[self _showViewControllerForObject:object];
        //self.selectionIsUserDriven = NO;
    }
    //tableView.dataSource //
    //self.selectedModelItemIdentifier = [self modelIdentifierForElementAtIndexPath:indexPath inView:tableView];

}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //self.selectedModelItemIdentifier = nil;
  //  NSManagedObject *object = [self.fetchedTableDataSource.fetchedResultsController objectAtIndexPath:indexPath];
   // [self deselectObject:object userDriven:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if([self.tableDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]){
//        [self.tableDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
//    }
     id object = [self.fetchedTableDataSource.fetchedResultsController objectAtIndexPath:indexPath];
    [self configureCell:cell withObject:object];
}

- (void)configureCell:(UITableViewCell *)cell withObject:(id)object{
//    if([self.delegate respondsToSelector:@selector(fetchedTableViewController:configureCell:withObject:)]){
//        [self.delegate fetchedTableViewController:self configureCell:cell withObject:object];
//    }
}

//- (void)updateCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object{
//    BOOL push = [self shouldPushForObject:object];
////    // Only show a disclosure indicator if we're pushing
//    if (push) {
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    } else {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//    if([self.delegate respondsToSelector:@selector(fetchedTableViewController:updateCell:withObject:)]){
//        [self.delegate fetchedTableViewController:self updateCell:cell withObject:object];
//    }
//}

- (void)tableViewDidEndEditing:(MUITableView *)tableView{
   // [self updateTableViewForSelectedObjectIfNecessary];
}

#pragma mark View Controller

//- (UIViewController *)targetViewControllerForAction:(SEL)action sender:(id)sender{
//
//    UIViewController *target = [super targetViewControllerForAction:action sender:sender];
//    if(!target){
//        target = [self.delegate targetViewControllerForAction:action sender:sender];
//    }
//    return target;
//}

#pragma mark - Table View



#pragma mark - Fetched results controller

//- (NSFetchedResultsController *)newFetchedResultsController{
//    //if(!_fetchedResultsController){
////        [self createFetchedResultsController];
////        NSAssert(_fetchedResultsController, @"FRC must be set at end of create");
//    NSFetchedResultsController *fetchedResultsController = [NSFetchedResultsController.alloc initWithFetchRequest:self.fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
//    fetchedResultsController.delegate = self;
//    //}
//    return fetchedResultsController;
//}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    //self.didBeginUpdatingFromFetchedResultsController = YES;
    //self.wasDisplayed = self.mui_isViewVisible;
    self.sectionsCountChanged = NO;
//    [self.tableViewIfVisible beginUpdates];
 //   self.tableUpdates = [NSBlockOperation.alloc init];
//    if([self.fetchedResultsDelegate respondsToSelector:@selector(controllerWillChangeContent:)]){
//        [self.fetchedResultsDelegate controllerWillChangeContent:controller];
//    }
    UITableView *tableView = self.tableView;
    [tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    UITableView *tableView = self.tableView;
    switch(type) {
        case NSFetchedResultsChangeInsert:
            self.sectionsCountChanged = YES;
            [tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            self.sectionsCountChanged = YES;
            break;
        default:
            break;
    }

}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(NSManagedObject *)object
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {

    
    UITableView *tableView = self.tableView;

    
    //if(type != NSFetchedResultsChangeUpdate){
//    if(!self.wasDisplayed){
//        self.needsTableViewUpdates = YES;
//        return;
//    }
//    else
//    {
//        if(!self.tableViewBeginUpdatesWasCalled){
//            [tableView beginUpdates];
//            self.tableViewBeginUpdatesWasCalled = YES;
//        }
    //}
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        break;
        case NSFetchedResultsChangeMove:
            // Can't use the tableView move method becasue its animation does not play with section inserts/deletes.
            // Also if we used move would need to update the cell manually which might use the wrong index.
            // Even if old and new indices are the same we still need to call the methods.
            NSLog(@"%@", object.changedValuesForCurrentEvent.allKeys);
            if(self.sectionsCountChanged || indexPath.section != newIndexPath.section){
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                break;
            }
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            // fall through
        case NSFetchedResultsChangeUpdate:
        {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if(cell){
                [self.fetchedTableDataSource configureCell:cell withObject:object inTableView:self.tableView];
            }
            break;
        }
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
    [self configureView];
//    if(self.tableViewBeginUpdatesWasCalled){
//        [self.tableView endUpdates];
//        self.tableViewBeginUpdatesWasCalled = NO;
//    }
    
    
//    if(self.needsTableViewUpdates){
//        self.reloadTableOnNextAppear = YES;
//        self.needsTableViewUpdates = NO; // think this is to do with the item changing while
//    }
//
  //  self.didBeginUpdatingFromFetchedResultsController = NO;
    
 
    // we still do selecting when not displayed.
    //if(!self.wasDisplayed){// || self.isMovingOrDeleting)
    //    return;
    //}
    
//    [self.tableView performBatchUpdates:^{
//        [self.tableUpdates start];
//    } completion:^(BOOL finished) {
//        NSLog(@"Finished");
//        self.tableUpdates = nil;
    
    
    
 //   if(self.deletedIndexPath){
//        id object = [controller mcd_objectNearIndexPath:self.deletedIndexPath];
//        if(![self shouldShowDetailForObject:object]){
//            object = nil;
//        }
//        [self selectObject:object notifyWithSender:self selectRow:YES];
//        self.selectedObject = nil;
//        self.deletedIndexPath = nil;
//    }
    
    
  //  }];
    

    //    if(self.removedObjects.count){
    //        if([self.dataSource respondsToSelector:@selector(fetchedTable:didRemoveCellsForObjects:atIndexPaths:)]){
    //            [self.dataSource fetchedTable:self didRemoveCellsForObjects:self.removedObjects atIndexPaths:self.removedIndexPaths];
    //        }
    //        self.removedIndexPaths = nil;
    //        self.removedObjects = nil;
    //    }
    
    //    NSArray *fetchedObjectsBeforeChange = self.fetchedObjectsBeforeChange;
    //    self.fetchedObjectsBeforeChange = nil;
    //
    //    if(!self.selectedObjectWasDeleted){
    //        return;
    //    }
    //    self.selectedObjectWasDeleted = NO;
    //
    //    if(!self.tableViewController.shouldAlwaysHaveSelectedObject){
    //        return;
    //    }
    // its different context
    //    NSManagedObject *detailItem = self.tableViewController.selectedObject;
    //    //if(detailItem && ![controller.fetchedObjects containsObject:detailItem]){
    //    NSManagedObject *object;
    //    NSArray *fetchedObjects = controller.fetchedObjects;
    //    if(fetchedObjects.count > 0){
    //        NSUInteger i = [fetchedObjectsBeforeChange indexOfObject:detailItem];
    //        if(i >= fetchedObjects.count){
    //            i = fetchedObjects.count - 1;
    //        }
    //        object = fetchedObjects[i];
    //    }
    //    [self.tableViewController selectObject:object notifyDelegate:YES];
    
    
    //[self.tableViewController reselectTableRowIfNecessaryScrollToSelection:YES];
    //  }

}

#pragma mark - State Restoration

#define kSelectedObjectManagedObjectContextKey @"SelectedObjectManagedObjectContext"
//#define kSelectedObjectKey @"SelectedObject"

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
   [super encodeRestorableStateWithCoder:coder];
   //  [coder encodeObject:self.selectedObject.managedObjectContext forKey:kSelectedObjectManagedObjectContextKey];
   //  [coder encodeObject:self.selectedObject.objectID.URIRepresentation forKey:kSelectedObjectKey];
    // needed if the table isn't visible and has received updates that weren't applied, otherwise modelIdentifierForElementAtIndexPath crashes for cells that have deleted objects.
    //[self configureView];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    
   [super decodeRestorableStateWithCoder:coder];
  //  NSManagedObjectContext *managedObjectContext = [coder decodeObjectForKey:kSelectedObjectManagedObjectContextKey];
//    NSURL *objectURI = [coder decodeObjectForKey:kSelectedObjectKey];
//    if(objectURI){
//        NSManagedObject *object = [managedObjectContext mcd_existingObjectWithURI:objectURI error:nil];
//        if(object){
//            self.selectedObject = object;
//        }
//    }
    // we need the fetch controller set here because after this the table reselect is called.
    
    //self.masterTable = [coder decodeObjectForKey:kSelectionManagerKey];
    //    [self.tableView reloadData];
}

// on encode it asks for first and selected. On restore it asks for first so maybe checks ID. idx can be nil. called on decode too but with nil.
//- (nullable NSString *)modelIdentifierForElementAtIndexPath:(NSIndexPath *)idx inView:(UIView *)view{
//    if(!idx){
//        return nil;
//    }
//    NSManagedObject *object = [self.fetchedTableDataSource.fetchedResultsController objectAtIndexPath:idx];
//    NSString *identifier = object.objectID.URIRepresentation.absoluteString;
//    return identifier;
//}
//
//// called on decode
//- (nullable NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view{
//    if(!identifier){
//        return nil;
//    }
//    NSURL *objectURI = [NSURL URLWithString:identifier];
//    NSManagedObject *object = [self.fetchedTableDataSource.fetchedResultsController.managedObjectContext mcd_objectWithURI:objectURI];
//    NSIndexPath *indexPath = [self.fetchedTableDataSource.fetchedResultsController indexPathForObject:object];
//    return indexPath;
//}

//- (id)forwardingTargetForSelector:(SEL)aSelector{
//    if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDelegate), aSelector)){
//        if([self.delegate respondsToSelector:aSelector]){
//            return self.delegate;
//        }
//    }
//    else if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDataSource), aSelector)){
//        if([self.delegate respondsToSelector:aSelector]){
//            return self.delegate;
//        }
//    }
//    else if(MHFProtocolHasInstanceMethod(@protocol(NSFetchedResultsControllerDelegate), aSelector)){
//        if([self.delegate respondsToSelector:aSelector]){
//            return self.delegate;
//        }
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}

//- (BOOL)respondsToSelector:(SEL)aSelector{
//    if([super respondsToSelector:aSelector]){
//        return YES;
//    }
//    else if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDelegate), aSelector)){
//        return [self.delegate respondsToSelector:aSelector];
//    }
//    else if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDataSource), aSelector)){
//        return [self.delegate respondsToSelector:aSelector];
//    }
//    else if(MHFProtocolHasInstanceMethod(@protocol(NSFetchedResultsControllerDelegate), aSelector)){
//        return [self.delegate respondsToSelector:aSelector];
//    }
//    return NO;
//}

@end

//@implementation UITableViewController (MUIFetchedTableViewController)
//
//- (MUIFetchedTableViewController *)mui_fetchedTableViewController{
//    MUIFetchedTableViewController *f = objc_getAssociatedObject(self, @selector(mui_fetchedTableViewController));
//    if(!f){
//        f = [MUIFetchedTableViewController.alloc initWithTableViewController:self];
//        objc_setAssociatedObject(self, @selector(mui_fetchedTableViewController), f, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
//    return f;
//}
//    
//@end
