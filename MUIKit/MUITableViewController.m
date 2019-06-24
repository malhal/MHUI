//
//  MUITableViewController.m
//  MUIKit
//
//  Created by Malcolm Hall on 05/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUITableViewController.h"
#import "MUIDataSource_Internal.h"
#import "MUITableView.h"
#import "UIViewController+MUIDetail.h"
#import "UITableView+MUI.h"

@interface MUITableViewController ()

@property (strong, nonatomic, readwrite) id selectedObject;

@end

@implementation MUITableViewController

- (void)awakeFromNib{
    [super awakeFromNib];
    self.showsDetail = YES;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //    if([self.tableViewDelegate respondsToSelector:@selector(tableViewControllerViewDidLoad:)]){
    //        [self.tableViewDelegate tableViewControllerViewDidLoad:self];
    //    }
    [self configureTableViewDataSource];
    [self configureTableViewDelegate];
}

// has to be in will so that when in landscape on root and swipe to delete the venue it causes a detail to show.
- (void)willMoveToParentViewController:(nullable UIViewController *)parent{
    [super willMoveToParentViewController:parent];
    if(!parent){
        return;
    }
    NSLog(@"");
    
    if(!self.shouldAlwaysHaveSelectedObject){
        return;
    }
    id object = self.selectedObject;
    NSIndexPath *ip = [self.dynamicDataSource indexPathForObject:object];
    if(!ip){
        object = self.dynamicDataSource.objects.firstObject;
        [self selectObject:object notifyDelegate:YES];
    }
}

// called after viewWillAppear
- (void)didMoveToParentViewController:(UIViewController *)parent{
    [super didMoveToParentViewController:parent];
    if(!parent){
        return;
    }
    NSLog(@"");


}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.isMovingToParentViewController){
        [self reselectTableRowIfNecessary];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(showDetailTargetDidChange:) name:UIViewControllerShowDetailTargetDidChangeNotification object:nil];
    
    // runs all the changes since the fetch controller was cached.
    //[self.managedObjectContext processPendingChanges];
  //  return;
    

}

// for view did appear and fetch controller selecting next in list.
// when root is in stack but viewig master then we should have selected object.
// but if on root then don't need because don't want to push on master.
- (BOOL)shouldAlwaysHaveSelectedObject{
    if(self.splitViewController.isCollapsed){
        if(self.navigationController.topViewController == self){
            if(self.showsDetail){
                return YES;
            }
            return NO;
        }
        else{
            return YES;
        }
    }else{
        if(self.navigationController.topViewController == self){
            if(self.showsDetail){
                return YES;
            }
            return NO;
        }
        else{
            return YES;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIViewControllerShowDetailTargetDidChangeNotification object:nil];
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDataSource), aSelector)){
        if([self.dynamicDataSource respondsToSelector:aSelector]){
            return self.dynamicDataSource;
        }
    }
    else if(MHFProtocolHasInstanceMethod(@protocol(MUITableViewDelegate), aSelector)){
        if([self.tableViewDelegate respondsToSelector:aSelector]){
            return self.tableViewDelegate;
        }
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    if([super respondsToSelector:aSelector]){
        return YES;
    }
    else if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDataSource), aSelector)){
        return [self.dynamicDataSource respondsToSelector:aSelector];
    }
    else if(MHFProtocolHasInstanceMethod(@protocol(MUITableViewDelegate), aSelector)){
        return [self.tableViewDelegate respondsToSelector:aSelector];
    }
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dynamicDataSource numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dynamicDataSource tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dynamicDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)setDynamicDataSource:(MUIDataSource *)dynamicDataSource{
    if(dynamicDataSource == _dynamicDataSource){
        return;
    }
    // if _dataSource _dataSource.delegate = nil;
    _dynamicDataSource = dynamicDataSource;
    dynamicDataSource.tableViewController = self;
    dynamicDataSource.delegate = self;
    if(self.isViewLoaded){
        [self configureTableViewDataSource];
    }
    
}

- (void)configureTableViewDataSource{
    if(self.dynamicDataSource){
        if(self.tableView.dataSource){
            self.tableView.dataSource = nil;
        }
        self.tableView.dataSource = self;
    }
}

- (void)setTableViewDelegate:(id<MUITableViewDelegate>)tableViewDelegate{
    if(tableViewDelegate == _tableViewDelegate){
        return;
    }
    _tableViewDelegate = tableViewDelegate;
    if(self.isViewLoaded){
        [self configureTableViewDelegate];
    }
}

- (void)configureTableViewDelegate{
    if(self.tableViewDelegate){
        if(self.tableView.delegate){
            self.tableView.delegate = nil;
        }
        self.tableView.delegate = self;
    }
}

//- (UITableViewCell *)fetchedDataSource:(MUIFetchedDataSource *)fetchedDataSource configureCell:(nullable UITableViewCell *)cell withObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath{
//    return nil;
//}

/*
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    //self.selectedRowBeforeEditing = editing ? self.tableView.indexPathForSelectedRow : nil;
    if(!editing && animated){
        // because otherwise the checkmark gets selected when sliding back.
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            //[self.masterSupport updateSelectionForCurrentSelectedMasterItem];
            [self tableViewControllerDidEndEditing];
        }];
    }
    [super setEditing:editing animated:animated];
    if(!editing){
        if(animated){
            [CATransaction commit];
        }
        else{
            //[self.masterSupport updateSelectionForCurrentSelectedMasterItem]; // test if needs a perform after delay.
            [self tableViewControllerDidEndEditing];
        }
    }
}
*/

//- (void)tableViewControllerDidEndEditing{
//    if([self.tableViewDelegate respondsToSelector:@selector(tableViewControllerDidEndEditing:)]){
//        [self.tableViewDelegate tableViewControllerDidEndEditing:self];
//    }
//}

//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
//    self.editButtonItem.enabled = NO;
//}
//
//-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
//    self.editButtonItem.enabled = YES;
//    [self performSelector:@selector(tableViewControllerDidEndEditing) withObject:nil afterDelay:0];
//}


- (void)objectDataSource:(MUIDataSource *)dataSource configureCell:(nullable UITableViewCell *)cell withObject:(id)object{
    
}

- (void)selectObject:(id)object{
    [self selectObject:object notifyDelegate:NO];
}

- (void)selectObject:(id)object notifyDelegate:(BOOL)notifyDelegate{
    self.selectedObject = object;
    if(notifyDelegate){
        [self didSelectObject:object];
    }
    if(self.isViewLoaded){
        [self reselectTableRowIfNecessaryScrollToSelection:YES];
    }
}

- (void)didSelectObject:(id)object{
//    if([self.delegate respondsToSelector:@selector(selectionManager:didSelectObject:)]){
//        [self.delegate selectionManager:self didSelectObject:object];
//    }
}

- (void)tableViewDidEndEditing:(MUITableView *)tableView{
    [self reselectTableRowIfNecessary];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!tableView.isEditing){
        self.selectedObject = [self.dynamicDataSource objectAtIndexPath:indexPath];
    }
    return indexPath;
}

- (void)reselectTableRowIfNecessary{
    [self reselectTableRowIfNecessaryScrollToSelection:NO];
}

- (void)reselectTableRowIfNecessaryScrollToSelection:(BOOL)scrollToSelection{
    if(!self.shouldAlwaysHaveSelectedRow){
        return;
    }
    id object = self.selectedObject;
    if(!object){
        return;
    }
    //    if(![self.tableView.dataSource conformsToProtocol:@protocol(MalcsProtocol)]){
    //        return;
    //    }
    //    id<MalcsProtocol> x = (id<MalcsProtocol>)self.tableView.dataSource;
    //   NSIndexPath *indexPath = [x indexPathForObject:object];
    NSIndexPath *indexPath = [self.dynamicDataSource indexPathForObject:object];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:scrollToSelection ? UITableViewScrollPositionMiddle : UITableViewScrollPositionNone];
}

- (BOOL)shouldAlwaysHaveSelectedRow{
    if(!self.shouldAlwaysHaveSelectedRowWhenNotInEditMode){
        return NO;
    }
    else if(self.tableView.isEditing){
        return NO;
    }
    return YES;
}

- (BOOL)shouldAlwaysHaveSelectedRowWhenNotInEditMode{
    //return !self.splitViewController.isCollapsed;// || [self.navigationController.topViewController isKindOfClass:UINavigationController.class];
    
    if(self.splitViewController.isCollapsed){
        if(self.navigationController.topViewController == self){
            return NO;
        }
        else{
            return YES;
        }
    }else{
        if(self.navigationController.topViewController == self){
            if(self.showsDetail){
                return YES;
            }
            return NO;
        }
        else{
            return YES;
        }
    }
}

- (void)objectDataSource:(MUIDataSource *)objectDataSource didDeleteObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    if(object != self.selectedObject){
        return;
    }
    NSIndexPath *ip = [self.tableView mui_indexPathNearDeletedIndexPath:indexPath];
    id o = [self.dynamicDataSource objectAtIndexPath:ip];
    [self selectObject:o notifyDelegate:YES];
}

- (void)showDetailTargetDidChange:(NSNotification *)notification{
    //    // update cell accessories.
    //    if([self respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]){
    //        for (UITableViewCell *cell in self.tableView.visibleCells) {
    //            NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    //            [self tableView:self.tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    //        }
    //    }
    UISplitViewController *svc = (UISplitViewController *)notification.object;
    if(!svc.isCollapsed){
        [self reselectTableRowIfNecessary];
    }
}

- (UIViewController *)targetViewControllerForAction:(SEL)action sender:(id)sender{
    if(action == @selector(showDetailViewController:sender:)){
        if([self.delegate respondsToSelector:@selector(showDetailTargetForTableViewController:)]){
            
            BOOL a = self.splitViewController.isCollapsed;
            BOOL b = self.navigationController.topViewController == self;
            // no yes master landscape
            // yes yes portrait master swipe to delete prev selected.
            
//            if(a && b){
//                if([sender isKindOfClass:UIView.class]){
//                    
//                    UINavigationController *nv = self.detailNavigationController;
//                    return nv;
//                    
//                    return self;
//                    
//                }
//            }
            
            return [self.delegate showDetailTargetForTableViewController:self];
        }
    }
    return [super targetViewControllerForAction:action sender:sender];
}

//- (void)showDetailViewController:(UIViewController *)vc sender:(id)sender{
//    NSLog(@"");
//}

@end
