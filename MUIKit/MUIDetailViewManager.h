//
//  MUIDetailViewManager.h
//  RootMUIMasterDetail
//
//  Created by Malcolm Hall on 10/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const MUIDetailViewManagerWillShowDetailViewControllerNotification;

@protocol MUIDetailViewManagerDelegate;

@interface MUIDetailViewManager : NSObject<UISplitViewControllerDelegate, UIStateRestoring>

// Doesn't take a master param because in case if 2-split with initial pushing master it doesn't exist yet.
- (instancetype)initWithSplitViewController:(UISplitViewController *)splitViewController;

@property (strong, nonatomic, readonly) UISplitViewController *splitViewController;

@property (weak, nonatomic, nullable) id<MUIDetailViewManagerDelegate> delegate;

@property (strong, nonatomic, readonly) UIViewController *detailViewController;

@end

@interface UISplitViewController (MUIDetailViewManager)

//@property (strong, nonatomic, readonly) MUISplitDetailItem *mui_currentSplitDetailItem;

@property (weak, nonatomic, readonly) MUIDetailViewManager *mui_detailViewManager;

@end

@interface UIViewController (MUIDetailViewManager)

//- (id)mui_currentVisibleDetailItem;

@end

@protocol MUIDetailViewManagerDelegate<UISplitViewControllerDelegate>



@end

NS_ASSUME_NONNULL_END
