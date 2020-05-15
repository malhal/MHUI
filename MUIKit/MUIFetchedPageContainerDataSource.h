//
//  DataSource.h
//  Paging1
//
//  Created by Malcolm Hall on 04/04/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <MCoreData/MCoreData.h>
#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

//@class MUIFetchedPageContainerDataSource;
//
//@protocol MUIFetchedPageContainerDataSourceDelegate<NSObject>
//
//- (UIViewController<MUIPageObjectControlling> *)fetchedPageContainerDataSource:(MUIFetchedPageContainerDataSource *)fetchedPageContainerDataSource newViewControllerWithObject:(id)object;
//
//@end

//@protocol MUIFetchedPage <NSObject>
//
//
//
//@end

@interface MUIFetchedPageContainerDataSource : NSObject<UIPageViewControllerDataSource>

@property (strong, nonatomic, readonly) NSFetchedResultsController *fetchedResultsController;

- (instancetype)initWithFetchedResultsController:(NSFetchedResultsController *)controller;

//@property (weak, nonatomic) id<MUIFetchedPageContainerDataSourceDelegate> delegate;

- (UIViewController *)viewControllerForObject:(id)object inPageViewController:(UIPageViewController *)pageViewController;

@end

@interface UIViewController (MUIFetchedPageContainerDataSource)

@property (strong, nonatomic) id fetchedPageObject;

@end

NS_ASSUME_NONNULL_END
