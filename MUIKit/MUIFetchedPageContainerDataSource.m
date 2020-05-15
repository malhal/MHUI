//
//  DataSource.m
//  Paging1
//
//  Created by Malcolm Hall on 04/04/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "MUIFetchedPageContainerDataSource.h"
#import <objc/runtime.h>

@interface MUIFetchedPageContainerDataSource()

@end

@implementation MUIFetchedPageContainerDataSource

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)controller
{
    self = [super init];
    if (self) {
        _fetchedResultsController = controller;
    }
    return self;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    if(!viewController.fetchedPageObject){
        return nil;
    }
    NSArray *objects = self.fetchedResultsController.fetchedObjects;
    NSUInteger index = [objects indexOfObject:viewController.fetchedPageObject];
    if(index == 0){
        return nil;
    }
    id object = [objects objectAtIndex:index - 1];
    UIViewController *vc = [self viewControllerForObject:object inPageViewController:pageViewController];
    vc.fetchedPageObject = object;
    return vc;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    if(!viewController.fetchedPageObject){
        return nil;
    }
    NSArray *objects = self.fetchedResultsController.fetchedObjects;
    NSUInteger index = [objects indexOfObject:viewController.fetchedPageObject];
    if(index == objects.count - 1){
        return nil;
    }
    id object = [objects objectAtIndex:index + 1];
    UIViewController *vc = [self viewControllerForObject:object inPageViewController:pageViewController];
    vc.fetchedPageObject = object;
    return vc;
}

- (UIViewController *)viewControllerForObject:(id)object inPageViewController:(UIPageViewController *)pageViewController{
    return nil;
}

@end

@implementation UIViewController (MUIFetchedPageContainerDataSource)

- (id)fetchedPageObject{
    return objc_getAssociatedObject(self, @selector(fetchedPageObject));
}

- (void)setFetchedPageObject:(id)fetchedPageObject{
    objc_setAssociatedObject(self, @selector(fetchedPageObject), fetchedPageObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
