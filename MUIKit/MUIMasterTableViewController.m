//
//  MUIMasterTableViewController.m
//  MUIKit
//
//  Created by Malcolm Hall on 28/10/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUIMasterTableViewController.h"
#import "UIViewController+MUIShowing.h"
#import "UIViewController+MUIDetail.h"

@interface MUIMasterTableViewController()

//@property (strong, nonatomic, readwrite) id selectedMasterItem;

@end

@implementation MUIMasterTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(showDetailTargetDidChange:) name:UIViewControllerShowDetailTargetDidChangeNotification object:self.splitViewController];
}

// update cell accessories.
- (void)showDetailTargetDidChange:(NSNotification *)notification{
    if(![self respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]){
        return;
    }
    for (UITableViewCell *cell in self.tableView.visibleCells) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        [self tableView:self.tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

//- (void)setSelectedMasterItem:(id)selectedMasterItem{
//    if(selectedMasterItem == _selectedMasterItem){
//        return;
//    }
//    _selectedMasterItem = selectedMasterItem;
//    [self selectedMasterItemDidChange];
//}

#pragma mark - View Controller

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    //self.selectedRowBeforeEditing = editing ? self.tableView.indexPathForSelectedRow : nil;
    if(!editing && animated){
        // because otherwise the checkmark gets selected when sliding back.
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            //[self.masterSupport updateSelectionForCurrentSelectedMasterItem];
           [self updateSelectionForCurrentSelectedMasterItem];
        }];
    }
    [super setEditing:editing animated:animated];
    if(!editing){
        if(animated){
            [CATransaction commit];
        }
        else{
            //[self.masterSupport updateSelectionForCurrentSelectedMasterItem]; // test if needs a perform after delay.
            [self updateSelectionForCurrentSelectedMasterItem];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (NSIndexPath *indexPath in self.tableView.indexPathsForSelectedRows) {
        BOOL indexPathPushes = [self mui_willShowingDetailViewControllerPushWithSender:self];
        if (indexPathPushes) {
            // If we're pushing for this indexPath, deselect it when we appear
            [self.tableView deselectRowAtIndexPath:indexPath animated:animated];
        }
    }
    id item = [self mui_currentVisibleDetailItemWithSender:self];
    //if (item) {
    self.selectedMasterItem = item;
    //NSIndexPath *indexPath = [self.delegate masterTableViewController:self indexPathForMasterItem:item];
    //[self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self updateSelectionForCurrentSelectedMasterItem];
    //}
}

// after the detail is shown then we grab the new master item and update the cell.
//- (void)showDetailViewController:(UIViewController *)vc sender:(id)sender{
//    [super showDetailViewController:vc sender:sender];
    //self.selectedMasterItem = [self mui_currentVisibleDetailItemWithSender:self];;
    //[self updateSelectionForCurrentSelectedMasterItem]}

//- (id)forwardingTargetForSelector:(SEL)aSelector{
//    if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDelegate), aSelector)){
//        if([self.tableDelegate respondsToSelector:aSelector]){
//            return self.tableDelegate;
//        }
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if([self.tableDelegate respondsToSelector:_cmd]){
//        [self.tableDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
//    }
//}

//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
////    if([self.tableDelegate respondsToSelector:_cmd]){
////        indexPath = [self.tableDelegate tableView:tableView willSelectRowAtIndexPath:indexPath];
////    }
////    return indexPath;
//    if(tableView.isEditing){
//        return indexPath;
//    }
//    self.selectedMasterItem = [self.delegate masterTableViewController:self masterItemAtIndexPath:indexPath];
//    return nil;
//      NSIndexPath *ip = tableView.indexPathForSelectedRow;
//    return nil;
//}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//        self.selectedMasterItem = [self.delegate masterTableViewController:self masterItemAtIndexPath:indexPath];
//    }
    // in case of allowsSelectionDuringEditing
//    if(tableView.isEditing){
//        return;
//    }
//    NSIndexPath *ip = tableView.indexPathForSelectedRow;
//    // do this after they showed a new detail controller.
//    [self performSelector:@selector(updateSelectedMasterItem) withObject:nil afterDelay:0];
//
//}

- (void)updateSelectedMasterItem{
    self.selectedMasterItem = [self mui_currentVisibleDetailItemWithSender:self];
}


// we don't perform table cell segues when editing but we allow other segues like from bar button items.
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if([sender isKindOfClass:UITableViewCell.class] && self.isEditing){
        return NO;
    }
    return YES;
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

- (void)updateSelectionForCurrentSelectedMasterItem{
    if(!self.shouldAlwaysHaveSelectedObject){
        return;
    }
    id selectedMasterItem = self.selectedMasterItem;
    if(!selectedMasterItem){
        return;
    }
    //    if([self mui_containsDetailItem:detailItem]){
    //        return;
    //    }
    NSIndexPath *indexPath = [self.datasource masterTableViewController:self indexPathForMasterItem:selectedMasterItem];
    if(!indexPath){
        //   NSIndexPath *ip = self.selectedRowOfDetailItem;
        //   [self selectMasterItemNearIndexPath:ip];
        return;
    }
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)setSelectedMasterItem:(id)selectedMasterItem notify:(BOOL)notify{
    self.selectedMasterItem = selectedMasterItem;
    if(notify){
        [self.delegate masterTableViewControllerDidSelectMasterItem:self];
        [self updateSelectionForCurrentSelectedMasterItem];
    }
}

//- (void)viewDidLoad{
//    [super viewDidLoad];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailTargetDidChange:) name:UIViewControllerShowDetailTargetDidChangeNotification object:self.splitViewController];
//}

// update cell accessories.
//- (void)showDetailTargetDidChange:(NSNotification *)notification{
//    for (UITableViewCell *cell in self.tableView.visibleCells) {
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//        [self.tableView.delegate tableView:self.tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
//    }
//}

// bug in restoration that selected cell does not unhighlight.
// we don't select a row if nothing was selected before.
//- (void)viewWillAppear:(BOOL)animated{
//    //self.clearsSelectionOnViewWillAppear = !self.shouldAlwaysHaveSelectedObject;
//    self.selectedObject = [self mui_currentVisibleDetailItemWithSender:self];
//    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
//    [super viewWillAppear:animated]; // if numberOfSections == 0 then it reloads data. But reloads anyway because of didMoveToWindow. It also clears selection.
//
//    if(!self.clearsSelectionOnViewWillAppear){
//        // [self updateSelectionForCurrentSelectedMasterItem];
//    }
//}


//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    NSLog(@"willShowViewController");
//}
//
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    NSLog(@"didShowViewController");
//}


//- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
//    //self.selectedRowBeforeEditing = editing ? self.tableView.indexPathForSelectedRow : nil;
//    if(!editing && animated){
//        // because otherwise the checkmark gets selected when sliding back.
//        [CATransaction begin];
//        [CATransaction setCompletionBlock:^{
//            [self updateSelectionForCurrentSelectedMasterItem];
//        }];
//    }
//    [super setEditing:editing animated:animated];
//    if(!editing){
//        if(animated){
//            [CATransaction commit];
//        }
//        else{
//            [self updateSelectionForCurrentSelectedMasterItem]; // test if needs a perform after delay.
//        }
//    }
//    //self.deleteButton.enabled = editing && !self.tableViewEditingRowIndexPath;
//}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    //self.tableViewEditingRowIndexPath = indexPath;
    //[super tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
    //[r20 updateNavAndBarButtonsAnimated:0x0];
//    if([self.tableDelegate respondsToSelector:_cmd]){
//        [self.tableDelegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
//    }
    self.editButtonItem.enabled = NO;
}

// since during swipe to delete the selection highlight is lost we need to bring it back.
-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
//    if([self.tableDelegate respondsToSelector:_cmd]){
//        [self.tableDelegate tableView:tableView didEndEditingRowAtIndexPath:indexPath];
//    }
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
    [self performSelector:@selector(updateSelectionForCurrentSelectedMasterItem) withObject:nil afterDelay:0];
}

// We're not a data source
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if([self.tableDelegate respondsToSelector:_cmd]){
//        [self.tableDelegate tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
//    }
//    [self selectMasterItemNearIndexPath:indexPath];
//}

@end
