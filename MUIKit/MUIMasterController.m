//
//  MUIMasterController.m
//  MUIKit
//
//  Created by Malcolm Hall on 28/10/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUIMasterController+Internal.h"
#import "MUITableViewController+Internal.h"
#import "UIViewController+MUI.h"

@implementation MUIMasterController

- (instancetype)initWithTableViewController:(MUITableViewController *)tableViewController{
    self = [super init];
    if (self) {
        _tableViewController = tableViewController;
        tableViewController.delegate = self;
        tableViewController.tableView.delegate = self;
    }
    return self;
}

#pragma mark - MUITableViewControllerDelegate

- (void)tableViewController:(MUITableViewController *)tableViewController viewWillAppear:(BOOL)animated{
    id item = [self.tableViewController mui_currentVisibleDetailItemWithSender:self.tableViewController];
    if (item) {
        NSIndexPath *indexPath = [self.dataSource masterController:self indexPathForMasterItem:item];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (void)tableViewController:(MUITableViewController *)tableViewController didEndEditing:(BOOL)animated{
    [self updateSelectionForCurrentVisibleDetailItem];
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDelegate), aSelector)){
        if([self.tableDelegate respondsToSelector:aSelector]){
            return self.tableDelegate;
        }
    }
    return [super forwardingTargetForSelector:aSelector];
}

//- (void)setTableViewController:(MUITableViewController *)tableViewController{
//    if(tableViewController == _tableViewController){
//        return;
//    }
//    else if(_tableViewController){
//        _tableViewController.tableView.delegate = nil;
//        //_tableViewController.navigationController.delegate = nil;
//    }
//    //tableViewController.navigationController.delegate = self;
//    tableViewController.tableView.delegate = self;
//    _tableViewController = tableViewController;
//}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.tableDelegate respondsToSelector:_cmd]){
        indexPath = [self.tableDelegate tableView:tableView willSelectRowAtIndexPath:indexPath];
    }
    if(!tableView.isEditing){
        self.selectedMasterItem = [self.dataSource masterController:self masterItemAtIndexPath:indexPath];
    }
    return indexPath;
}

- (UITableView *)tableView{
    return self.tableViewController.tableView;
}

// rename to should Currently
- (BOOL)shouldAlwaysHaveSelectedObject{
    if(self.tableViewController.splitViewController.isCollapsed){
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
    id selectedMasterItem = self.selectedMasterItem;
    if(!selectedMasterItem){
        return;
    }
    //    if([self mui_containsDetailItem:detailItem]){
    //        return;
    //    }
    NSIndexPath *indexPath = [self.dataSource masterController:self indexPathForMasterItem:selectedMasterItem];
    if(!indexPath){
        //   NSIndexPath *ip = self.selectedRowOfDetailItem;
        //   [self selectMasterItemNearIndexPath:ip];
        return;
    }
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];

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

    }
    //self.selectedObject = object;
    //if(!self.splitViewController.isCollapsed){
    id masterItem;
    if(newIndexPath){
        masterItem = [self.dataSource masterController:self masterItemAtIndexPath:newIndexPath];
    }
    self.selectedMasterItem = masterItem;
    [self.delegate showSelectedItemForMasterController:self];
    [self updateSelectionForCurrentVisibleDetailItem];
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
//        // [self updateSelectionForCurrentVisibleDetailItem];
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
//            [self updateSelectionForCurrentVisibleDetailItem];
//        }];
//    }
//    [super setEditing:editing animated:animated];
//    if(!editing){
//        if(animated){
//            [CATransaction commit];
//        }
//        else{
//            [self updateSelectionForCurrentVisibleDetailItem]; // test if needs a perform after delay.
//        }
//    }
//    //self.deleteButton.enabled = editing && !self.tableViewEditingRowIndexPath;
//}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    //self.tableViewEditingRowIndexPath = indexPath;
    //[super tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
    //[r20 updateNavAndBarButtonsAnimated:0x0];
    if([self.tableDelegate respondsToSelector:_cmd]){
        return [self.tableDelegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
    }
    self.tableViewController.editButtonItem.enabled = NO;
}

// since during swipe to delete the selection highlight is lost we need to bring it back.
-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.tableDelegate respondsToSelector:_cmd]){
        return [self.tableDelegate tableView:tableView didEndEditingRowAtIndexPath:indexPath];
    }
    //    [super tableView:tableView didEndEditingRowAtIndexPath:indexPath];
    //    if(indexPath){
    //        if(![self.tableViewEditingRowIndexPath isEqual:indexPath]){
    //            NSLog(@"Note list table view editing index path mismatch %@ expects %@", indexPath, self.tableViewEditingRowIndexPath);
    //        }
    //    }
    //    self.tableViewEditingRowIndexPath = nil;
    //NSIndexPath *ip = tableView.indexPathForSelectedRow;
    // [r20 updateNavAndBarButtonsAnimated:0x0];
    self.tableViewController.editButtonItem.enabled = YES;
    [self performSelector:@selector(updateSelectionForCurrentVisibleDetailItem) withObject:nil afterDelay:0];
}

// We're not a data source
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if([self.tableDelegate respondsToSelector:_cmd]){
//        [self.tableDelegate tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
//    }
//    [self selectMasterItemNearIndexPath:indexPath];
//}

@end
