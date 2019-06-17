//
//  MUISelectionManager.m
//  MUIKit
//
//  Created by Malcolm Hall on 17/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MUISelectionManager_Internal.h"
#import "MUIObjectDataSource_Internal.h"
#import <MUIKit/MUITableViewController.h>

@interface MUISelectionManager()

@property (strong, nonatomic, readwrite) id selectedObject;

@end

@implementation MUISelectionManager

- (void)selectObject:(id)object{
    [self selectObject:object notifyDelegate:NO];
}

- (void)selectObject:(id)object notifyDelegate:(BOOL)notifyDelegate{
    self.selectedObject = object;
    //self.fetchControllerSelectedIndexPath = indexPath;
    //[self performSegueWithIdentifier:@"showDetail" sender:self];
    if(notifyDelegate){
        [self didSelectObject:object];
    }
    [self reselectTableRowIfNecessaryScrollToSelection:YES];
}

- (void)didSelectObject:(id)object{
    if([self.delegate respondsToSelector:@selector(selectionManager:didSelectObject:)]){
        [self.delegate selectionManager:self didSelectObject:object];
    }
}

- (void)tableViewDidEndEditing:(MUITableView *)tableView{
    [self reselectTableRowIfNecessary];
}

//- (NSFetchedResultsController *)fetchedResultsController{
//    return self.fetchedDataSource.fetchedResultsController;
//}

//- (UITableView *)tableView{
//    return self.fetchedDataSource.tableViewController.tableView;
//}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"willSelectRowAtIndexPath");
    if(!tableView.isEditing){
        self.selectedObject = [self.objectDataSource objectAtIndexPath:indexPath];
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
    id object = self.selectedObject;//self.shownViewController.object;
    if(!object){
        return;
    }
    //    if(![self.tableView.dataSource conformsToProtocol:@protocol(MalcsProtocol)]){
    //        return;
    //    }
    //    id<MalcsProtocol> x = (id<MalcsProtocol>)self.tableView.dataSource;
    //   NSIndexPath *indexPath = [x indexPathForObject:object];
    NSIndexPath *indexPath = [self.objectDataSource indexPathForObject:object];
    [self.objectDataSource.tableViewController.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:scrollToSelection ? UITableViewScrollPositionMiddle : UITableViewScrollPositionNone];
}

- (BOOL)shouldAlwaysHaveSelectedRow{
    if(!self.shouldAlwaysHaveSelectedRowWhenNotInEditMode){
        return NO;
    }
    else if(self.objectDataSource.tableViewController.tableView.isEditing){
        return NO;
    }
    return YES;
}

- (BOOL)shouldAlwaysHaveSelectedRowWhenNotInEditMode{
    return !self.objectDataSource.tableViewController.splitViewController.isCollapsed;// || [self.navigationController.topViewController isKindOfClass:UINavigationController.class];
}

@end
