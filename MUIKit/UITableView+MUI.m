//
//  UITableView+MUI.m
//  MUIKit
//
//  Created by Malcolm Hall on 19/01/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "UITableView+MUI.h"

@implementation UITableView (MUI)

- (NSIndexPath *)mui_indexPathNearIndexPath:(NSIndexPath *)indexPath{
    // NSAssert(!self.tableView.isEditing, @"Cannot select while editing");
    NSUInteger count = [self numberOfRowsInSection:indexPath.section] ;//self.fetchedResultsController.fetchedObjects.count;
    //id item;
    NSIndexPath *newIndexPath;
    if(count){
        NSUInteger row = count - 1;
        if(indexPath.row < row){
            row = indexPath.row;
        }
        newIndexPath = [NSIndexPath indexPathForRow:row inSection:indexPath.section];
    }
    return newIndexPath;
}

@end
