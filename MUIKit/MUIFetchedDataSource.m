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
#import "MUIFetchedSelectionManager.h"

@interface MUIFetchedDataSource()

@property (strong, nonatomic, readwrite) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSMutableDictionary *objectClassesByReuseIdentifier;
@property (assign, nonatomic) BOOL sectionsCountChanged;

@end

@implementation MUIFetchedDataSource

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController{
    self = [super init];//[super initWithTableViewController:tableViewController];
    if (self) {
        _fetchedResultsController = fetchedResultsController;
        fetchedResultsController.delegate = self;
        _objectClassesByReuseIdentifier = [NSMutableDictionary dictionaryWithObject:NSManagedObject.class forKey:@"Cell"];
    }
    return self;
}

- (void)setFetchedSelectionManager:(MUIFetchedSelectionManager *)fetchedSelectionManager{
    if(fetchedSelectionManager == self.selectionManager){
        return;
    }
    self.selectionManager = fetchedSelectionManager;
    //self.fetchedResultsControllerDelegate = fetchedSelectionManager;
}

- (MUIFetchedSelectionManager *)fetchedSelectionManager{
    return (MUIFetchedSelectionManager *)self.selectionManager;
}

//- (void)setTableViewController:(MUITableViewController *)tableViewController{
//    if(tableViewController == _tableViewController){
//        return;
//    }
//    _tableViewController = tableViewController;
    //tableViewController.delegate = self.selectionManager;
//}



- (id)forwardingTargetForSelector:(SEL)aSelector{
    if(MHFProtocolHasInstanceMethod(@protocol(NSFetchedResultsControllerDelegate), aSelector)){
        if([self.fetchedSelectionManager respondsToSelector:aSelector]){
            return self.fetchedSelectionManager;
        }
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    if([super respondsToSelector:aSelector]){
        return YES;
    }
    else if(MHFProtocolHasInstanceMethod(@protocol(NSFetchedResultsControllerDelegate), aSelector)){
        return [self.fetchedSelectionManager respondsToSelector:aSelector];
    }
    return NO;
}

- (void)registerReuseIdentifier:(NSString *)reuseIdentifier forObjectOfClass:(Class)class{
    self.objectClassesByReuseIdentifier[reuseIdentifier] = class;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath{
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (NSIndexPath *)indexPathForObject:(NSManagedObject *)object{
    return [self.fetchedResultsController indexPathForObject:object];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSString *reuseIdentifier = nil;
    for(NSString *s in self.objectClassesByReuseIdentifier.allKeys){
        Class class = self.objectClassesByReuseIdentifier[s];
        if([object isKindOfClass:class]){
            reuseIdentifier = s;
            break;
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    [self configureCell:cell withObject:object];
    return cell;
}


//- (nullable NSString *)modelIdentifierForObject:(NSManagedObject *)object{
//    return object.objectID.URIRepresentation.absoluteString;
//}

//// on encode it asks for first and selected. On restore it asks for first so maybe checks ID. idx can be nil. called on decode too but with nil.
//- (nullable NSString *)modelIdentifierForElementAtIndexPath:(NSIndexPath *)idx inView:(UIView *)view{
//    NSManagedObject *object = [self objectAtIndexPath:idx];
//    NSString *identifier = object.objectID.URIRepresentation.absoluteString;
//    return identifier;
//}
//
//// called on decode
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
    if([self.fetchedSelectionManager respondsToSelector:@selector(controllerWillChangeContent:)]){
        [self.fetchedSelectionManager controllerWillChangeContent:controller];
    }
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
    if([self.fetchedSelectionManager respondsToSelector:@selector(controller:didChangeSection:atIndex:forChangeType:)]){
        [self.fetchedSelectionManager controller:controller didChangeSection:sectionInfo atIndex:sectionIndex forChangeType:type];
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    if([self.fetchedSelectionManager respondsToSelector:@selector(controller:didChangeObject:atIndexPath:forChangeType:newIndexPath:)]){
        [self.fetchedSelectionManager controller:controller didChangeObject:anObject atIndexPath:indexPath forChangeType:type newIndexPath:newIndexPath];
    }
}



- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
    if([self.fetchedSelectionManager respondsToSelector:@selector(controllerDidChangeContent:)]){
        [self.fetchedSelectionManager controllerDidChangeContent:controller];
    }
}



@end
