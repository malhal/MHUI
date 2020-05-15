//
//  TableDataSource.m
//  ScrollPosition
//
//  Created by Malcolm Hall on 09/04/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "MUIFetchedTableDataSource.h"

@implementation MUIFetchedTableDataSource

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)controller
{
    self = [super init];
    if (self) {
        _fetchedResultsController = controller;
        //_cellIdentifiersByClassName = @{NSStringFromClass(NSObject.class) : @"Cell"};
    }
    return self;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //NSString *cellIdentifier = self.cellIdentifiersByClassName[object.className];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [self cellForObject:object atIndexPath:indexPath inTableView:tableView];
    [self configureCell:cell withObject:object inTableView:tableView];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = self.fetchedResultsController.managedObjectContext;
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
            
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
}

- (UITableViewCell *)cellForObject:(id)object atIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView{
    return nil;
}

- (void)configureCell:(UITableViewCell *)cell withObject:(id)object inTableView:(UITableView *)tableView{
    
}

@end
