//
//  MUITableViewController.m
//  MUIKit
//
//  Created by Malcolm Hall on 05/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUITableViewController.h"

@interface MUITableViewController ()

@end

@implementation MUITableViewController

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    //self.selectedRowBeforeEditing = editing ? self.tableView.indexPathForSelectedRow : nil;
    if(!editing && animated){
        // because otherwise the checkmark gets selected when sliding back.
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            //[self.masterSupport updateSelectionForCurrentSelectedMasterItem];
            [self tableViewDidEndEditing];
        }];
    }
    [super setEditing:editing animated:animated];
    if(!editing){
        if(animated){
            [CATransaction commit];
        }
        else{
            //[self.masterSupport updateSelectionForCurrentSelectedMasterItem]; // test if needs a perform after delay.
            [self tableViewDidEndEditing];
        }
    }
}

- (void)tableViewDidEndEditing{
    // to be overridden
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.editButtonItem.enabled = NO;
}

-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.editButtonItem.enabled = YES;
    [self performSelector:@selector(tableViewDidEndEditing) withObject:nil afterDelay:0];
}

@end
