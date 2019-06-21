//
//  MUITableViewController.m
//  MUIKit
//
//  Created by Malcolm Hall on 05/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUITableViewController.h"
#import "MUIObjectDataSource_Internal.h"
#import "MUITableView.h"
#import "UIViewController+MUIDetail.h"

@interface MUITableViewController ()

@property (strong, nonatomic, readwrite) id selectedObject;

@end

@implementation MUITableViewController

- (void)awakeFromNib{
    [super awakeFromNib];
    self.isMasterViewController = YES;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //    if([self.tableViewDelegate respondsToSelector:@selector(tableViewControllerViewDidLoad:)]){
    //        [self.tableViewDelegate tableViewControllerViewDidLoad:self];
    //    }
    
}

- (void)didMoveToParentViewController:(UIViewController *)parent{
    [super didMoveToParentViewController:parent];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reselectTableRowIfNecessary];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(showDetailTargetDidChange:) name:UIViewControllerShowDetailTargetDidChangeNotification object:nil];
    
    // runs all the changes since the fetch controller was cached.
    //[self.managedObjectContext processPendingChanges];
    
    //NSString *mi = self.modelIdentifierForSelectedElement;
    //NSIndexPath *ipp = self.tableView.indexPathForSelectedRow;
    //NSIndexPath *ip = [self indexPathForElementWithModelIdentifier:mi inView:self.tableView];
    
    // we need this to only select an object
    if(!self.isMasterViewController){
        return;
    }
    
    
    id object = self.selectedObject;
    NSIndexPath *ip = [self.dataSource indexPathForObject:object];
    if(!ip){
        object = self.dataSource.objects.firstObject;
        [self selectObject:object notifyDelegate:YES];
    }
}

- (BOOL)shouldSelectObject{
    
    if(self.splitViewController.isCollapsed){
        if(self.navigationController.topViewController == self){
            return NO;
        }
        else{
            return YES;
        }
    }else{
        if(self.navigationController.topViewController == self){
            
            if(self.isMasterViewController){
                return YES;
            }
            
            return NO;
        }
        else{
            return YES;
        }
    }
    
    // if we are top of the stack

    
}



- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIViewControllerShowDetailTargetDidChangeNotification object:nil];
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDataSource), aSelector)){
        if([self.dataSource respondsToSelector:aSelector]){
            return self.dataSource;
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
        return [self.dataSource respondsToSelector:aSelector];
    }
    else if(MHFProtocolHasInstanceMethod(@protocol(MUITableViewDelegate), aSelector)){
        return [self.tableViewDelegate respondsToSelector:aSelector];
    }
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)setDataSource:(MUIObjectDataSource *)dataSource{
    if(dataSource == _dataSource){
        return;
    }
    else if(self.tableView.dataSource){
        self.tableView.dataSource = nil;
    }
    // if _dataSource _dataSource.delegate = nil;
    _dataSource = dataSource;
    dataSource.tableViewController = self;
    dataSource.delegate = self;
    self.tableView.dataSource = self;
}

- (void)setTableViewDelegate:(id<MUITableViewDelegate>)tableViewDelegate{
    if(tableViewDelegate == _tableViewDelegate){
        return;
    }
    else if(self.tableView.delegate){
        self.tableView.delegate = nil;
    }
    _tableViewDelegate = tableViewDelegate;
    self.tableView.delegate = self;
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


- (void)objectDataSource:(MUIObjectDataSource *)dataSource configureCell:(nullable UITableViewCell *)cell withObject:(id)object{
    
}

- (void)selectObject:(id)object{
    [self selectObject:object notifyDelegate:NO];
}

- (void)selectObject:(id)object notifyDelegate:(BOOL)notifyDelegate{
    self.selectedObject = object;
    if(notifyDelegate){
        [self didSelectObject:object];
    }
    [self reselectTableRowIfNecessaryScrollToSelection:YES];
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
        self.selectedObject = [self.dataSource objectAtIndexPath:indexPath];
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
    NSIndexPath *indexPath = [self.dataSource indexPathForObject:object];
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
    return !self.splitViewController.isCollapsed;// || [self.navigationController.topViewController isKindOfClass:UINavigationController.class];
}

//- (void)selectionManager:(MUISelectionManager *)selectionManager didSelectObject:(id)object{
//    if([self.delegate respondsToSelector:@selector(selectionManager:didSelectObject:)]){
//        [self.delegate selectionManager:selectionManager didSelectObject:object];
//    }
//}



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
            return [self.delegate showDetailTargetForTableViewController:self];
        }
    }
    return [super targetViewControllerForAction:action sender:sender];
}

@end
