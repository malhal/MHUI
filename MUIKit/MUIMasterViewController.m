//
//  MasterViewController.m
//  MUIFetchedMasterDetail
//
//  Created by Malcolm Hall on 16/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MUIMasterViewController.h"


NSString * const MasterViewControllerStateRestorationDetailViewControllerKey = @"DetailViewController";
NSString * const MasterViewControllerStateRestorationPersistentContainerKey = @"PersistentContainer";

@interface MUIMasterViewController () <MUIFetchedTableViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, UIViewControllerRestoration>

// state
@property (strong, nonatomic, null_resettable) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) MUIFetchedTableViewController *fetchedTableViewController;
@property (strong, nonatomic) NSIndexPath *indexPathOfDeletedDetailItem;
@property (strong, nonatomic, readwrite) __kindof NSManagedObject *objectForShowDetail;
@property (assign, nonatomic) BOOL selectionIsUserDriven;
@property (assign, nonatomic) BOOL isEditingRow;
//@property (assign, nonatomic) BOOL isTopViewController;

// state
@property (strong, nonatomic) NSNumber *countOfFetchedObjects;

@end

@implementation MUIMasterViewController
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize countOfFetchedObjects = _countOfFetchedObjects;

- (instancetype)initWithCoder:(NSCoder *)coder persistentContainer:(NSPersistentContainer *)persistentContainer{
    self = [super initWithCoder:coder];
    if (self) {
        _persistentContainer = persistentContainer;
    }
    return self;
}

- (NSManagedObjectContext *)managedObjectContext{
    return self.persistentContainer.viewContext;
}

- (void)setIsEditingRow:(BOOL)isEditingRow{
    if(isEditingRow == _isEditingRow){
        return;
    }
    _isEditingRow = isEditingRow;
    if(self.isViewLoaded){
        [self updateEditButton];
        [self updateRowSelectionAnimated:NO];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    //if(animated){
        // because otherwise the checkmark gets selected when sliding back.
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            [self updateRowSelectionAnimated:NO];
        }];
   // }
    // transaction needs to be around this to work in the button tap one
    //[super setEditing:editing animated:animated];
    [self.fetchedTableViewController setEditing:editing animated:animated];
  //  if(animated){
        [CATransaction commit];
//    }
//    else{
//        [self updateRowSelectionAnimated:NO];
//    }
}

- (void)setCountOfFetchedObjects:(NSNumber *)countOfFetchedObjects{
    if(countOfFetchedObjects == _countOfFetchedObjects){
        return;
    }
    _countOfFetchedObjects = countOfFetchedObjects;
    if(self.isViewLoaded){
        [self updateEditButton];
    }
}

- (NSNumber *)countOfFetchedObjects{
    if(!_countOfFetchedObjects){
        _countOfFetchedObjects = @(self.fetchedResultsController.fetchedObjects.count);
    }
    return _countOfFetchedObjects;
}

// this needs to both show the detail if necessary and also select the table row if necessary.
// or they call a method after this.
//- (void)showDetailObject:(__kindof NSManagedObject *)detailObject{// configureView:(BOOL)configureView{d
- (void)showDetailObject:(__kindof NSManagedObject *)object{
    self.objectForShowDetail = object;
    //if(self.selectionIsUserDriven){
    [self performShowDetailWithObject:object];
}

- (void)performShowDetailWithObject:(NSManagedObject *)object{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSAssert(self.persistentContainer, @"requires persistentContainer");
    
    // Do any additional setup after loading the view.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //MUIFetchedTableViewController *fetchedTableViewController = [MUIFetchedTableViewController.alloc initWithTableViewController:self];
    
    //self.isTopViewController = self.navigationController.topViewController == self;
    //[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(navigationControllerDidShowViewController:) name:MUINavigationControllerDidShowViewControllerNotification object:self.navigationController];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(showDetailTargetDidChange:) name:UIViewControllerShowDetailTargetDidChangeNotification object:nil];
    
    // init things
//    id i = self.splitViewController;
    
//        if(self.detailViewController){
//            [self setCurrentDetailObject:self.detailViewController.detailItem configureSelection:NO];
//        }
//    }

//    UISplitViewController *splitViewController = self.splitViewController;
//    if(splitViewController && !splitViewController.isCollapsed){
//        self.detailViewController = ((UINavigationController *)self.splitViewController.viewControllers.lastObject).viewControllers.firstObject;
//    }
    
    self.fetchedTableViewController.fetchedResultsController = self.fetchedResultsController;
    self.fetchedTableViewController.tableView.delegate = self;
    self.fetchedTableViewController.tableView.dataSource = self; // these can't be done until the self.fetchedTableViewController is set so the forwarding works.
    
    [self updateEditButton];
}

- (UIViewController<MUIDetail> *)targetDetailViewController{
    UIViewController<MUIDetail> *dvc;
    if(self.splitViewController.viewControllers.count == 2){ // it might not be collapsed right now but it is during state restoration
        dvc = ((UINavigationController *)self.splitViewController.viewControllers.lastObject).viewControllers.firstObject;
    }
    else if([self.navigationController.topViewController isKindOfClass:UINavigationController.class]){
        dvc = ((UINavigationController *)self.navigationController.topViewController).viewControllers.firstObject;
    }
    return dvc;
}

// this can't set anything
- (void)updateEditButton{
    self.editButtonItem.enabled = self.countOfFetchedObjects.integerValue > 0 && !self.isEditingRow;
}

- (void)updateRowSelectionAnimated:(BOOL)animated{
    [self updateRowSelectionAnimated:animated scrollToSelection:NO];
}

- (void)updateRowSelectionAnimated:(BOOL)animated scrollToSelection:(BOOL)scrollToSelection{
    if(!self.shouldAlwaysHaveSelectedRow){
        return;
    }
    NSManagedObject *object = self.detailViewController.detailItem;
    if(!object){
        return;
    }
    NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:object];
    if(!indexPath){
        return;
    }
    [self selectRow:indexPath animated:animated scrollToSelection:scrollToSelection];
}


- (void)selectRow:(NSIndexPath *)indexPath animated:(BOOL)animated scrollToSelection:(BOOL)scrollToSelection{
    UITableView *tableView = self.fetchedTableViewController.tableView;
    [tableView selectRowAtIndexPath:indexPath animated:animated scrollPosition:UITableViewScrollPositionNone];
    if(!scrollToSelection){
        return;
    }
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:animated];
}

- (BOOL)shouldAlwaysHaveSelectedRow{
    BOOL result = NO;
    if(self.shouldAlwaysShowDetailObject){
//        if(self.tableView.isEditing){
//            result = self.isMovingOrDeletingNotes;
//        }
        result = !self.isEditing && !self.isEditingRow;
    }
    return result;
}

- (BOOL)shouldAlwaysShowDetailObject{
    // splitViewController  traitCollection horizontalSizeClass
    // isInHardwareKeyboardMode
     return !self.splitViewController.isCollapsed || [self.navigationController.topViewController isKindOfClass:UINavigationController.class];
}

// This one actually shows a note if one isn't selected.
// Called from note container did change and appear.
// updateSelectionForCurrentNoteContainerAnimated
- (void)updateDetailObjectAnimated:(BOOL)animated{
    //if(!self.tableViewIndexPathsForSelectedEditableRows.count){
        if(!self.shouldAlwaysShowDetailObject){
            //if(!self.tableView.isEditing){
//                for(NSIndexPath *indexPath in self.tableView.indexPathsForSelectedRows.copy){
//                    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
//                }
            //}
            return;
        }
    //}
    
    // we need a valid detail item.
    id object = self.detailViewController.detailItem;
    if([self.fetchedResultsController indexPathForObject:object]){
        return;
    }
    else if(self.indexPathOfDeletedDetailItem){
        @try {
            object = [self.fetchedResultsController objectAtIndexPath:self.indexPathOfDeletedDetailItem];
        } @catch (NSException *exception) {
            object = self.fetchedResultsController.fetchedObjects.lastObject;
        }
    }else{
        object = self.fetchedResultsController.fetchedObjects.firstObject;
    }
    // dont show if collapsed and detail is not showing
    [self showDetailObject:object];
}

//- (void)replaceDetailIfNecessary{
//    // we don't need to show when going to portrait and don't want to select either
//    if(!self.splitViewController.isCollapsed){
//        // if the detail item isn't in this list, e.g. it was deleted while the list was not visible.
//        if(![self.fetchedResultsController.fetchedObjects containsObject:self.detailViewController.detailItem]){
//            // when we selected an object but did not show it.
//            if(self.selectedObject){
//                [self showSelectedObjectIfNecessary];
//            }
//            else{
//                NSManagedObject *object = self.fetchedResultsController.fetchedObjects.firstObject;
//                [self selectObject:object];
//            }
//        }
//    }
//}


- (void)viewWillAppear:(BOOL)animated {
    [self updateDetailObjectAnimated:animated];
    [self updateRowSelectionAnimated:animated];
    //[self replaceDetailIfNecessary];
    [self updateEditButton];
//    [self showSelectedObjectIsUserDriven:NO];
    self.fetchedTableViewController.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

//- (void)navigationControllerDidShowViewController:(NSNotification *)notification{
//    self.isTopViewController = self.navigationController.topViewController == self;
//}

// i.e. isCollapsed changed
- (void)showDetailTargetDidChange:(NSNotification *)notification{
    //[self selectDefaultCurrentDetailObjectIfNecessary];
    // if current item detail is not in list or if nothing selected then choose first item if seperated.
    // show if detail isn't showing the currently selected.
    // don't show if collapsed
    //[self replaceDetailIfNecessary];
    //[self updateEditButton];
    [self updateDetailObjectAnimated:NO];
    [self updateRowSelectionAnimated:NO];
   // [self select];
    // its possible to find the detail if it wasn't previously.
   // [self configureViewForCurrentDetailObject];
    
    //}
    //BOOL b = self.view.window;
    //[self configureViewForCurrentDetailObject]; // shouldn't be calling this if not visible.
   // self.isCollapsed = !self.splitViewController.isCollapsed;
    //[self configureSelection];
    //[self showDetailIfNecessary];
    
    //[self showDetailIfNecessary];
//      id i = self.tableView.window;
//      for(NSIndexPath *indexPath in self.tableView.indexPathsForVisibleRows){
//
//          id object = [self.fetchedResultsController objectAtIndexPath:indexPath];
//
//      }
//      NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:currentDetailObject];
//      [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//
//
//     update cell accessories.
//    UITableView *tableView = self.tableView;
//    for (UITableViewCell *cell in tableView.visibleCells) {
//        NSIndexPath *indexPath = [tableView indexPathForCell:cell];
//        [self configureCell:cell atIndexPath:indexPath];
//    }
//
//     [self reselectTableRowIfNecessary];
//    [self updateTableViewForSelectedObjectIfNecessary];
//
//    UISplitViewController *svc = (UISplitViewController *)notification.object;
//    if(!svc.isCollapsed){
//        [self reselectTableRowIfNecessary];
//    }else{
//        // only deselect the row if it is the top controller.
//
//        if(self.navigationController.topViewController == self){
//            [tableView selectRowAtIndexPath:nil animated:NO scrollPosition:UITableViewScrollPositionNone];
//        }
//    }
}

#pragma mark - Table View

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if([self.tableDataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]){
    //        return [self.tableDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    //    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.opaque = NO;
    cell.textLabel.backgroundColor = UIColor.clearColor;
    //if(!cell.selectedBackgroundView){
//        UIView *v = [UIView.alloc init];
//        v.backgroundColor = v.tintColor;
//        cell.selectedBackgroundView = v;
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.isEditingRow = YES;
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSelector:@selector(end) withObject:nil afterDelay:0];
}

- (void)end{
    self.isEditingRow = NO;
}

#pragma mark - Fetched results controller

//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if([indexPath isEqual:tableView.indexPathForSelectedRow]){
//        return nil;
//    }
//    return indexPath;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!self.isEditing){
        NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        // don't show if in landscape and the object is already selected.
        self.selectionIsUserDriven = YES;
        [self showDetailObject:object];
        self.selectionIsUserDriven = NO;
    }
    //  [self updateRowsForCurrentDetailObject];
    // [self configureViewForCurrentDetailObject];
}

//- (UIViewController *)targetViewControllerForAction:(SEL)action sender:(id)sender{
//
//    if(action != @selector(showDetailViewController:sender:)){
//        return [super targetViewControllerForAction:action sender:sender];
//    }
//
//        return [super targetViewControllerForAction:action sender:sender];
//    }
//    return self;
//}

//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
//    if(action != @selector(showDetailViewController:sender:)){
//        return [super canPerformAction:action withSender:sender];
//    }
//    else if(self.navigationController.topViewController == self){
//        return NO;
//    }
//    return YES;
//}
//
//- (void)showDetailViewController:(UIViewController *)vc sender:(id)sender{
//    UINavigationController *existingDetailNav = (UINavigationController *)self.navigationController.topViewController;
//    UINavigationController *newDetailNav = (UINavigationController *)vc;
//    existingDetailNav.viewControllers = @[newDetailNav.topViewController];
//    
    //bad
    //    // replace the master nav stack with the master and the new detail.
    //    self.navigationController.viewControllers = @[self, vc];
//}

/*
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}
*/

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    [self.fetchedTableViewController controller:controller didChangeObject:anObject atIndexPath:indexPath forChangeType:type newIndexPath:newIndexPath];
   // UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            //[tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            // &&
            if(anObject == self.detailViewController.detailItem){ // need to select the next one even if not visible.
                self.indexPathOfDeletedDetailItem = indexPath;
            }
            break;
            
        case NSFetchedResultsChangeUpdate:
            //[self updateCell:[tableView cellForRowAtIndexPath:indexPath] withEvent:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
           // [self updateCell:[tableView cellForRowAtIndexPath:indexPath] withEvent:anObject];
           // [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.fetchedTableViewController controllerDidChangeContent:controller];
    if(self.indexPathOfDeletedDetailItem){
        [self updateDetailObjectAnimated:NO];
        [self updateRowSelectionAnimated:NO];
        self.indexPathOfDeletedDetailItem = nil;
    }
    self.countOfFetchedObjects = @(controller.fetchedObjects.count);
}

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
*/

- (id)forwardingTargetForSelector:(SEL)aSelector{
    if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDelegate), aSelector)){
        if([self.fetchedTableViewController respondsToSelector:aSelector]){
            return self.fetchedTableViewController;
        }
    }
    else if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDataSource), aSelector)){
        if([self.fetchedTableViewController respondsToSelector:aSelector]){
            return self.fetchedTableViewController;
        }
    }
    else if(MHFProtocolHasInstanceMethod(@protocol(NSFetchedResultsControllerDelegate), aSelector)){
        if([self.fetchedTableViewController respondsToSelector:aSelector]){
            return self.fetchedTableViewController;
        }
    }
    else if(MHFProtocolHasInstanceMethod(@protocol(UIDataSourceModelAssociation), aSelector)){
        if([self.fetchedTableViewController respondsToSelector:aSelector]){
            return self.fetchedTableViewController;
        }
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    if([super respondsToSelector:aSelector]){
        return YES;
    }
    else if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDelegate), aSelector)){
        if([self.fetchedTableViewController respondsToSelector:aSelector]){
            return YES;
        }
    }
    else if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDataSource), aSelector)){
        if([self.fetchedTableViewController respondsToSelector:aSelector]){
            return YES;
        }
    }
    else if(MHFProtocolHasInstanceMethod(@protocol(NSFetchedResultsControllerDelegate), aSelector)){
        if([self.fetchedTableViewController respondsToSelector:aSelector]){
            return YES;
        }
    }
    else if(MHFProtocolHasInstanceMethod(@protocol(UIDataSourceModelAssociation), aSelector)){
        if([self.fetchedTableViewController respondsToSelector:aSelector]){
            return YES;
        }
    }
    return NO;
}


#pragma mark - UIStateRestoration

//#define kDetailViewControllerKey @"DetailViewController"
#define kCurrentDetailObjectKey @"CurrentDetailObject"
#define kFetchedTableViewControllerKey @"FetchedTableViewController"

//#define kModelIdentifierForSelectedElementKey @"ModelIdentifierForSelectedElement"
//#define kSelectedMasterObjectKey @"kSelectedMasterObjectKey"

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    if(self.detailViewController){
        [coder encodeObject:self.detailViewController forKey:MasterViewControllerStateRestorationDetailViewControllerKey];
    }
    //[coder encodeObject:self.managedObjectContext forKey:kManagedObjectContextKey];
    
    [coder encodeObject:self.fetchedTableViewController forKey:kFetchedTableViewControllerKey];
    [coder encodeObject:self.persistentContainer forKey:MasterViewControllerStateRestorationPersistentContainerKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    self.detailViewController = [coder decodeObjectForKey:MasterViewControllerStateRestorationDetailViewControllerKey]; // it doesnt have the detail item. Why are we preserving the detail again?
}

- (void)applicationFinishedRestoringState{
   // [self.tableView layoutIfNeeded]; // fix going back unlight bu
   // [self reselectTableRowIfNecessary];
    // [self configureViewForCurrentDetailObject];
    
    UISplitViewController *splitViewController = self.splitViewController;
    //NSIndexPath *indexPath = self.fetchedTableViewController.tableView.indexPathForSelectedRow;
    //if(!self.splitViewController.isCollapsed){
//    id detailItem = self.detailViewController.detailItem;
//    NSUInteger i = self.fetchedResultsController.fetchedObjects.count;
//    if((detailItem && ![self.fetchedResultsController.fetchedObjects containsObject:detailItem]) || (!detailItem && self.fetchedResultsController.fetchedObjects.count)){
//       // [self showObject:self.fetchedResultsController.fetchedObjects.firstObject]; // ok to be nil due to first part of if
//    }
}

@end
