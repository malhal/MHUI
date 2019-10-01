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
#import "UIViewController+MUIDetail.h"
#import "UITableView+MUI.h"
#import "UIViewController+MUIShowing.h"
#import "UIViewController+MUI.h"
#import "UINavigationController+MUI.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

//NSString * const MUIFetchedTableViewControllerSelectedObjectDidUpdateNotification = @"MUIFetchedTableViewControllerSelectedObjectDidUpdateNotification";

@interface MUIFetchedTableViewController(){
    //NSFetchedResultsController *_fetchedResultsController;
}

//@property (strong, nonatomic, readwrite) NSManagedObject *selectedObject;
@property (assign, nonatomic) BOOL sectionsCountChanged;

//@property (strong, nonatomic) NSBlockOperation *tableUpdates;

@property (assign, nonatomic) BOOL didBeginUpdatingFromFetchedResultsController;
@property (assign, nonatomic) BOOL wasDisplayed;
@property (assign, nonatomic) BOOL needsTableViewUpdates;
@property (assign, nonatomic) BOOL tableViewBeginUpdatesWasCalled;
@property (assign, nonatomic) BOOL reloadTableOnNextAppear;
@property (assign, nonatomic) BOOL isEditingRow;
//@property (strong, nonatomic) UIViewController *shownViewController;

@end

@implementation MUIFetchedTableViewController

//- (instancetype)initWithTableViewController:(UITableViewController *)tableViewController {
//    self = [super init];
//    if (self) {
//        _tableViewController = tableViewController;
//    }
//    return self;
//}

//- (UITableView *)tableView{
//    return self.tableViewController.tableView;
//}

- (void)setDelegate:(id<MUIFetchedTableViewControllerDelegate>)delegate {
    if(delegate == _delegate){
        return;
    }
    _delegate = delegate;
}

//- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
//    [super setEditing:editing animated:animated];
//    if(self.isEditingRow){
//        self.isEditingRow = NO;
//        return;
//    }
//}

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
//    if([self.fetchedResultsController.fetchedObjects containsObject:object]){
//        [self selectTableRowIfNecessaryForObject:object scrollToSelection:NO];
//    }
//    else if(object){
//        id o = self.fetchedResultsController.fetchedObjects.firstObject;
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
//    NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:object];
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

    if(self.reloadTableOnNextAppear){
        // can't reselect because selection has probably changed.
       UITableView *tableView = self.tableView;
        NSIndexPath *ip = [tableView indexPathForSelectedRow];
        [tableView reloadData];
        [tableView selectRowAtIndexPath:ip animated:NO scrollPosition:UITableViewScrollPositionNone];
//
        id <UIViewControllerTransitionCoordinator> transitionCoordinator;
        if((transitionCoordinator = self.transitionCoordinator)){
            [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:ip];
                if(cell){
                    [cell setNeedsLayout];
                }
                else{
                    [tableView setNeedsLayout];
                }
            } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            }];
        }
        self.reloadTableOnNextAppear = NO;
    }
    
    
    [super viewWillAppear:animated]; // table first load
    
//
  //  [NSNotificationCenter.defaultCenter removeObserver:self name:UIViewControllerShowDetailTargetDidChangeNotification object:nil]; // prevent adding twice.
    //[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(showDetailTargetDidChange:) name:UIViewControllerShowDetailTargetDidChangeNotification object:nil];
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//
    // runs all the changes since the fetch controller was cached.
    //[self.managedObjectContext processPendingChanges];
//}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//   // [NSNotificationCenter.defaultCenter removeObserver:self name:UIViewControllerShowDetailTargetDidChangeNotification object:nil];
//}

- (void)setFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController{
    if(fetchedResultsController == _fetchedResultsController){
        return;
    }
    else if(_fetchedResultsController){
        if(_fetchedResultsController.delegate == self){
            _fetchedResultsController.delegate = nil;
        }
    }
    _fetchedResultsController = fetchedResultsController;
    if(!fetchedResultsController.delegate){
        fetchedResultsController.delegate = self;
    }
   // self.tableView.delegate = self;
   // self.tableView.dataSource = self;
   // if(self.mui_isViewVisible){
        //[self.tableView reloadData];
      //  [self updateViewForFetchedResultsController];
//        if(self.tableView.window){
//            [self.tableView reloadData];
//            [self updateTableViewForSelectedObject];
//        }
    //}
}

- (void)updateViewForFetchedResultsController{
    self.tableView.separatorStyle = self.fetchedResultsController ? UITableViewCellSeparatorStyleSingleLine : UITableViewCellSeparatorStyleNone;
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
  //  [self updateTableViewForSelectedObjectIfNecessary];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];

        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!tableView.isEditing){
        // todo check if it is a selectable one
     //   id object = [self.fetchedResultsController objectAtIndexPath:indexPath];
      //  [self selectObject:object notifyWithSender:tableView selectRow:NO];
    }
    return indexPath;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(!tableView.isEditing){
//        id object = [self.fetchedResultsController objectAtIndexPath:indexPath];
//        [self selectObject:object notifyWithSender:tableView selectRow:NO];
//    }
//}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if([self.tableDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]){
//        [self.tableDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
//    }
    id object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self configureCell:cell withObject:object];
}

- (void)configureCell:(UITableViewCell *)cell withObject:(id)object{
    if([self.delegate respondsToSelector:@selector(fetchedTableViewController:configureCell:withObject:)]){
        [self.delegate fetchedTableViewController:self configureCell:cell withObject:object];
    }
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

#pragma mark - Fetched results controller

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    self.didBeginUpdatingFromFetchedResultsController = YES;
    self.wasDisplayed = self.mui_isViewVisible;
//    [self.tableViewIfVisible beginUpdates];
 //   self.tableUpdates = [NSBlockOperation.alloc init];
//    if([self.fetchedResultsDelegate respondsToSelector:@selector(controllerWillChangeContent:)]){
//        [self.fetchedResultsDelegate controllerWillChangeContent:controller];
//    }
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
//    if([self.fetchedResultsDelegate respondsToSelector:@selector(controller:didChangeSection:atIndex:forChangeType:)]){
//        [self.fetchedResultsDelegate controller:controller didChangeSection:sectionInfo atIndex:sectionIndex forChangeType:type];
//    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(NSManagedObject *)object
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
//    if([self.fetchedResultsControllerDelegate respondsToSelector:@selector(controller:didChangeObject:atIndexPath:forChangeType:newIndexPath:)]){
//           [self.fetchedResultsControllerDelegate controller:controller didChangeObject:object atIndexPath:indexPath forChangeType:type newIndexPath:newIndexPath];
//    }
    
    UITableView *tableView = self.tableView;
    if(type != NSFetchedResultsChangeUpdate){
        if(!self.wasDisplayed){
            self.needsTableViewUpdates = YES;
            return;
        }
        else if(!self.tableViewBeginUpdatesWasCalled){
            [tableView beginUpdates];
            self.tableViewBeginUpdatesWasCalled = YES;
        }
    }
    
    switch(type) {
        case NSFetchedResultsChangeDelete:
            break;
        case NSFetchedResultsChangeInsert:
        break;
        case NSFetchedResultsChangeMove:
        case NSFetchedResultsChangeUpdate:
        {
        }
    }
    
    
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
                [self configureCell:cell withObject:object];
            }
            break;
        }
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if(self.tableViewBeginUpdatesWasCalled){
        [self.tableView endUpdates];
        self.tableViewBeginUpdatesWasCalled = NO;
    }
    self.sectionsCountChanged = NO;
    
    if(self.needsTableViewUpdates){
        self.reloadTableOnNextAppear = YES;
        self.needsTableViewUpdates = NO; // think this is to do with the item changing while
    }
    
    self.didBeginUpdatingFromFetchedResultsController = NO;
    
//    if([self.fetchedResultsDelegate respondsToSelector:@selector(controllerDidChangeContent:)]){
//        [self.fetchedResultsDelegate controllerDidChangeContent:controller];
//    }
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
- (nullable NSString *)modelIdentifierForElementAtIndexPath:(NSIndexPath *)idx inView:(UIView *)view{
    if(!idx){
        return nil;
    }
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:idx];
    NSString *identifier = object.objectID.URIRepresentation.absoluteString;
    return identifier;
}

// called on decode
- (nullable NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view{
    if(!identifier){
        return nil;
    }
    NSURL *objectURI = [NSURL URLWithString:identifier];
    NSManagedObject *object = [self.fetchedResultsController.managedObjectContext mcd_objectWithURI:objectURI];
    NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:object];
    return indexPath;
}

//- (id)forwardingTargetForSelector:(SEL)aSelector{
//    if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDelegate), aSelector)){
//        if([self.delegate respondsToSelector:aSelector]){
//            return self.tableDelegate;
//        }
//    }
//    else if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDataSource), aSelector)){
//        if([self.tableDataSource respondsToSelector:aSelector]){
//            return self.tableDataSource;
//        }
//    }
//    else if(MHFProtocolHasInstanceMethod(@protocol(NSFetchedResultsControllerDelegate), aSelector)){
//        if([self.fetchedResultsControllerDelegate respondsToSelector:aSelector]){
//            return self.fetchedResultsControllerDelegate;
//        }
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}

//- (BOOL)respondsToSelector:(SEL)aSelector{
//    if([super respondsToSelector:aSelector]){
//        return YES;
//    }
//    else if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDelegate), aSelector)){
//        return [self.tableDelegate respondsToSelector:aSelector];
//    }
//    else if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDataSource), aSelector)){
//        return [self.tableDataSource respondsToSelector:aSelector];
//    }
//    else if(MHFProtocolHasInstanceMethod(@protocol(NSFetchedResultsControllerDelegate), aSelector)){
//        return [self.fetchedResultsControllerDelegate respondsToSelector:aSelector];
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
