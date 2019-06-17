//
//  MUIObjectDataSource.m
//  MUIKit
//
//  Created by Malcolm Hall on 17/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MUIObjectDataSource_Internal.h"
#import "MUISelectionManager_Internal.h"
#import "MUITableViewController.h"

@implementation MUIObjectDataSource

- (void)configureCell:(UITableViewCell *)cell withObject:(id)object{
    if([self.delegate respondsToSelector:@selector(objectDataSource:configureCell:withObject:)]){
        [self.delegate objectDataSource:self configureCell:cell withObject:object];
    }
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (NSIndexPath *)indexPathForObject:(id)object{
    return nil;
}

- (void)setSelectionManager:(MUISelectionManager *)selectionManager{
    if(selectionManager == _selectionManager){
        return;
    }
    _selectionManager = selectionManager;
    selectionManager.objectDataSource = self;
//    selectionManager.delegate = self;
    //self.tableViewController.tableViewDelegate = selectionManager;
}

- (void)setTableViewController:(MUITableViewController *)tableViewController{
    if(tableViewController == _tableViewController){
        return;
    }
    _tableViewController = tableViewController;
    tableViewController.tableViewDelegate = self.selectionManager;
}

@end
