//
//  MUICollapseController.h
//  RootMUIMasterDetail
//
//  Created by Malcolm Hall on 10/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MUIMasterCollapsing, MUIDetailCollapsing;
@class MUIRootNavigationController;

@interface MUICollapseController : NSObject <UISplitViewControllerDelegate, UIStateRestoring>

//- (instancetype)initWithPrimaryNavigationController:(MUIRootNavigationController *)primaryNavigationController splitViewController:(UISplitViewController *)splitViewController;

// Doesn't take a master param because in case if 2-split with initial pushing master it doesn't exist yet.
- (instancetype)initWithSplitViewController:(UISplitViewController *)splitViewController;

@property (strong, nonatomic, nullable) UIViewController<MUIMasterCollapsing> *masterViewController;

@property (strong, nonatomic, nullable) UIViewController<MUIDetailCollapsing> *detailViewController;

@property (strong, nonatomic, readonly) UISplitViewController *splitViewController;

@property (weak, nonatomic, nullable) id<UISplitViewControllerDelegate> splitDelegate;

@end

@protocol MUIMasterCollapsing <NSObject>

- (BOOL)containsDetailItem:(id)detailItem;

//@property (strong, nonatomic) MUICollapseController *collapseControllerForMaster;

@end

@protocol MUIDetailCollapsing <NSObject>

@property (strong, nonatomic, readonly) id detailItem;

//@property (weak, nonatomic) MUICollapseController *collapseControllerForDetail;

@end

@interface UIViewController (MUICollapseController)

@property (weak, nonatomic, nullable, readonly) MUICollapseController* mui_collapseControllerForMaster;

@property (weak, nonatomic, nullable, readonly) MUICollapseController* mui_collapseControllerForDetail;

- (BOOL)mui_isMemberOfViewControllerHierarchy:(UIViewController *)highViewController;

@end

NS_ASSUME_NONNULL_END
