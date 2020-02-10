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

- (UISplitViewController *)resolvedSplitViewController{
    if(!_resolvedSplitViewController){
        _resolvedSplitViewController = self.splitViewController;
        id i = _resolvedSplitViewController;
       // NSAssert(_resolvedSplitViewController, @"resolvedSplitViewController was nil");
    }
    return _resolvedSplitViewController;
}

- (UIViewController *)targetViewControllerForAction:(SEL)action sender:(id)sender{
    if(action != @selector(showDetailViewController:sender:)){
        return [super targetViewControllerForAction:action sender:sender];
    }
    return self.resolvedSplitViewController;
}

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (BOOL)willShowingDetailViewControllerPush{
    return [self mui_willShowingDetailViewControllerPushWithSender:self];
}

- (BOOL)mui_containsDetailItem:(id)object{
    return [self.fetchedTableViewController.fetchedResultsController indexPathForObject:object];
}

//- (instancetype)initWithCoder:(NSCoder *)coder persistentContainer:(NSPersistentContainer *)persistentContainer{
//    self = [super initWithCoder:coder];
//    if (self) {
//       // _persistentContainer = persistentContainer;
//    }
//    return self;
//}

// would cause a loop, trying again.
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
//    self.countOfFetchedObjects = @(fetchedResultsController.fetchedObjects.count);
//    if(self.isViewLoaded){
//        [self updateFetchedTable];
//    }
//
//}

//- (NSManagedObjectContext *)managedObjectContext{
//    return self.persistentContainer.viewContext;
//}

- (void)setIsEditingRow:(BOOL)isEditingRow{
    if(isEditingRow == _isEditingRow){
        return;
    }
    _isEditingRow = isEditingRow;
    if(self.isViewLoaded){
        [self updateEditButton];
        [self updateRowSelection];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    //if(animated){
        // because otherwise the checkmark gets selected when sliding back.
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            [self updateRowSelection];
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

- (void)setSelectedObject:(NSManagedObject *)object{
    if(_selectedObject == object){
        return;
    }
    _selectedObject = object;
    if(self.isViewLoaded && !self.selectionIsUserDriven){
        [self updateCurrentDetailObject];
        //[self updateRowSelection];
    }
}

//
//- (void)detailItemDidChange:(NSNotification *)notification{
//    NSLog(@"changed");
//
//    // need to check if the new detail item is in this list if it isn't then we pick another one.
//    UISplitViewController *svc = notification.object;
//    NSManagedObject *detailItem = svc.mui_containedDetailItem;
//    [self showDetailWithObject:detailItem];
//    if(!self.selectionIsUserDriven){
//        [self updateRowSelectionForObject:detailItem];
//    }
//}

// this needs to both show the detail if necessary and also select the table row if necessary.
// or they call a method after this.
//- (void)showDetailObject:(__kindof NSManagedObject *)detailObject{// configureView:(BOOL)configureView{d

//- (void)__showDetailObject:(__kindof NSManagedObject *)object{
//    self.selectedObject = object;
    //if(self.selectionIsUserDriven){
//    [self showDetailWithObject:object];
//    self.detailViewControllerDetailItem = object;
//}

- (void)_showViewControllerForObject:(NSManagedObject *)object{
    /*
    UINavigationController *masterNav = (UINavigationController *)self.splitViewController.viewControllers.firstObject;
    UIViewController *masterTop = masterNav.topViewController;
    UINavigationController *nav = self.navigationController;
    if(masterNav.viewControllers.count == 2 && masterTop != nav){
        [masterNav popToRootViewControllerAnimated:NO];
        [UIView performWithoutAnimation:^{
            [self showViewControllerForObject:object];
        }];
        return;
    }
    else if(masterNav.viewControllers.count > 2 && masterTop != nav){
        [masterNav popToViewController:nav animated:NO];
        [UIView performWithoutAnimation:^{
            [self showViewControllerForObject:object];
        }];
        return;
    }
      */
    [self showViewControllerForObject:object];
    
    
}

- (void)showViewControllerForObject:(NSManagedObject *)object{
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
    
    //NSAssert([self mcd_persistentContainerWithSender:self], @"requires persistentContainer");
    
    // Do any additional setup after loading the view.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //MUIFetchedTableViewController *fetchedTableViewController = [MUIFetchedTableViewController.alloc initWithTableViewController:self];
    
    //self.isTopViewController = self.navigationController.topViewController == self;
    //[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(navigationControllerDidShowViewController:) name:MUINavigationControllerDidShowViewControllerNotification object:self.navigationController];
    
    id i = self.resolvedSplitViewController;
   [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(showDetailTargetDidChange:) name:UIViewControllerShowDetailTargetDidChangeNotification object:nil];
    
  
    
    //[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(detailItemDidChange:) name:MUIViewControllerDetailItemDidChange object:nil];
    
    // init things
//    id i = self.resolvedSplitViewController;
    
//        if(self.detailViewController){
//            [self setCurrentDetailObject:self.detailViewController.detailItem configureSelection:NO];
//        }
//    }

//    UISplitViewController *splitViewController = self.resolvedSplitViewController;
//    if(splitViewController && !splitViewController.isCollapsed){
//        self.detailViewController = ((UINavigationController *)self.resolvedSplitViewController.viewControllers.lastObject).viewControllers.firstObject;
//    }
    
   // self.fetchedTableViewController.tableView.dataSource = self; // these can't be done until the self.fetchedTableViewController is set so the forwarding works.
    [self updateEditButton];
    [self updateFetchedTable];
  //  [self updateSelectedObject];
}

- (void)updateFetchedTable{
    //self.fetchedTableViewController.tableView.delegate = self;
   // self.fetchedTableViewController.fetchedResultsController = self.fetchedResultsController;
}

- (void)setFetchedTableViewController:(MUIFetchedTableViewController *)fetchedTableViewController{
    if(fetchedTableViewController == _fetchedTableViewController){
        return;
    }
    _fetchedTableViewController = fetchedTableViewController;
    if(self.isViewLoaded){
        [self updateFetchedTable];
        [self updateSelectedObject];
    }
}

// this can't set anything
- (void)updateEditButton{
    self.editButtonItem.enabled = self.countOfFetchedObjects.integerValue > 0 && !self.isEditingRow;
}

- (BOOL)shouldShowDetailForObject:(NSManagedObject *)object{
    return YES;
}

- (BOOL)shouldAlwaysShowDetail{
    // checking view is visble doesn't work for middle if end is showing.
    if(self.resolvedSplitViewController.isCollapsed){
        UIViewController *dvc = self.resolvedSplitViewController.mui_detailViewManager.detailViewController;
        UINavigationController *masterNav = self.splitViewController.viewControllers.firstObject;
        if(![masterNav.viewControllers containsObject:dvc]){
            return NO;
        }
    } //!.mui_isViewVisible){
    return YES;
}

- (BOOL)shouldAlwaysHaveSelectedRow{
    // this work because nav controller's view stays while children are pushed.
    if(!self.shouldAlwaysShowDetail){
        return NO;
    }
    else if(self.isEditing || self.isEditingRow){
        return NO;
    }
    return YES;
}

// depenendednt on detail item and visible
//- (void)updateRowSelectionAnimated:(BOOL)animated scrollToSelection:(BOOL)scrollToSelection{
//- (void)updateRowSelectionForObject:(NSManagedObject *)object{
- (void)updateRowSelection{
    
    if(self.selectionIsUserDriven){
        return;
    }
    
    NSManagedObject * object = self.selectedObject;
    UITableView *tableView = self.fetchedTableViewController.tableView;
//    for (NSIndexPath *indexPath in tableView.indexPathsForSelectedRows) {
//        BOOL indexPathPushes = [self mui_willShowingDetailViewControllerPushWithSender:self];
//        if (indexPathPushes) {
//            // If we're pushing for this indexPath, deselect it when we appear
//            [tableView deselectRowAtIndexPath:indexPath animated:animated];
//        }
//    }
    
    // cant lookup selected indexes in the FRC here because its not updated yet.
//    for(NSIndexPath *indexPath in tableView.indexPathsForSelectedRows){
//        BOOL pushes;
//        NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
//        if([self shouldShowDetailForObject:object]){
//            pushes = [self willShowingDetailViewControllerPush];
//        } else {
//            pushes = [self mui_willShowingViewControllerPushWithSender:self];
//        }
//        if (pushes) {
//           // If we're pushing for this indexPath, deselect it when we appear
//           [tableView deselectRowAtIndexPath:indexPath animated:animated];
//        }
//    }
    
    /*
    if(!self.alwaysHaveSelectedObject){
        if(!self.isEditing && !self.isEditingRow){
            UITableView *tableView = self.fetchedTableViewController.tableView;
            for(NSIndexPath *indexPath in tableView.indexPathsForSelectedRows.copy){
                [tableView deselectRowAtIndexPath:indexPath animated:NO];
            }
        }
        return;
    }
    */
    
    // this work because nav controller's view stays while children are pushed.
    if(!self.shouldAlwaysHaveSelectedRow){
        return;
    }
//    else if(![self shouldShowDetailForObject:object]){
//        return;
//    }
//    else if([self willShowingDetailViewControllerPush]){
//        return;
//    }
    NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:object];
    if(!indexPath){
        return;
    }
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//    if(!scrollToSelection){
//        return;
//    }
   // [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:animated];
}

- (BOOL)alwaysHaveSelectedObject{
    // splitViewController  traitCollection horizontalSizeClass
    // isInHardwareKeyboardMode
//    if(![self.navigationController.viewControllers containsObject:self]){
//        return NO;
//    }
//    else if(self.resolvedSplitViewController.isCollapsed &&  ![self.navigationController.topViewController isKindOfClass:UINavigationController.class]){
//        return NO;
//    }
//    return YES;
    // can't check detail visible because during interactive pop it is visible but might go back on the stack so we would push a second detail on.
    
    // need to access the details split not our split.
    BOOL isCollapsed = self.resolvedSplitViewController.isCollapsed;
    NSUInteger u = self.resolvedSplitViewController.viewControllers.count;
    id i = self.resolvedSplitViewController;
    return !self.resolvedSplitViewController.isCollapsed || [self.navigationController.topViewController isKindOfClass:UINavigationController.class];
}

- (BOOL)alwaysHaveSelectedRow{
    BOOL result = NO;
  //  if(self.alwaysHaveSelectedObject){
//        if(self.tableView.isEditing){
//            result = self.isMovingOrDeletingNotes;
//        }
        result = !self.isEditing && !self.isEditingRow;
//    }
    return result;
}

// called on a appear and controller changed if the selected object was deleted.
//- (void)updateSelectedObject{
//    if(!self.alwaysHaveSelectedObject){
//        return;
//    }
    // start with current detail because it might only appear when we switch to landscape.
//    id object = self.currentDetailItem;
//    NSFetchedResultsController *fetchedResultsController = self.fetchedResultsController;
//    if(!object || ![fetchedResultsController indexPathForObject:object]){
//        object = self.selectedObject;
//        if(!object || ![fetchedResultsController indexPathForObject:object]){
//            object = fetchedResultsController.fetchedObjects.firstObject;
//        }
//    }
//    self.selectedObject = object;
//}

- (NSManagedObject *)currentDetailItem{
    //return [self mui_detailItemWithSender:self];
    return self.resolvedSplitViewController.mui_detailViewManager.detailViewController.mui_containedDetailItem;//WithSender:self];
}

- (void)updateCurrentDetailObject{
    
    UISplitViewController *splitViewController = self.resolvedSplitViewController;
     UIViewController *detailViewController = splitViewController.mui_detailViewManager.detailViewController;
    
//    if(!self.alwaysHaveSelectedObject){
//        return;
//    }
//    if(self.resolvedSplitViewController.isCollapsed){
//        return;
//    }
//    id object = self.selectedObject;
//    id currentObject = self;
//    if(object == currentObject){ // self.resolvedSplitViewController.mui_detailViewController.mui_detailItem
//        return;
//    }
//    else if(![self shouldShowDetailForObject:object]){
//        return;
//    }
//    else if([self willShowingDetailViewControllerPush]){
//        return;
//    }
//    [self showDetailWithObject:object];
    if(detailViewController.mui_containedDetailItem == self.selectedObject){
        return;
    }
    else if(!self.shouldAlwaysShowDetail){
        return;
    }
    [self _showViewControllerForObject:self.selectedObject];
}

- (void)viewWillAppear:(BOOL)animated {
    //BOOL isCollapsed = self.resolvedSplitViewController.isCollapsed;
   // [self updateSelectedObject]; // this won't cause updateCurrentDetailObject if we select nil because it is already nil by default.
    //[self updateCurrentDetailObject]; // in state restore portrait isCollapsed is No which causes the first object to be selected and shown.
   
    
    [self updateEditButton];
    BOOL isMovingToParentViewController = self.isMovingToParentViewController;
    BOOL c = self.isMovingFromParentViewController;
//    [self showSelectedObjectIsUserDriven:NO];
    //self.fetchedTableViewController.clearsSelectionOnViewWillAppear = c ?: self.resolvedSplitViewController.isCollapsed;
    id i = self.parentViewController.parentViewController;
    BOOL to = self.parentViewController.isMovingToParentViewController;
    BOOL from = self.parentViewController.isMovingFromParentViewController;
    self.fetchedTableViewController.clearsSelectionOnViewWillAppear = self.resolvedSplitViewController.isCollapsed;
    [super viewWillAppear:animated];
    
    //if(isMovingToParentViewController){
    MUIDetailViewManager *detailViewManager = self.resolvedSplitViewController.mui_detailViewManager;
    NSAssert(detailViewManager, @"Must have a collapse controller");
    [NSNotificationCenter.defaultCenter removeObserver:self name:MUIDetailViewManagerWillShowDetailViewControllerNotification object:detailViewManager];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didShowDetailViewController:) name:MUIDetailViewManagerWillShowDetailViewControllerNotification object:detailViewManager];
        
    [self updateSelectedObject];
    [self updateRowSelection];
}

- (void)didMoveToParentViewController:(UIViewController *)parent{
    [super didMoveToParentViewController:parent];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   // BOOL isCollapsed = self.resolvedSplitViewController.isCollapsed;
//    [self updateCurrentDetailObject]; // for main thing but also if encoded portrait on master that came back from a detail and restored in landscape.
    //[self updateRowSelectionAnimated:animated]; // ?
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    // for when deleting the item that is being interative popping and is cancelled.
    if(self.isMovingFromParentViewController){
        return;
    }
    //[self updateCurrentDetailObject];
}

- (void)updateView{
//    if(!self.resolvedSplitViewController.isCollapsed){
//        NSManagedObject *detailItem = self.currentDetailItem;
//        if(self.fetchedResultsController.fetchedObjects.count && ![self.fetchedResultsController.fetchedObjects containsObject:detailItem]){
//            detailItem = self.fetchedResultsController.fetchedObjects.firstObject;
//            [self selectObjectToShow:detailItem];
//        }
//        [self updateRowSelectionForObject:detailItem];
//    }
}

// must have appeared
- (void)didShowDetailViewController:(NSNotification *)notification{
    //MUIDetailViewManager *detailViewManager = notification.object;
    [self updateSelectedObject];
    [self updateRowSelection];
}

- (void)updateSelectedObject{
    if(self.selectionIsUserDriven){
        return;
    }
    MUIDetailViewManager * detailViewManager = self.resolvedSplitViewController.mui_detailViewManager;
    NSManagedObject *object = detailViewManager.detailViewController.mui_containedDetailItem;
    if(self.fetchedResultsController.fetchedObjects.count && ![self.fetchedResultsController.fetchedObjects containsObject:object]){
        object = self.fetchedResultsController.fetchedObjects.firstObject;
    }
    self.selectedObject = object;
}

// i.e. isCollapsed changed
- (void)showDetailTargetDidChange:(NSNotification *)notification{
    UISplitViewController *svc = self.resolvedSplitViewController; // workaround for object not correct
    
    [self updateSelectedObject];
    [self updateCurrentDetailObject];
    [self updateRowSelection];
    
    // so we always select first if in a new master.
    // turned this off because when on root and no detail was selected, rotating will select show the first on the detail even tho we aren't on the master.
    // actually added it back but added the check if always show detail.
    // removed it again because.
    //[self updateSelectedObject];
    
    
    //[self updateRowSelection];
    
   // [self updateView];
    
//    if(!self.resolvedSplitViewController.isCollapsed){
//
//    }
   // [self select];
    // its possible to find the detail if it wasn't previously.
   // [self configureViewForCurrentDetailObject];
    
    //}
    //BOOL b = self.view.window;
    //[self configureViewForCurrentDetailObject]; // shouldn't be calling this if not visible.
   // self.isCollapsed = !self.resolvedSplitViewController.isCollapsed;
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
        NSFetchedResultsController *frc = self.fetchedResultsController;
        NSManagedObject *object = [frc objectAtIndexPath:indexPath];
        // don't show if in landscape and the object is already selected.
        self.selectionIsUserDriven = YES;
        //[self setSelectedObject:object show:YES];
        self.selectedObject = object;
        [self _showViewControllerForObject:object];
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
    //[self.fetchedTableViewController controller:controller didChangeObject:anObject atIndexPath:indexPath forChangeType:type newIndexPath:newIndexPath];
    if(type != NSFetchedResultsChangeDelete){
        return;
    }
    else if(anObject == self.selectedObject){ // need to select the next one even if not visible.
        self.indexPathOfDeletedDetailItem = indexPath;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    //[self.fetchedTableViewController controllerDidChangeContent:controller];
    if(self.indexPathOfDeletedDetailItem){
        NSManagedObject *object;
        @try {
            object = [controller objectAtIndexPath:self.indexPathOfDeletedDetailItem];
        } @catch (NSException *exception) {
            object = controller.fetchedObjects.lastObject;
        }
        self.selectedObject = object;
        self.indexPathOfDeletedDetailItem = nil;
    }
    self.countOfFetchedObjects = @(controller.fetchedObjects.count);
}

//- (id)forwardingTargetForSelector:(SEL)aSelector{
//    if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDelegate), aSelector)){
//        if([self.fetchedTableViewController respondsToSelector:aSelector]){
//            return self.fetchedTableViewController;
//        }
//    }
////    else if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDataSource), aSelector)){
////        if([self.fetchedTableViewController respondsToSelector:aSelector]){
////            return self.fetchedTableViewController;
////        }
////    }
//    else if(MHFProtocolHasInstanceMethod(@protocol(NSFetchedResultsControllerDelegate), aSelector)){
//        if([self.fetchedTableViewController respondsToSelector:aSelector]){
//            return self.fetchedTableViewController;
//        }
//    }
//    else if(MHFProtocolHasInstanceMethod(@protocol(UIDataSourceModelAssociation), aSelector)){
//        if([self.fetchedTableViewController respondsToSelector:aSelector]){
//            return self.fetchedTableViewController;
//        }
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}

//- (BOOL)respondsToSelector:(SEL)aSelector{
//    if([super respondsToSelector:aSelector]){
//        return YES;
//    }
//    else if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDelegate), aSelector)){
//        if([self.fetchedTableViewController respondsToSelector:aSelector]){
//            return YES;
//        }
//    }
////    else if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDataSource), aSelector)){
////        if([self.fetchedTableViewController respondsToSelector:aSelector]){
////            return YES;
////        }
////    }
//    else if(MHFProtocolHasInstanceMethod(@protocol(NSFetchedResultsControllerDelegate), aSelector)){
//        if([self.fetchedTableViewController respondsToSelector:aSelector]){
//            return YES;
//        }
//    }
//    else if(MHFProtocolHasInstanceMethod(@protocol(UIDataSourceModelAssociation), aSelector)){
//        if([self.fetchedTableViewController respondsToSelector:aSelector]){
//            return YES;
//        }
//    }
//    return NO;
//}


#pragma mark - UIStateRestoration

#define kCurrentDetailObjectKey @"CurrentDetailObject"
#define kFetchedTableViewControllerKey @"fetchedTableViewController"
#define kSelectedObjectKey @"SelectedObject"

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    
    //if(self.detailViewController){
      //  [coder encodeObject:self.detailViewController forKey:MasterViewControllerStateRestorationDetailViewControllerKey];
    //}
    [coder encodeObject:self.fetchedTableViewController forKey:kFetchedTableViewControllerKey];
   // [coder encodeObject:self.persistentContainer forKey:MasterViewControllerStateRestorationPersistentContainerKey];
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
 //   self.selectedObject = [self.persistentContainer.viewContext mcd_existingObjectWithURI:objectURI error:nil];
    self.selectionIsUserDriven = NO;
    
}

// when should we update the selected row? Here or in view did appear?
// what about depending on if it is deleted or not?

- (void)applicationFinishedRestoringState{
    // because we depend on the detail object
    //[self updateSelectedObject];
    
    //self.selectedObject = self.resolvedSplitViewController.mui_currentSplitDetailItem.object;
    
   // [self.tableView layoutIfNeeded]; // fix going back unlight bu
   // [self reselectTableRowIfNecessary];
    // [self configureViewForCurrentDetailObject];
    
   // UISplitViewController *splitViewController = self.resolvedSplitViewController;
    //NSIndexPath *indexPath = self.fetchedTableViewController.tableView.indexPathForSelectedRow;
    //if(!self.resolvedSplitViewController.isCollapsed){
//    id detailItem = self.detailViewController.detailItem;
//    NSUInteger i = self.fetchedResultsController.fetchedObjects.count;
//    if((detailItem && ![self.fetchedResultsController.fetchedObjects containsObject:detailItem]) || (!detailItem && self.fetchedResultsController.fetchedObjects.count)){
//       // [self showObject:self.fetchedResultsController.fetchedObjects.firstObject]; // ok to be nil due to first part of if
//    }
}

@end

@implementation UIViewController (MUIMasterViewController)

//- (id)mui_detailItemWithSender:(id)sender{
//    UIViewController *target = [self targetViewControllerForAction:@selector(mui_detailItemWithSender:) sender:sender];
//    if(target){
//        return [target mui_detailItemWithSender:sender];
//    }else{
//        return nil;
//    }
//}
//
//- (void)mui_setDetailItem:(id)detailItem sender:(id)sender{
//    UIViewController *target = [self targetViewControllerForAction:@selector(mui_setDetailItem:sender:) sender:sender];
//    if(target){
//        [target mui_setDetailItem:detailItem sender:sender];
//    }
//}

@end
