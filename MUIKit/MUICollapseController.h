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

@interface MUISplitDetailItem : NSObject

@property (strong, nonatomic) id object;

@end

@interface MUICollapseController : NSObject <UISplitViewControllerDelegate, UIStateRestoring>

// Doesn't take a master param because in case if 2-split with initial pushing master it doesn't exist yet.
- (instancetype)initWithSplitViewController:(UISplitViewController *)splitViewController;

@property (strong, nonatomic, readonly) UISplitViewController *splitViewController;

@property (weak, nonatomic, nullable) id<UISplitViewControllerDelegate> splitDelegate;

@end

@interface UIViewController (MUICollapseController)

- (BOOL)mui_canSelectSplitDetailItemObject:(id)object;

@property (strong, nonatomic, readonly) MUISplitDetailItem *mui_splitDetailItem;

@end

@interface UISplitViewController (MUICollapseController)

@property (strong, nonatomic, readonly) MUISplitDetailItem *mui_currentSplitDetailItem;

@end

NS_ASSUME_NONNULL_END
