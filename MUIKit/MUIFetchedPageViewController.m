//
//  MUIFetchedPageViewController.m
//  MUIKit
//
//  Created by Malcolm Hall on 05/03/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "MUIFetchedPageViewController.h"
#import "MUIFetchedPageContainerDataSource.h"
//#import "MUIFetchedPageViewControllerDelegate.h"

@interface MUIFetchedPageViewController ()

@property (strong, nonatomic) NSIndexPath *deletedIndexPath;


@end

@implementation MUIFetchedPageViewController

- (void)setFetchedPageContainerDataSource:(MUIFetchedPageContainerDataSource *)fetchedPageContainerDataSource{
    if(fetchedPageContainerDataSource == _fetchedPageContainerDataSource){
        return;
    }
    _fetchedPageContainerDataSource = fetchedPageContainerDataSource;
    //fetchedPageContainerDataSource.delegate = self;
 //   self.selectedPageObject = fetchedPageContainerDataSource.fetchedResultsController.fetchedObjects.firstObject;
 //   [self configure];
}

//- (void)setChildPageViewController:(UIPageViewController *)childPageViewController{
//    if(childPageViewController == _childPageViewController){
//        return;
//    }
//    _childPageViewController = childPageViewController;
//
//}

//- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
//    return YES;
//}

- (void)viewDidLoad{
    [super viewDidLoad];
//    if(!self.selectedPageObject){
//        //self.selectedPageObject = self.fetchedPageContainerDataSource.fetchedResultsController.fetchedObjects.firstObject;
//    }
    [self configure];
}

// maybe shouldn't be setting child view controllers here only configuring views.
- (void)configure{
//    if(!self.fetchedPageContainerDataSource){
//        return;
//    }
//    self.dataSource = self.fetchedPageContainerDataSource;
//    self.delegate = self;
//    //self.childPageViewController.delegate = self;
//    UIViewController *currentController = self.viewControllers.firstObject;
    
    id selectedPageObject = self.selectedPageObject;
//    if(!currentController || currentController.fetchedPageObject != selectedPageObject){
//        UIViewController *controller = [self.fetchedPageContainerDataSource viewControllerForObject:selectedPageObject inPageViewController:self];
//        controller.fetchedPageObject = selectedPageObject;
//        [self setViewControllers:@[controller] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
//    }
    NSLog(@"");
}

- (id)selectedPageObject{
    id<MUIDelegateSelection> delegate = (id<MUIDelegateSelection>)self.delegate;
    id selectedPageObject = [delegate selectedPageObjectInViewController:self];
    return selectedPageObject;
}


- (void)configureView{
//    NSFetchedResultsController *fetchedResultsController = self.fetchedResultsController;
//    if(!fetchedResultsController.delegate){
//        fetchedResultsController.delegate = self;
//        [fetchedResultsController performFetch:nil];
//    }
}


- (void)didDeleteDisplayedObject{
//    if([self.delegate respondsToSelector:@selector(fetchedViewController:didDeleteDisplayedObject:)]){
//        [self.delegate fetchedViewController:self didDeleteDisplayedObject:self.selectedPageObject];
//    }
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            break;
        case NSFetchedResultsChangeDelete:
            break;
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(NSManagedObject *)object
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {

    switch(type) {
        case NSFetchedResultsChangeInsert:
        break;
        case NSFetchedResultsChangeDelete:
        {
            if(object == self.selectedPageObject){
                //[self didDeleteDisplayedObject];
                self.deletedIndexPath = indexPath;
            }
        }
        break;
        case NSFetchedResultsChangeMove:
        case NSFetchedResultsChangeUpdate:
        break;
        
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if(!self.deletedIndexPath){
        return;
    }
    NSManagedObject *object;
    @try {
        object = [controller objectAtIndexPath:self.deletedIndexPath];
    } @catch (NSException *exception) {
        object = controller.fetchedObjects.lastObject;
    } @finally {
    }
    //self.selectedPageObject = object;
    //[self configure];
}


@end
