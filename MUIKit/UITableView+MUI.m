//
//  UITableView+MUI.m
//  MUIKit
//
//  Created by Malcolm Hall on 19/01/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "UITableView+MUI.h"

@implementation UITableView (MUI)

- (NSArray *)mui_indexPaths{
    NSMutableArray *indexPaths = NSMutableArray.array;
    for(NSUInteger section=0; section < self.numberOfSections; section++){
        for(NSUInteger row=0; row < [self numberOfRowsInSection:section]; row++){
            [indexPaths addObject:[NSIndexPath indexPathForRow:row inSection:section]];
        }
    }
    return indexPaths;
}

- (NSIndexPath *)mui_indexPathNearDeletedIndexPath:(NSIndexPath *)indexPath{
    // NSAssert(!self.tableView.isEditing, @"Cannot select while editing");
    NSArray *indexPaths = self.mui_indexPaths;
    NSUInteger count = indexPaths.count;// [self numberOfRowsInSection:indexPath.section] ;//self.fetchedResultsController.fetchedObjects.count;
    //id item;
    if([indexPaths containsObject:indexPath]){
        return indexPath;
    }
    return indexPaths.lastObject;
//    NSIndexPath *newIndexPath;
//    if(count){
//        NSUInteger row = count - 1;
//        if(indexPath.row < row){
//            row = indexPath.row;
//        }
//        newIndexPath = [NSIndexPath indexPathForRow:row inSection:indexPath.section];
//    }
//    return newIndexPath;
}

- (NSArray<NSIndexPath *> *)mui_indexPathsForSafeAreaRows{
    return [self indexPathsForRowsInRect:self.safeAreaLayoutGuide.layoutFrame];
}

@end
