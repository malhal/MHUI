//
//  MUIPrimaryTableViewController.m
//  MUIKit
//
//  Created by Malcolm Hall on 28/10/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUIPrimaryTableViewController.h"
#import "UIViewController+MUIShowing.h"
#import "UIViewController+MUIDetail.h"
#import "UISplitViewController+MUI.h"

@interface MUIPrimaryTableViewController()

//@property (strong, nonatomic, readwrite) id selectedMasterItem;

@end

@implementation MUIPrimaryTableViewController


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

- (void)updateSelectionForCurrentSecondaryItem{
    if(!self.shouldAlwaysHaveSelectedObject){
        return;
    }
    id secondaryItem = self.secondaryViewController.secondaryItem;
    if(!secondaryItem){
        return;
    }
    NSIndexPath *indexPath = [self.delegate primaryTableViewController:self indexPathForItem:secondaryItem];
    if(!indexPath){
        //   NSIndexPath *ip = self.selectedRowOfDetailItem;
        //   [self selectMasterItemNearIndexPath:ip];
        return;
    }
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)showDetailTargetDidChange:(NSNotification *)notification{
    // update cell accessories.
    if(![self respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]){
        return;
    }
    for (UITableViewCell *cell in self.tableView.visibleCells) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        [self tableView:self.tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
    [self updateSelectionForCurrentSecondaryItem];
}

#pragma mark - Primary Table View Controller

- (void)tableViewDidEndEditing{
    [self updateSelectionForCurrentSecondaryItem];
}

#pragma mark - View Controller

- (void)viewDidLoad{
    [super viewDidLoad];
    
    // was nil when UI restoration changed to use isMovingToParentViewController below
//    if(!self.splitViewController.isCollapsed){
//        id i = self.splitViewController.viewControllers.lastObject.childViewControllers.firstObject;
//        self.secondaryViewController = i;
//    }
}

- (void)viewWillAppear:(BOOL)animated{
    // only do this for the first appear
    if(self.isMovingToParentViewController){
        // only when in split view
        if(!self.splitViewController.isCollapsed){
            UIViewController *vc = self.splitViewController.mui_secondaryNavigationController.viewControllers.firstObject;
            if([vc conformsToProtocol:@protocol(MUISecondaryViewController)]){
                self.secondaryViewController = (UIViewController<MUISecondaryViewController> *)vc;
            }
        }
    }
    
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
    
//    for (NSIndexPath *indexPath in self.tableView.indexPathsForSelectedRows) {
//        BOOL indexPathPushes = [self mui_willShowingDetailViewControllerPushWithSender:self];
//        if (indexPathPushes) {
//            // If we're pushing for this indexPath, deselect it when we appear
//            [self.tableView deselectRowAtIndexPath:indexPath animated:animated];
//        }
//    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailTargetDidChange:) name:UIViewControllerShowDetailTargetDidChangeNotification object:self.splitViewController];
    
    [self updateSelectionForCurrentSecondaryItem];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // prevent doing unnecessary things while not visible
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIViewControllerShowDetailTargetDidChangeNotification object:self.splitViewController];
}

// we don't perform table cell segues when editing but we allow other segues like from bar button items.
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if([sender isKindOfClass:UITableViewCell.class] && self.isEditing){
        return NO;
    }
    return YES;
}

@end
