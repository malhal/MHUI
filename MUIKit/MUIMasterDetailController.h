//
//  MUIMasterDetailController.h
//  RootMUIMasterDetail
//
//  Created by Malcolm Hall on 10/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const MUIMasterDetailControllerDetailItemDidChange;

@protocol MUIDetailItemSelecting;

@interface MUIMasterDetailController : NSObject <UISplitViewControllerDelegate>

- (instancetype)initWithSplitViewController:(UISplitViewController *)splitViewController;

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) UIViewController<MUIDetailItemSelecting> *masterViewController;

@property (strong, nonatomic) UISplitViewController *splitViewController;

@end

@interface UIViewController (MUIMasterDetailController)

@property (strong, nonatomic) MUIMasterDetailController* masterDetailController;

@end

//@interface UISplitViewController (MUIMasterDetailController)
//
//@property (strong, nonatomic) MUIMasterDetailController* masterDetailController;
//
//@end

@protocol MUIDetailItemSelecting <NSObject>

- (BOOL)canSelectDetailItem:(NSObject *)detailItem;

@end

NS_ASSUME_NONNULL_END
