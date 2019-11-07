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

@interface MUIMasterViewController () <UITableViewDelegate, UIViewControllerRestoration>

// state
@property (strong, nonatomic) NSIndexPath *indexPathOfDeletedDetailItem;
@property (strong, nonatomic, readwrite) __kindof NSManagedObject *selectedObject;
@property (assign, nonatomic) BOOL selectionIsUserDriven;
@property (assign, nonatomic) BOOL isEditingRow;
//@property (assign, nonatomic) BOOL isTopViewController;

// state
@property (strong, nonatomic) NSNumber *countOfFetchedObjects;

@end

@implementation MUIMasterViewController
//@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize countOfFetchedObjects = _countOfFetchedObjects;
//@synthesize selectedObject = _selectedObject;

- (void)awakeFromNib{
    [super awakeFromNib];
}


- (BOOL)mui_canSelectDetailItem:(id)object{
    return [self.fetchedTableViewController.fetchedResultsController indexPathForObject:object];
}

- (instancetype)initWithCoder:(NSCoder *)coder persistentContainer:(NSPersistentContainer *)persistentContainer{
    self = [super initWithCoder:coder];
    if (self) {
        _persistentContainer = persistentContainer;
    }
    return self;
}

- (NSFetchedResultsController *)fetchedResultsController{
    return self.fetchedTableViewController.fetchedResultsController;
}

//- (NSFetchedResultsController *)fetchedResultsController{
//    if(!_fetchedResultsController){
//        [self createFetchedResultsController];
//        NSAssert(_fetchedResultsController, @"FRC must be set at end of create");
//    }
//    return _fetchedResultsController;
//}
//
//- (void)createFetchedResultsController{
//    NSAssert(NO, @"To be overridden by subclass");
//}
//
//- (void)setFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController{
//    if(fetchedResultsController == _fetchedResultsController){
//        return;
//    }
//    else if(_fetchedResultsController && _fetchedResultsController.delegate == self){
//        _fetchedResultsController.delegate = nil;
//    }
//    _fetchedResultsController = fetchedResultsController;
//    if(!fetchedResultsController.delegate){
//        fetchedResultsController.delegate = self;
//    }
//}

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

//- (NSManagedObject *)selectedObject{
//    if(!_selectedObject){
//        _selectedObject = [self mui_currentDetailItemWithSender:self];
//    }
//    return _selectedObject;
//}

- (void)setSelectedObject:(__kindof NSManagedObject *)selectedObject{
    if(_selectedObject == selectedObject){
        return;
    }
    _selectedObject = selectedObject;
    if(self.isViewLoaded && !self.selectionIsUserDriven){
        [self updateRowSelectionAnimated:NO];
        [self updateCurrentDetailObject];
    }
}

// this needs to both show the detail if necessary and also select the table row if necessary.
// or they call a method after this.
//- (void)showDetailObject:(__kindof NSManagedObject *)detailObject{// configureView:(BOOL)configureView{d

//- (void)__showDetailObject:(__kindof NSManagedObject *)object{
//    self.selectedObject = object;
    //if(self.selectionIsUserDriven){
//    [self showDetailWithObject:object];
//    self.detailViewControllerDetailItem = object;
//}

- (void)showDetailWithObject:(NSManagedObject *)object{
    
}

//- (void)setDetailViewController:(UIViewController<MUIDetail> *)detailViewController{
//    if(detailViewController == _detailViewController){
//        return;
//    }
//    _detailViewController = detailViewController;
//    if(detailViewController.parentViewController.parentViewController){
//        NSLog(@"");
//    }
//}
    

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
    
   // self.fetchedTableViewController.tableView.dataSource = self; // these can't be done until the self.fetchedTableViewController is set so the forwarding works.
    [self updateFetchedTable];
    [self updateEditButton];
}

- (void)updateFetchedTable{
    self.fetchedTableViewController.tableView.delegate = self;
    self.fetchedTableViewController.fetchedResultsController = self.fetchedResultsController;
}

- (void)setFetchedTableViewController:(MUIFetchedTableViewController *)fetchedTableViewController{
    if(fetchedTableViewController == _fetchedTableViewController){
        return;
    }
    _fetchedTableViewController = fetchedTableViewController;
    if(fetchedTableViewController.isViewLoaded){
        [self updateFetchedTable];
    }
}

// this can't set anything
- (void)updateEditButton{
    self.editButtonItem.enabled = self.countOfFetchedObjects.integerValue > 0 && !self.isEditingRow;
}

- (void)updateRowSelectionAnimated:(BOOL)animated{
    [self updateRowSelectionAnimated:animated scrollToSelection:NO];
}

// depenendednt on detail item and visible
- (void)updateRowSelectionAnimated:(BOOL)animated scrollToSelection:(BOOL)scrollToSelection{
    if(!self.alwaysHaveSelectedObject){
        if(!self.isEditing && !self.isEditingRow){
            UITableView *tableView = self.fetchedTableViewController.tableView;
            for(NSIndexPath *indexPath in tableView.indexPathsForSelectedRows.copy){
                [tableView deselectRowAtIndexPath:indexPath animated:NO];
            }
        }
        return;
    }
    NSManagedObject *object = self.selectedObject;
    if(!object){
        return;
    }
    NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:object];
    if(!indexPath){
        return;
    }
    UITableView *tableView = self.fetchedTableViewController.tableView;
    [tableView selectRowAtIndexPath:indexPath animated:animated scrollPosition:UITableViewScrollPositionNone];
    if(!scrollToSelection){
        return;
    }
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:animated];
}

- (BOOL)alwaysHaveSelectedObject{
    // splitViewController  traitCollection horizontalSizeClass
    // isInHardwareKeyboardMode
//    if(![self.navigationController.viewControllers containsObject:self]){
//        return NO;
//    }
//    else if(self.splitViewController.isCollapsed &&  ![self.navigationController.topViewController isKindOfClass:UINavigationController.class]){
//        return NO;
//    }
//    return YES;
    // can't check detail visible because during interactive pop it is visible but might go back on the stack so we would push a second detail on.
    BOOL isCollapsed = self.splitViewController.isCollapsed;
    NSUInteger u = self.splitViewController.viewControllers.count;
    id i = self.splitViewController;
    return !self.splitViewController.isCollapsed || [self.navigationController.topViewController isKindOfClass:UINavigationController.class];
}

- (BOOL)alwaysHaveSelectedRow{
    BOOL result = NO;
    if(self.alwaysHaveSelectedObject){
//        if(self.tableView.isEditing){
//            result = self.isMovingOrDeletingNotes;
//        }
        result = !self.isEditing && !self.isEditingRow;
    }
    return result;
}

// called on a appear and controller changed if the selected object was deleted.
- (void)updateSelectedObject{
    if(!self.alwaysHaveSelectedObject){
        return;
    }
    id object = self.selectedObject;
    if(![self.fetchedResultsController indexPathForObject:object]){
        object = self.fetchedResultsController.fetchedObjects.firstObject;
    }
    self.selectedObject = object;
}

// only if we are on the navigation stack
- (void)updateCurrentDetailObject{
    if(!self.alwaysHaveSelectedObject){
        return;
    }
    else if([self mui_currentDetailItemWithSender:self] == self.selectedObject){ // self.splitViewController.mui_detailViewController.mui_detailItem
        return;
    }
    [self showDetailWithObject:self.selectedObject];
}

//- (void)setDetailViewController:(UIViewController<MUIDetail> *)detailViewController{
//    if(detailViewController == _detailViewController){
//        return;
//    }
//    _detailViewController = detailViewController;
//    if(self.isViewLoaded && !self.selectionIsUserDriven){
//        [self updateRowSelectionAnimated:NO];
//    }
//}

- (void)willMoveToParentViewController:(UIViewController *)parent{
    if(!parent){
        return;
    }
    else if(![parent isKindOfClass:UINavigationController.class]){
        return;
    }
    self.selectedObject = [self mui_currentDetailItemWithSender:self];
}

- (void)viewWillAppear:(BOOL)animated {
    BOOL isCollapsed = self.splitViewController.isCollapsed;
    //[self updateSelectedObject]; // this won't cause updateCurrentDetailObject if we select nil because it is already nil by default.
    //[self updateCurrentDetailObject]; // in state restore portrait isCollapsed is No which causes the first object to be selected and shown.
    [self updateRowSelectionAnimated:animated];
    
    [self updateEditButton];
    BOOL b = self.isMovingToParentViewController;
    BOOL c = self.isMovingFromParentViewController;
//    [self showSelectedObjectIsUserDriven:NO];
    self.fetchedTableViewController.clearsSelectionOnViewWillAppear = c ?: self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
    
    //[self updateRowSelectionAnimated:animated];
    
}

- (void)didMoveToParentViewController:(UIViewController *)parent{
    [super didMoveToParentViewController:parent];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    BOOL isCollapsed = self.splitViewController.isCollapsed;
    [self updateCurrentDetailObject]; // for main thing but also if encoded portrait on master that came back from a detail and restored in landscape.
    [self updateRowSelectionAnimated:animated]; // ?
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    // for when deleting the item that is being interative popping and is cancelled.
    if(self.isMovingFromParentViewController){
        return;
    }
    [self updateCurrentDetailObject];
}

// i.e. isCollapsed changed
- (void)showDetailTargetDidChange:(NSNotification *)notification{
    // so we always select first if in a new master.
    // turned this off because when on root and no detail was selected, rotating will select show the first on the detail even tho we aren't on the master.
    // actually added it back but added the check if always show detail.
    // removed it again because.
    [self updateSelectedObject];
    
    [self updateCurrentDetailObject];
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

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.isEditingRow = YES;
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSelector:@selector(didEndEditingRowAtIndexPath:) withObject:indexPath afterDelay:0];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!self.isEditing){
        NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        // don't show if in landscape and the object is already selected.
        self.selectionIsUserDriven = YES;
        self.selectedObject = object;
        [self showDetailWithObject:object];
        self.selectionIsUserDriven = NO;
    }
}

- (void)didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.isEditingRow = NO;
}

#pragma mark - Fetched results controller

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    [self.fetchedTableViewController controller:controller didChangeObject:anObject atIndexPath:indexPath forChangeType:type newIndexPath:newIndexPath];
    if(type != NSFetchedResultsChangeDelete){
        return;
    }
    else if(anObject == self.selectedObject){ // need to select the next one even if not visible.
        self.indexPathOfDeletedDetailItem = indexPath;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.fetchedTableViewController controllerDidChangeContent:controller];
    if(self.indexPathOfDeletedDetailItem){
        NSManagedObject *object;
        @try {
            object = [self.fetchedResultsController objectAtIndexPath:self.indexPathOfDeletedDetailItem];
        } @catch (NSException *exception) {
            object = self.fetchedResultsController.fetchedObjects.lastObject;
        }
        self.selectedObject = object;
        self.indexPathOfDeletedDetailItem = nil;
    }
    self.countOfFetchedObjects = @(controller.fetchedObjects.count);
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDelegate), aSelector)){
        if([self.fetchedTableViewController respondsToSelector:aSelector]){
            return self.fetchedTableViewController;
        }
    }
//    else if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDataSource), aSelector)){
//        if([self.fetchedTableViewController respondsToSelector:aSelector]){
//            return self.fetchedTableViewController;
//        }
//    }
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
//    else if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDataSource), aSelector)){
//        if([self.fetchedTableViewController respondsToSelector:aSelector]){
//            return YES;
//        }
//    }
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

#define kCurrentDetailObjectKey @"CurrentDetailObject"
#define kFetchedTableViewControllerKey @"fetchedTableViewController"
#define kSelectedObjectKey @"SelectedObject"

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    
    //if(self.detailViewController){
      //  [coder encodeObject:self.detailViewController forKey:MasterViewControllerStateRestorationDetailViewControllerKey];
    //}
    [coder encodeObject:self.fetchedTableViewController forKey:kFetchedTableViewControllerKey];
    [coder encodeObject:self.persistentContainer forKey:MasterViewControllerStateRestorationPersistentContainerKey];
    [coder encodeObject:self.selectedObject.objectID.URIRepresentation forKey:kSelectedObjectKey];
    
    [super encodeRestorableStateWithCoder:coder]; 
}
 
- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    UIViewController *dvc = [coder decodeObjectForKey:MasterViewControllerStateRestorationDetailViewControllerKey]; // it doesnt have the detail item. Why are we preserving the detail again?
    
    // we could preserve the detail so when restorating to portrait on master then rotate to landscape it'll have the item.
    
    
    //self.detailViewController = dvc;
    self.selectionIsUserDriven = YES;
    NSURL *objectURI = [coder decodeObjectForKey:kSelectedObjectKey];
    self.selectedObject = [self.persistentContainer.viewContext mcd_existingObjectWithURI:objectURI error:nil];
    self.selectionIsUserDriven = NO;
    
}

// when should we update the selected row? Here or in view did appear?
// what about depending on if it is deleted or not?

- (void)applicationFinishedRestoringState{
    // because we depend on the detail object
    //[self updateSelectedObject];
    
    //self.selectedObject = self.splitViewController.mui_currentSplitDetailItem.object;
    
   // [self.tableView layoutIfNeeded]; // fix going back unlight bu
   // [self reselectTableRowIfNecessary];
    // [self configureViewForCurrentDetailObject];
    
   // UISplitViewController *splitViewController = self.splitViewController;
    //NSIndexPath *indexPath = self.fetchedTableViewController.tableView.indexPathForSelectedRow;
    //if(!self.splitViewController.isCollapsed){
//    id detailItem = self.detailViewController.detailItem;
//    NSUInteger i = self.fetchedResultsController.fetchedObjects.count;
//    if((detailItem && ![self.fetchedResultsController.fetchedObjects containsObject:detailItem]) || (!detailItem && self.fetchedResultsController.fetchedObjects.count)){
//       // [self showObject:self.fetchedResultsController.fetchedObjects.firstObject]; // ok to be nil due to first part of if
//    }
}

@end
