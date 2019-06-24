//
//  FetchedDataSource.m
//  CloudEvents
//
//  Created by Malcolm Hall on 05/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MUIFetchedDataSource.h"
//#import "NSManagedObjectContext+MCD.h"
//#import <objc/runtime.h>
#import "MUITableViewController.h"
#import "UIViewController+MUIDetail.h"
#import "MUIDataSource_Internal.h"

@interface MUIFetchedDataSource()

@property (strong, nonatomic, readwrite) NSFetchedResultsController *fetchedResultsController;
@property (assign, nonatomic) BOOL sectionsCountChanged;
//@property (strong, nonatomic) NSArray *fetchedObjectsBeforeChange;
@property (assign, nonatomic) id deletedObject;
@property (assign, nonatomic) NSIndexPath *deletedObjectIndexPath;

@end

@implementation MUIFetchedDataSource

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController{
    self = [super init];//[super initWithTableViewController:tableViewController];
    if (self) {
        _fetchedResultsController = fetchedResultsController;
        //[fetchedResultsController mcd_setDelegateNotifyingParent:self];
        _fetchedResultsController.delegate = self;
    }
    return self;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath{
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (NSIndexPath *)indexPathForObject:(NSManagedObject *)object{
    return [self.fetchedResultsController indexPathForObject:object];
}

- (NSArray *)objects{
    return self.fetchedResultsController.fetchedObjects;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

//- (nullable NSString *)modelIdentifierForObject:(NSManagedObject *)object{
//    return object.objectID.URIRepresentation.absoluteString;
//}

// on encode it asks for first and selected. On restore it asks for first so maybe checks ID. idx can be nil. called on decode too but with nil.
//- (nullable NSString *)modelIdentifierForElementAtIndexPath:(NSIndexPath *)idx inView:(UIView *)view{
//    NSManagedObject *object = [self objectAtIndexPath:idx];
//    NSString *identifier = object.objectID.URIRepresentation.absoluteString;
//    return identifier;
//}
//
// called on decode
//- (nullable NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view{
//    if(!identifier){
//        return nil;
//    }
//    NSURL *objectURI = [NSURL URLWithString:identifier];
//    NSManagedObject *object = [self.fetchedResultsController.managedObjectContext mcd_objectWithURI:objectURI];
//    NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:object];
//    return indexPath;
//}

- (UITableView *)tableView{
    return self.tableViewController.tableView;
}

#pragma mark - Fetched results controller

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
//    if([self.fetchedSelectionManager respondsToSelector:@selector(controllerWillChangeContent:)]){
//        [self.fetchedSelectionManager controllerWillChangeContent:controller];
//    }
  //  self.fetchedObjectsBeforeChange = controller.fetchedObjects;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            self.sectionsCountChanged = YES;
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            self.sectionsCountChanged = YES;
            break;
            
        default:
            return;
    }
//    if([self.fetchedSelectionManager respondsToSelector:@selector(controller:didChangeSection:atIndex:forChangeType:)]){
//        [self.fetchedSelectionManager controller:controller didChangeSection:sectionInfo atIndex:sectionIndex forChangeType:type];
//    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            NSLog(@"Insert %@", [(NSManagedObject *)anObject objectID]);
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            if(anObject == self.tableViewController.selectedObject){
                self.deletedObject = anObject;
                self.deletedObjectIndexPath = indexPath;
            }
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withObject:anObject];
            //[tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            //[self.delegate tableFetch:self configureCell:[tableView cellForRowAtIndexPath:indexPath]];
            break;
            
        case NSFetchedResultsChangeMove:
            // Can't use the tableView move method becasue its animation does not play with section inserts/deletes.
            // Also if we used move would need to update the cell manually which might use the wrong index.
            // Even if old and new indices are the same we still need to call the methods.
            if(!self.sectionsCountChanged && indexPath.section == newIndexPath.section){
                [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withObject:anObject];
                [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            }
            else{
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            
            break;
    }
//    if([self.fetchedSelectionManager respondsToSelector:@selector(controller:didChangeObject:atIndexPath:forChangeType:newIndexPath:)]){
//        [self.fetchedSelectionManager controller:controller didChangeObject:anObject atIndexPath:indexPath forChangeType:type newIndexPath:newIndexPath];
//    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
//    if([self.fetchedSelectionManager respondsToSelector:@selector(controllerDidChangeContent:)]){
//        [self.fetchedSelectionManager controllerDidChangeContent:controller];
//    }
    
    if(!self.deletedObject){
        return;
    }
    if([self.delegate respondsToSelector:@selector(objectDataSource:didDeleteObject:atIndexPath:)]){
        [self.delegate objectDataSource:self didDeleteObject:self.deletedObject atIndexPath:self.deletedObjectIndexPath];
    }
    self.deletedObject = nil;
    self.deletedObjectIndexPath = nil;
    
//    NSArray *fetchedObjectsBeforeChange = self.fetchedObjectsBeforeChange;
//    self.fetchedObjectsBeforeChange = nil;
//
//    if(!self.selectedObjectWasDeleted){
//        return;
//    }
//    self.selectedObjectWasDeleted = NO;
//
//    if(!self.tableViewController.shouldAlwaysHaveSelectedObject){
//        return;
//    }
    // its different context
//    NSManagedObject *detailItem = self.tableViewController.selectedObject;
//    //if(detailItem && ![controller.fetchedObjects containsObject:detailItem]){
//    NSManagedObject *object;
//    NSArray *fetchedObjects = controller.fetchedObjects;
//    if(fetchedObjects.count > 0){
//        NSUInteger i = [fetchedObjectsBeforeChange indexOfObject:detailItem];
//        if(i >= fetchedObjects.count){
//            i = fetchedObjects.count - 1;
//        }
//        object = fetchedObjects[i];
//    }
//    [self.tableViewController selectObject:object notifyDelegate:YES];
    
    
        //[self.tableViewController reselectTableRowIfNecessaryScrollToSelection:YES];
  //  }
 
}

// in split and when on the root and the venue is deleted we don't want to select the next object
// but if in split and
// so maybe if the bool is set but we are not the top of the hierachy.

@end
