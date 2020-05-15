//
//  MUIMasterTableViewController.m
//  MUIKit
//
//  Created by Malcolm Hall on 04/03/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "MUIMasterTableViewController.h"
#import "UINavigationController+MUI.h"
#import "UIViewController+MUI.h"

@interface MUIMasterTableViewController ()

@end

@implementation MUIMasterTableViewController

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    if(!editing){
        // did end editing
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
           [self didEndEditing];
        }];
    }
    [super setEditing:editing animated:animated];
    if(!editing){
        [CATransaction commit];
    }
}

- (void)didEndEditing{
    [self configureTableViewForDetailNavigationController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    
    //self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    
//    if(self.splitViewController.viewControllers.count == 2){
//        [self setDetailNavigationController:self.splitViewController.viewControllers.lastObject configureView:NO];
//    }
    
    self.detailNavigationController.delegate = self;
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(showDetailTargetDidChange:) name:UIViewControllerShowDetailTargetDidChangeNotification object:nil];
   // [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(navigationControllerWillShowViewController:) name:MUINavigationControllerWillShowViewControllerNotification object:nil];

    
    if((!self.splitViewController.isCollapsed && self.isMovingToParentViewController) ||
       (self.splitViewController.isCollapsed && !self.isMovingToParentViewController)){
        [self configureTableViewForDetailNavigationController];
    }
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(!self.splitViewController.isCollapsed && !self.isMovingToParentViewController){
        [self configureTableViewForDetailNavigationController];
    }
}

- (void)setDetailNavigationController:(UINavigationController *)detailNavigationController{
    [self setDetailNavigationController:detailNavigationController configureView:YES];
}

- (void)setDetailNavigationController:(UINavigationController *)detailNavigationController configureView:(BOOL)configureView{
    if(detailNavigationController == _detailNavigationController){
        return;
    }
    else if(_detailNavigationController.delegate == self){
        _detailNavigationController.delegate = nil;
        detailNavigationController.delegate = self;
    }
    _detailNavigationController = detailNavigationController;
    if(configureView){
        [self configureTableViewForDetailNavigationController];
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    

//- (void)navigationControllerWillShowViewController:(NSNotification *)notification{
   // NSLog(@"%@", notification);
   // NSLog(@"%@", self.detailNavigationController);
    //NSLog(@"%@", self.detailNavigationController.viewControllers.firstObject);
   // UINavigationController *navigationController = (UINavigationController *)notification.object;
  //  self.detailViewController = navigationController.viewControllers.firstObject;
//    if(navigationController != self.currentDetailNavigationController){
//        return;
//    }
//    UIViewController *last = notification.userInfo[MUINavigationControllerLastVisibleViewController];
//    if(!last){
//        return;
//    }
    //if(last == self.detailViewController){
//        if(next != )
     //   UIViewController *next = notification.userInfo[MUINavigationControllerNextVisibleViewController];
//self.detailViewController = next;
    
    [self configureTableViewForDetailNavigationController];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[self.selection removeObserver:self forKeyPath:NSStringFromSelector(@selector(selectedObjectForViewController))];
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIViewControllerShowDetailTargetDidChangeNotification object:nil];
    //[NSNotificationCenter.defaultCenter removeObserver:self name:MUINavigationControllerWillShowViewControllerNotification object:nil];
    self.detailNavigationController.delegate = nil;
}

- (void)currentDetailModelIdentifierDidChangeNotification:(NSNotification *)notification{
    // we can receive all notifications and then check here
    if(notification.object != self.splitViewController){
        return;
    }
    
//    if(!self.changeIsUserDriven){
//        [self performSegueWithIdentifier:@"showDetail" sender:self];
//    }
    //if(!self.isEditing && !self.splitViewController.isCollapsed){
        [self configureTableViewForDetailNavigationController];
    //}
}


//- (void)setDetailViewController:(UIViewController *)detailViewController{
//    if(detailViewController == _detailViewController){
//        return;
//    }
//    else if(_detailViewController){
//        [NSNotificationCenter.defaultCenter removeObserver:self name:MUINavigationControllerWillShowViewControllerNotification object:nil];
//    }
//    _detailViewController = detailViewController;
//    [self configureTableViewForDetailNavigationController];
//    NSLog(@"%@", detailViewController.navigationController);
//    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(navigationControllerWillShowViewController:) name:MUINavigationControllerDidShowViewControllerNotification object:detailViewController.navigationController];
//
//}


- (void)showDetailTargetDidChange:(NSNotification *)notification{
   // self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [self configureTableViewForDetailNavigationController];
    for (UITableViewCell *cell in self.tableView.visibleCells) {
        //NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        //[self tableView:self.tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
      //  [self configureCell:cell];
    }
}

- (NSObject *)detailItemInDetailNavigationController:(UINavigationController *)nav{
    return nil;
}

// for currentDetailItem

// problem when exiting editing because we call configure view it is also scrolling
- (void)configureTableViewForDetailNavigationController{
//    BOOL editButtonItemEnabled = NO;
    UINavigationController *detailNav = self.detailNavigationController;//[self currentDetailNavigationController];
    
    //if(detailNav.mui_isViewVisible){
        NSObject *detailItem = [self detailItemInDetailNavigationController:detailNav];//self.selection.selectedObjectForViewController;
     //   if([self.fetchedObjects containsObject:detailItem]){
    //        editButtonItemEnabled = YES;
    //    }
    //    self.editButtonItem.enabled = editButtonItemEnabled;
//            if(self.tableView.isEditing){
//                return;
//            }
    //        else
//            if(self.clearsSelectionOnViewWillAppear){
//                return;
//            }
//            NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:detailItem];
//            if(!indexPath){
//                return;
//            }
//            NSArray *indexPathsForSelectedRows = self.tableView.indexPathsForSelectedRows;
//            if(indexPathsForSelectedRows && [self.tableView.indexPathsForSelectedRows containsObject:indexPath]){
//                return;
//            }
//            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
         //   [self selectObject:detailItem];
            
      //  }
   // }

    //    BOOL trashButtonEnabled = NO;
    //    Event *currentDetailItem = self.currentDetailItem;
    //    if(currentDetailItem){
    //        // enable if the current is in our list.
    //        if([self.fetchedResultsController.fetchedObjects containsObject:currentDetailItem]){
    //            trashButtonEnabled = YES;

    //        }
    //    }
    //    self.trashButton.enabled = trashButtonEnabled;
        //if(selectRow){
        //if(!self.editing){// && !self.splitViewController.isCollapsed){
            //if(!self.splitViewController.isCollapsed || !self.view.window){
    //    NSString *splitItem = self.currentDetailModelIdentifier;
    //    if(splitItem){
    //        if(!self.isEditing){
    //                //if(!svc.isCollapsed){
    //            //NSIndexPath *indexPath = [self.childTableViewController.fetchedResultsController indexPathForObject:splitItem];
    //            if([self.tableView.dataSource conformsToProtocol:@protocol(UIDataSourceModelAssociation)]){
    //                id<UIDataSourceModelAssociation> dataSource = (id<UIDataSourceModelAssociation>)self.tableView.dataSource;
    //                NSIndexPath *indexPath = [dataSource indexPathForElementWithModelIdentifier:splitItem inView:self.tableView];
                    //NSArray *rows = self.tableView.indexPathsForVisibleRows;
        //CGRect safeArea = UIEdgeInsetsInsetRect(self.tableView.bounds, self.tableView.safeAreaInsets);
        
          //  NSArray *rows = self.tableView.mui_indexPathsForSafeAreaRows;
        
//            UITableViewScrollPosition sp = UITableViewScrollPositionNone;
//            if([rows.firstObject compare:indexPath] != NSOrderedAscending){
//                sp = UITableViewScrollPositionTop;
//            }
//            else if([rows.lastObject compare:indexPath] != NSOrderedDescending){
//                sp = UITableViewScrollPositionBottom;
//            }
//            [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:sp];
        
        
     //   [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    //            }
    //            //[self.tableView scrollToNearestSelectedRowAtScrollPosition:sp animated:YES];
    //        }
    //    }
}

// we can't search because when popping it doesnt find it.
//- (UINavigationController *)currentDetailNavigationController{
//    
//    UINavigationController *detailNavigationController;
//    UISplitViewController *splitViewController = self.splitViewController;
//    if(splitViewController.viewControllers.count == 2){
//        UIViewController * vc = splitViewController.viewControllers.lastObject;
//        if([vc isKindOfClass:UINavigationController.class]){
//            detailNavigationController = (UINavigationController *)vc;
//        }
//    }
//    // find it in the master nav stack
//    else if(splitViewController.viewControllers.count == 1){
//        for(UIViewController *vc in self.navigationController.viewControllers.reverseObjectEnumerator){
//            if([vc isKindOfClass:UINavigationController.class]){
//                detailNavigationController = (UINavigationController *)vc;
//            }
//        }
//    }
//    return detailNavigationController;
//}

#pragma mark - Table view data source



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation UIViewController (MUIMasterViewController)

- (NSObject *)mui_currentDetailViewControllerWithSender:(id)sender{
    UIViewController *target = [self targetViewControllerForAction:@selector(mui_currentDetailViewControllerWithSender:) sender:sender];
    if(target){
        return [target mui_currentDetailViewControllerWithSender:sender];
    }else{
        return nil;
    }
}

@end
