//
//  MUIFetchedPageViewController.h
//  MUIKit
//
//  Created by Malcolm Hall on 05/03/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <MCoreData/MCoreData.h>
#import <MHFoundation/MHFoundation.h>
#import <UIKit/UIKit.h>
#import <MUIKit/MUIFetchedPageContainerDataSource.h>

NS_ASSUME_NONNULL_BEGIN

//@protocol MUIFetchedPageViewControllerDelegate;

@interface MUIFetchedPageViewController<ResultType:NSManagedObject *> : UIPageViewController<NSFetchedResultsControllerDelegate>

//@property (strong, nonatomic) UIPageViewController *childPageViewController;
//@property (strong, nonatomic, nullable) NSFetchedResultsController<ResultType> *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//@property (strong, nonatomic, nullable) NSFetchRequest<ResultType> *fetchRequest;

//@property (strong, nonatomic) ResultType selectedPageObject;

//@property (weak, nonatomic) id<MUIFetchedPageViewControllerDelegate> delegate;

//@property (strong, nonatomic, readonly) NSArray<ResultType> *fetchedObjects;

//- (void)configureView;
@property (strong, nonatomic) MUIFetchedPageContainerDataSource *fetchedPageContainerDataSource;

@end

@protocol MUIDelegateSelection <NSObject>

//- (void)fetchedViewController:(MUIFetchedPageViewController *)fetchedViewController didDeleteDisplayedObject:(NSManagedObject *)displayedObject;
//
//- (void)fetchedViewController:(MUIFetchedPageViewController *)fetchedViewController didSelectPageObject:(id)object;

- (id)selectedPageObjectInViewController:(UIViewController *)viewController;


@end

NS_ASSUME_NONNULL_END
