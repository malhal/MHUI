//
//  SelectionManager.m
//  CloudEvents
//
//  Created by Malcolm Hall on 10/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MUIFetchedSelectionManager.h"
#import <objc/runtime.h>
#import "MUIObjectDataSource_Internal.h"
#import "MUITableView.h"
#import "MUITableViewController.h"
#import "MUIFetchedDataSource.h"
#import "MUISelectionManager_Internal.h"

@interface MUIFetchedSelectionManager()

@property (strong, nonatomic) NSArray *objects;

@end

@implementation MUIFetchedSelectionManager

//- (instancetype)initWithFetchedDataSource:(FetchedDataSource *)fetchedDataSource{
- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    self.objects = controller.fetchedObjects;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    NSManagedObject *detailItem = self.selectedObject;
    if(detailItem && ![controller.fetchedObjects containsObject:detailItem]){
        NSManagedObject *object;
        NSArray *fetchedObjects = controller.fetchedObjects;
        if(fetchedObjects.count > 0){
            NSUInteger i = [self.objects indexOfObject:detailItem];
            if(i >= fetchedObjects.count){
                i = fetchedObjects.count - 1;
            }
            object = fetchedObjects[i];
        }
        [self selectObject:object notifyDelegate:YES];
    }
}

@end
