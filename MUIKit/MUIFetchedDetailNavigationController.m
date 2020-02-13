//
//  MUIFetchedDetailNavigationController.m
//  MUIKit
//
//  Created by Malcolm Hall on 12/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "MUIFetchedDetailNavigationController.h"

@interface MUIFetchedDetailNavigationController ()

@end

@implementation MUIFetchedDetailNavigationController

- (void)setFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController{
    if(fetchedResultsController == _fetchedResultsController){
        return;
    }
    else if(_fetchedResultsController.delegate == self){
        _fetchedResultsController.delegate = nil;
    }
    _fetchedResultsController = fetchedResultsController;
    if(self.mui_isViewVisible){
        [self configureViewForFetchedResultsController];
    }
}

- (void)configureViewForFetchedResultsController{
    NSFetchedResultsController *fetchedResultsController = self.fetchedResultsController;
    if(fetchedResultsController){
        fetchedResultsController.delegate = self;
        NSError *error;
        if(![fetchedResultsController performFetch:&error]){
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
}


- (void)viewWillAppear:(BOOL)animated{
    [self configureViewForFetchedResultsController];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.fetchedResultsController.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nullable NSString *)modelIdentifierForElementAtIndexPath:(NSIndexPath *)idx inView:(UIView *)view{
    if(!idx){
        return nil;
    }
    NSArray *fetchedObjects = self.fetchedResultsController.fetchedObjects;
    NSUInteger index = [idx indexAtPosition:0];
    if(index < 0 || index >= fetchedObjects.count){
        return nil;
    }
    NSManagedObject *object = self.fetchedResultsController.fetchedObjects[index];
    NSString *identifier = object.objectID.URIRepresentation.absoluteString;
    return identifier;
}

// called on decode
- (nullable NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view{
    if(!identifier){
        return nil;
    }
    NSURL *objectURI = [NSURL URLWithString:identifier];
    NSManagedObject *object = [self.fetchedResultsController.managedObjectContext mcd_objectWithURI:objectURI];
    //NSIndexPath *indexPath = [self.fetchedResultsController indexPathForObject:object];
    if(!object){
        return nil;
    }
    NSUInteger index = [self.fetchedResultsController.fetchedObjects indexOfObject:object];
    return [NSIndexPath indexPathWithIndex:index];
}

@end
