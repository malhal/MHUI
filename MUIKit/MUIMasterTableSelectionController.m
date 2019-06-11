//
//  MUIMasterTableSelectionController.m
//  MUIKit
//
//  Created by Malcolm Hall on 28/10/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUIMasterTableSelectionController.h"
#import "UIViewController+MUIShowing.h"
#import "UIViewController+MUIDetail.h"
#import "UISplitViewController+MUI.h"


@interface MUIMasterTableSelectionController()

//@property (strong, nonatomic, readwrite) id selectedMasterItem;



@end

@implementation MUIMasterTableSelectionController
//@synthesize collapseControllerForMaster = _collapseControllerForMaster;

//- (void)encodeRestorableStateWithCoder:(NSCoder *)coder{
//    [super encodeRestorableStateWithCoder:coder];
    //[coder encodeObject:self.masterDetailContext forKey:@"MasterDetailContext"];
    //[coder encodeObject:self.masterDetailContext.detailItem.objectID.URIRepresentation forKey:@"DetailItem"];
//}

//- (void)decodeRestorableStateWithCoder:(NSCoder *)coder{
//    [super decodeRestorableStateWithCoder:coder];
    //self.masterDetailContext = [coder decodeObjectForKey:@"MasterDetailContext"];
//    NSURL *objectURI = [coder decodeObjectForKey:@"DetailItem"];
//    if(objectURI){
//        self.masterDetailContext.detailItem = [self.managedObjectContext mcd_objectWithURI:objectURI];
//    }
//}

- (instancetype)initWithTableViewController:(MUITableViewController *)tableViewController
{
    self = [super init];
    if (self) {
        _tableViewController = tableViewController;
        tableViewController.delegate = self;
    }
    return self;
}

#pragma mark - MUITableViewControllerDelegate

//- (void)tableViewControllerViewDidLoad:(MUITableViewController *)tableViewController{
//    self.tableViewController = tableViewController;
//}

- (UITableView *)tableView{
    return self.tableViewController.tableView;
}

//- (BOOL)containsDetailItem:(NSObject *)detailItem{
//    return [self.dataSource masterTableSelectionController:self indexPathForItem:detailItem];
//}

// rename to should Currently
- (BOOL)shouldAlwaysHaveSelectedDetailItem{
    if(self.tableViewController.mui_collapseControllerForMaster.splitViewController.isCollapsed){
        //if(!self.shouldHaveSelectedObjectWhenNotInEditMode){
        return NO;
    }
    else if(self.tableView.isEditing){
        return NO;
    }
    return YES;//!self.isMovingOrDeletingObjects;
}

- (void)updateTableSelectionForCurrentSelectedDetailItem{
    if(!self.shouldAlwaysHaveSelectedDetailItem){
        return;
    }
    id detailItem = self.tableViewController.mui_collapseControllerForMaster.detailViewController.detailItem;
    if(!detailItem){
        return;
    }
    //NSIndexPath *indexPath = [self.dataSource masterTableSelectionController:self indexPathForItem:detailItem];
    NSIndexPath *indexPath = [self indexPathForItem:detailItem];
    if(!indexPath){
        return;
    }
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (NSIndexPath *)indexPathForItem:(id)item{
    return nil;
}

//- (void)showDetailTargetDidChange:(NSNotification *)notification{
//    // update cell accessories.
//    if([self respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]){
//        for (UITableViewCell *cell in self.tableView.visibleCells) {
//            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//            [self tableView:self.tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
//        }
//    }
//    [self updateTableSelectionForCurrentSelectedDetailItem];
//}

#pragma mark - Primary Table View Controller

//- (void)tableViewDidEndEditing{
- (void)tableViewControllerDidEndEditing:(MUITableViewController *)tableViewController{
    [self updateTableSelectionForCurrentSelectedDetailItem];
}

#pragma mark - View Controller

//- (void)viewDidLoad{
//    [super viewDidLoad];
//    
    // was nil when UI restoration changed to use isMovingToParentViewController below
//    if(!self.splitViewController.isCollapsed){
//        id i = self.splitViewController.viewControllers.lastObject.childViewControllers.firstObject;
//        self.masterDetailContext = i;
//    }
//}

//- (void)viewWillAppear:(BOOL)animated{
    // only do this for the first appear
//    if(self.isMovingToParentViewController){
//        // only when in split view
//        if(!self.splitViewController.isCollapsed){
//            UIViewController *vc = self.splitViewController.mui_secondaryNavigationController.viewControllers.firstObject;
//            if([vc conformsToProtocol:@protocol(MUISecondaryViewController)]){
//                self.masterDetailContext = (UIViewController<MUISecondaryViewController> *)vc;
//            }
//        }
//    }

//    self.clearsSelectionOnViewWillAppear = self.mui_collapseControllerForMaster.splitViewController.isCollapsed;
//    [super viewWillAppear:animated];
//
//    for (NSIndexPath *indexPath in self.tableView.indexPathsForSelectedRows) {
//        BOOL indexPathPushes = [self mui_willShowingDetailViewControllerPushWithSender:self];
//        if (indexPathPushes) {
//            // If we're pushing for this indexPath, deselect it when we appear
//            [self.tableView deselectRowAtIndexPath:indexPath animated:animated];
//        }
//    }
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showDetailTargetDidChange:) name:UIViewControllerShowDetailTargetDidChangeNotification object:self.mui_collapseControllerForMaster.splitViewController];
    
//    [self updateTableSelectionForCurrentSelectedDetailItem];
//}

//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    // prevent doing unnecessary things while not visible
//    [NSNotificationCenter.defaultCenter removeObserver:self name:UIViewControllerShowDetailTargetDidChangeNotification object:self.splitViewController];
//}

// we don't perform table cell segues when editing but we allow other segues like from bar button items.
//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//    if([sender isKindOfClass:UITableViewCell.class] && self.isEditing){
//        return NO;
//    }
//    return YES;
//}

@end
