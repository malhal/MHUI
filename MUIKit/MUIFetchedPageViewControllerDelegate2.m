//
//  MUIFetchedPageViewControllerDelegate.m
//  MUIKit
//
//  Created by Malcolm Hall on 18/04/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "MUIFetchedPageViewControllerDelegate2.h"

@interface MUIFetchedPageViewControllerDelegate2 ()

@property (strong, nonatomic) NSIndexPath *deletedIndexPath;

@end

@implementation MUIFetchedPageViewControllerDelegate2


- (void)setSelectedPageObject:(NSManagedObject *)selectedPageObject{
    [self setSelectedPageObject:selectedPageObject notify:NO];
}

- (void)setSelectedPageObject:(NSManagedObject *)selectedPageObject notify:(BOOL)notify{
    if(selectedPageObject == _selectedPageObject){
        return;
    }
    _selectedPageObject = selectedPageObject;
    if(notify){
        //[self.delegate fetchedViewController:self didSelectPageObject:selectedPageObject];
    }
}


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    UIViewController *controller = (UIViewController *)pageViewController.viewControllers.firstObject;
    //[self setSelectedPageObject:controller.fetchedPageObject notify:YES];
    //[self configureView];
}

#pragma mark - Fetched results controller

//- (NSFetchedResultsController *)fetchedResultsController{
//    if(!_fetchedResultsController){
////        [self createFetchedResultsController];
////        NSAssert(_fetchedResultsController, @"FRC must be set at end of create");
//        _fetchedResultsController = [NSFetchedResultsController.alloc initWithFetchRequest:self.fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
//    }
//    return _fetchedResultsController;
//}

//- (void)setFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController{
//    if(fetchedResultsController == _fetchedResultsController){
//        return;
//    }
//    else if(_fetchedResultsController.delegate == self){
//        _fetchedResultsController.delegate = nil;
//        fetchedResultsController.delegate = self;
//    }
//    _fetchedResultsController = fetchedResultsController;
//    //[self configureTableViewForFetchedResultsController];
//}



@end
