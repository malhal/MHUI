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

@interface MUICollapseController : NSObject <UISplitViewControllerDelegate, UIStateRestoring>

- (instancetype)initWithSplitViewController:(UISplitViewController *)splitViewController;

@property (strong, nonatomic) UIViewController<MUIMasterCollapsing> *masterViewController;

@property (strong, nonatomic) UIViewController<MUIDetailCollapsing> *detailViewController;

@property (strong, nonatomic, readonly) UISplitViewController *splitViewController;

@property (weak, nonatomic) id<UISplitViewControllerDelegate> splitDelegate;

@end

@protocol MUIMasterCollapsing <NSObject>

- (BOOL)containsDetailItem:(id)detailItem;

@property (strong, nonatomic) MUICollapseController *masterCollapseController;

@end

@protocol MUIDetailCollapsing <NSObject>

@property (strong, nonatomic, readonly) id detailItem;

@property (strong, nonatomic) MUICollapseController *detailCollapseController;

@end

NS_ASSUME_NONNULL_END
