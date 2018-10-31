//
//  MUIMasterTableViewController.m
//  MUIKit
//
//  Created by Malcolm Hall on 15/09/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//
// Should handle the selected row being deleted by the user.

#import "MUIMasterTableViewController.h"
#import "UIViewController+MUI.h"

@interface MUIMasterTableViewController ()

// used to help select a row close to the deleted one.
@property (nonatomic, strong, nullable) NSIndexPath *selectionPathOfDeletedRow;
// used to differentiate between edit button and swipe to delete.
@property (nonatomic, strong, nullable) NSIndexPath *tableViewEditingRowIndexPath;
// when entering edit the selected row is deselected so this hangs onto it so we can select a nearby row.
//@property (nonatomic, strong, nullable) NSIndexPath *selectedRowBeforeEditing;
@property (nonatomic, strong, nullable) NSIndexPath *selectedRowDuringEditing;

@property (strong, nonatomic, readwrite) id selectedObject;

@end

@implementation MUIMasterTableViewController

- (void)showSelectedItem{
    [self performSegueWithIdentifier:@"showDetail" sender:nil];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!self.isEditing){
        self.selectedObject = [self objectAtIndexPath:indexPath];
    }
    return indexPath;
}

// rename to should Currently
- (BOOL)shouldAlwaysHaveSelectedObject{
    if(self.splitViewController.isCollapsed){
        //if(!self.shouldHaveSelectedObjectWhenNotInEditMode){
        return NO;
    }
    else if(self.tableView.isEditing){
        return NO;
    }
    return YES;//!self.isMovingOrDeletingObjects;
}

- (void)updateSelectionForCurrentVisibleDetailItem{
    if(!self.shouldAlwaysHaveSelectedObject){
        return;
    }
    id selectedObject = self.selectedObject;
    if(!selectedObject){
        return;
    }
    //    if([self mui_containsDetailItem:detailItem]){
    //        return;
    //    }
    NSIndexPath *indexPath = [self indexPathForObject:selectedObject];
    if(!indexPath){
        //   NSIndexPath *ip = self.selectedRowOfDetailItem;
        //   [self selectMasterItemNearIndexPath:ip];
        return;
    }
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    //[self selectRowForObject:detailItem];
    //[self showObject:self.fetchedDataSource.fetchedResultsController.fetchedObjects.firstObject];//: startEditing:NO];
    //[self showItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

// if there are more rows beyond the index then use current index otherwise use 1 less.
- (void)selectMasterItemNearIndexPath:(NSIndexPath *)indexPath{
    // NSAssert(!self.tableView.isEditing, @"Cannot select while editing");
    NSUInteger count = [self.tableView numberOfRowsInSection:indexPath.section] ;//self.fetchedResultsController.fetchedObjects.count;
    //id item;
    NSIndexPath *newIndexPath;
    if(count){
        NSUInteger row = count - 1;
        if(indexPath.row < row){
            row = indexPath.row;
        }
        newIndexPath = [NSIndexPath indexPathForRow:row inSection:indexPath.section];
        //object = [self.fetchedResultsController objectAtIndexPath:ip];
        //UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:indexPath.section]];
        //id c = cell.selectionSegueTemplate; // UIStoryboardShowSegueTemplate
        
        // select the row so it'll work in prepareForSegue.
        // it wont work if editing but update selection after editing will
        //[self.tableView selectRowAtIndexPath:ip animated:NO scrollPosition:0];
        //[[cell selectionSegueTemplate] performSelector:NSSelectorFromString(@"perform:") withObject:cell];
    }
    //self.selectedObject = object;
    //if(!self.splitViewController.isCollapsed){
    id object;
    if(newIndexPath){
        object = [self objectAtIndexPath:newIndexPath];
    }
    self.selectedObject = object;
    [self showSelectedItem];
    [self updateSelectionForCurrentVisibleDetailItem];
    // can't select the row just now because might be in editing.
    //[self performSelector:@selector(reselectRowForVisibleDetailItem) withObject:nil afterDelay:0];
    //}
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailTargetDidChange:) name:UIViewControllerShowDetailTargetDidChangeNotification object:self.splitViewController];
}

// update cell accessories.
- (void)showDetailTargetDidChange:(NSNotification *)notification{
    for (UITableViewCell *cell in self.tableView.visibleCells) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        [self.tableView.delegate tableView:self.tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

//- (BOOL)shouldHaveSelectedObjectWhenNotInEditMode{
//    // splitViewController  traitCollection horizontalSizeClass
//    // isInHardwareKeyboardMode
//    //return !self.splitViewController.isCollapsed;
//    //return self.traitCollection.horizontalSizeClass != UIUserInterfaceSizeClassCompact;
//    //return !self.clearsSelectionOnViewWillAppear;
//    BOOL pushes;
//    if(self.showsDetail){
//        pushes = [self mcd_willShowingDetailViewControllerPushWithSender:self];
//    } else {
//        pushes = [self mcd_willShowingViewControllerPushWithSender:self];
//    }
//    return !pushes;
//}

// bug in restoration that selected cell does not unhighlight.
// we don't select a row if nothing was selected before.
- (void)viewWillAppear:(BOOL)animated{
    //self.clearsSelectionOnViewWillAppear = !self.shouldAlwaysHaveSelectedObject;
    self.selectedObject = [self mui_currentVisibleDetailItemWithSender:self];
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated]; // if numberOfSections == 0 then it reloads data. But reloads anyway because of didMoveToWindow. It also clears selection.
    
    //    for (NSIndexPath *indexPath in self.tableView.indexPathsForSelectedRows) {
    //        //if ([self isPushingForIndexPath:indexPath]) {
    //        if(self.isPushing){
    //            // If we're pushing for this indexPath, deselect it when we appear
    //            [self.tableView deselectRowAtIndexPath:indexPath animated:animated];
    //        }
    //    }
    
    // reselect row if it is showing on right
    //    NSManagedObject *visibleObject =
    //    if (visibleObject) {
    //         = visibleObject;
    //        NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:visibleObject] ;//[self indexPathContainingDetailObject:visibleObject];
    //        if(indexPath){
    //            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    //            return;
    //        }
    //   }
    //    NSManagedObject *object = self.fetchedResultsController.fetchedObjects.firstObject;
    //    [self showDetailObjectForObject:object];
    
    // reason for dispatch is when seperating from portrait we cant find the detail object.
    //dispatch_async(dispatch_get_main_queue(), ^{
    //[self updateSelectionInTableViewAnimated:NO];
    //});
    //    //[self updateSelectionForCurrentViewedObjectAnimated:animated];
    //    if(self.needsToUpdateViewsForCurrentFetchController){
    //        [self updateViewsForCurrentFetchController];
    //    }
    //if([NSStringFromClass(self.class) isEqualToString:@"InitialViewController"]){
    //[self performSelector:@selector(aaa) withObject:nil afterDelay:10];
    //}
    // this is for when in split and reselecting what is in detail. Not when seperating because detail object is nil.
    if(!self.clearsSelectionOnViewWillAppear){
       // [self updateSelectionForCurrentVisibleDetailItem];
    }
}


//- (void)updateViewsForCurrentFetchControllerIfNecessary{
//    if(self.isViewLoaded && self.tableView.window){
//        [self updateViewsForCurrentFetchController];
//    }else{
//        self.needsToUpdateViewsForCurrentFetchController = YES;
//    }
//}

//- (void)updateViewsForCurrentFetchController{
//    [self.tableView reloadData];
//
//    NSManagedObject *selectedObject = [self mcd_currentVisibleDetailObjectWithSender:self];
//    if(!selectedObject){
//        self.selectedObject = self.fetchedResultsController.fetchedObjects.firstObject;
//        [self showSelectedObject];//:self.fetchedResultsController.fetchedObjects.firstObject startEditing:NO];
//        return;
//    }
//
//    NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:selectedObject];
//    if(!indexPath){
//        self.selectedObject = self.fetchedResultsController.fetchedObjects.firstObject;
//        [self showSelectedObject];//:self.fetchedResultsController.fetchedObjects.firstObject startEditing:NO];
//        return;
//    }
//    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:0];
//    [self showNotesListNote:note startEditing:self.noteEditorIsEditing];
//}



//- (NSArray *)tableViewIndexPathsForSelectedEditableRows{
//    if(self.tableViewEditingRowIndexPath){
//        return @[self.tableViewEditingRowIndexPath];
//    }
//    return self.tableView.indexPathsForSelectedRows.copy;
//}
//

//- (void)updateSelectionInTableViewAnimated:(BOOL)animated{
//    [self updateSelectionInTableViewAnimated:animated scrollToSelection:NO];
//}

// only for when pushign doesnt work with rotation.
//- (void)updateSelectionInTableViewAnimated:(BOOL)animated scrollToSelection:(BOOL)scrollToSelection{
    //    NSManagedObject *object = [self mcd_currentVisibleDetailObjectWithSender:self];
    //    if(!object || !self.shouldAlwaysHaveSelectedObject){
    //        return;
    //    }
    //    //NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:object]; // replace with contains object
    //    NSIndexPath *indexPath = [self indexPathContainingDetailObject:object];
    //    if(!indexPath){
    //        return;
    //    }
    //    UITableView *tableView = self.tableView;
    //    [tableView selectRowAtIndexPath:indexPath animated:animated scrollPosition:0];
    //    if(!scrollToSelection){
    //        return;
    //    }
    //    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:0 animated:animated];


// when editing there is nolonger the row selected so we saved it.
//- (NSIndexPath *)selectedRowOfDetailItem{
//    if(self.isEditing){
//        return self.selectedRowBeforeEditing;
//    }
//    return self.tableView.indexPathForSelectedRow;
//}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    //self.selectedRowBeforeEditing = editing ? self.tableView.indexPathForSelectedRow : nil;
    if(!editing && animated){
        // because otherwise the checkmark gets selected when sliding back.
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            [self updateSelectionForCurrentVisibleDetailItem];
        }];
    }
    [super setEditing:editing animated:animated];
    if(!editing){
        if(animated){
            [CATransaction commit];
        }
        else{
            [self updateSelectionForCurrentVisibleDetailItem]; // test if needs a perform after delay.
        }
    }
    //self.deleteButton.enabled = editing && !self.tableViewEditingRowIndexPath;
}

// ICNotesListViewController
// Called from note container did change.
// tables been reloaded so shouldn't be anything to deselect, the return is important though. Maybe also showing a nil object is too though.
//- (void)updateSelectionForFetchedObjectsAnimated:(BOOL)animated{
// if in portrait we don't show detail objects.
//    NSUInteger i = self.tableViewIndexPathsForSelectedEditableRows.count;
//    if(!self.tableViewIndexPathsForSelectedEditableRows.count){
//        // if doesnt show detail among other things
//        if(!self.shouldAlwaysHaveSelectedObject){
//            if(!self.tableView.isEditing){
//                for(NSIndexPath *indexPath in self.tableView.indexPathsForSelectedRows.copy){
//                    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
//                }
//            }
//            return;
//        }
//    }
//    if(!self.shouldAlwaysHaveSelectedObject){
//        return;
//    }
//    // doesnt find the object when seperating
//    NSManagedObject *object = [self mcd_currentVisibleDetailObjectWithSender:self];//self.shownViewController.viewedObject;
//    if(object){
//        // checks if the detail object exists in this fetch
//        id i = self.fetchedResultsController.fetchedObjects;
//        NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:object];// [self indexPathForNote:note];
//        if(indexPath){
//            // it will be selected in viewWillAppears
//            return;
//        }
//    }
//    // default to first object.
//    object = self.fetchedResultsController.fetchedObjects.firstObject;
//    if(object){
//        NSIndexPath *firstIndex = [NSIndexPath indexPathForRow:0 inSection:0];
//        [self.tableView selectRowAtIndexPath:firstIndex animated:animated scrollPosition:0];
//    }
//    [self showObject:object startEditing:NO];
//}

//- (void)updateSelectionInTableViewAnimated:(BOOL)animated scrollToSelection:(BOOL)scrollToSelection{
//    if(!self.shouldAlwaysHaveSelectedObject){
//        return;
//    }
//    NSManagedObject *object = self.selectedObject;
//    if(!object){
//        return;
//    }
//    NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:object];
//    if(!indexPath){
//        return;
//    }
//    UITableView *tableView = self.tableView;
//    [tableView selectRowAtIndexPath:indexPath animated:animated scrollPosition:0];
//    if(scrollToSelection){
//        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:0 animated:animated];
//    }
//}

#pragma mark - Table Delegate
/*
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.shouldAlwaysHaveSelectedObject){
        self.selectedObject = [self.dataSource objectAtIndexPath:indexPath];
    }
    return indexPath;
}


 // called by didMoveToWindow aswell and layoutsubviews
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 return self.fetchedResultsController.sections.count;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
 return self.fetchedResultsController.sections[section].numberOfObjects;
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
 UITableViewCell *cell = [self cellForObject:object atIndexPath:indexPath];
 if([indexPath isEqual:tableView.indexPathForSelectedRow]){
 cell.selected = YES;
 }
 [self configureCell:cell withObject:object];
 return cell;
 //    if(![object conformsToProtocol:@protocol(MCDTableViewCellObject)]){
 //        return nil;
 //    }
 //    static NSString *kCellIdentifier = @"MCDTableViewCell";
 //MCDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCDTableViewCell"];
 //    if(!cell){
 //        cell = [MCDTableViewCell.alloc initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
 //    }
 //return cell;
 }
 
 - (BOOL)shouldShowDetailForIndexPath:(NSIndexPath *)indexPath{
 return YES;
 }
 
 - (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 BOOL pushes;
 // if ([self shouldShowConversationViewForIndexPath:indexPath]) {
 if([self shouldShowDetailForIndexPath:indexPath]){
 pushes = [self mcd_willShowingDetailViewControllerPushWithSender:self];
 } else {
 pushes = [self mcd_willShowingViewControllerPushWithSender:self];
 }
 
 // Only show a disclosure indicator if we're pushing
 if (pushes) {
 cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
 } else {
 cell.accessoryType = UITableViewCellAccessoryNone;
 }
 }
 
 */

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    //self.tableViewEditingRowIndexPath = indexPath;
    //[super tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
    //[r20 updateNavAndBarButtonsAnimated:0x0];
    self.editButtonItem.enabled = NO;
}

// since during swipe to delete the selection highlight is lost we need to bring it back.
-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
//    [super tableView:tableView didEndEditingRowAtIndexPath:indexPath];
//    if(indexPath){
//        if(![self.tableViewEditingRowIndexPath isEqual:indexPath]){
//            NSLog(@"Note list table view editing index path mismatch %@ expects %@", indexPath, self.tableViewEditingRowIndexPath);
//        }
//    }
//    self.tableViewEditingRowIndexPath = nil;
    //NSIndexPath *ip = tableView.indexPathForSelectedRow;
    // [r20 updateNavAndBarButtonsAnimated:0x0];
    self.editButtonItem.enabled = YES;
    [self performSelector:@selector(updateSelectionForCurrentVisibleDetailItem) withObject:nil afterDelay:0];
}

//- (void)scrollToObject:(id)object{
//    NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:object];
//    //NSManagedObjectContext *context = self.fetchedResultsController.managedObjectContext;
//    //indexPath = [self indexPathForFolderInTableViewFromFetchedResultsControllerIndexPath:indexPath managedObjectContext:context];
//    if(indexPath){
//        if(![self.tableView.indexPathsForVisibleRows containsObject:indexPath]){
//            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
//        }
//    }
//}



//- (void)configureDetailViewControllerWithObject:(NSManagedObject *)object{
//    self.shownViewController.viewedObject = object;
//}

//- (void)showDetailObject:(id)viewedObject{
//    NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:viewedObject];
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//    [self performSegueWithIdentifier:@"showDetail" sender:cell];
//}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"didDeselectRowAtIndexPath");
//}

#pragma mark - Restoration

// on encode it asks for first and selected. On restore it asks for first so maybe checks ID.
//- (nullable NSString *)modelIdentifierForElementAtIndexPath:(NSIndexPath *)idx inView:(UIView *)view{
//    //NSAssert(self.fetchedTableDataSource.fetchedResultsController.fetchedObjects, @"modelIdentifierForElementAtIndexPath requires fetchedObjects");
//    NSManagedObject *object = [self.fetchedTableDataSource.fetchedResultsController objectAtIndexPath:idx];
//    return object.objectID.URIRepresentation.absoluteString;
//}
//
//- (nullable NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view{
//    NSURL *objectURI = [NSURL URLWithString:identifier];
//    //  NSAssert(self.managedObjectContext, @"indexPathForElementWithModelIdentifier requires a context");
//    NSManagedObject *object = [self.fetchedTableDataSource.fetchedResultsController.managedObjectContext mcd_objectWithURI:objectURI];
//    //[self.tableView reloadData];
//    //  NSAssert(self.fetchedTableDataSource.fetchedResultsController.fetchedObjects, @"indexPathForElementWithModelIdentifier requires fetchedObjects");
//    return [self.fetchedTableDataSource.fetchedResultsController indexPathForObject:object];
//}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder{
    [super encodeRestorableStateWithCoder:coder];
    
    //
    //    id i = self.tableView.indexPathForSelectedRow;
    //    NSLog(@"");
    //
    //    NSManagedObjectID *objectID = dvc.viewedObject.objectID;
    //    if(!objectID){
    //        return;
    //    }
    //    [coder encodeObject:objectID.URIRepresentation forKey:kDetailObjectKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    //[self.tableView reloadData];
    //    NSURL *objectURL = [coder decodeObjectForKey:kDetailObjectKey];
    //    if(!objectURL){
    //        return;
    //    }
    //    NSManagedObjectContext *moc = context;
    //    NSManagedObjectID *objectID = [moc.persistentStoreCoordinator managedObjectIDForURIRepresentation:objectURL];
    //    if(!objectID){
    //        return;
    //    }
    //    NSManagedObject *object = [moc objectWithID:objectID];
    //    dvc.viewedObject = object;
}

@end
