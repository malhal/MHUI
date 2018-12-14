//
//  MUIMasterDetailContext.h
//  RootMUIMasterDetail
//
//  Created by Malcolm Hall on 10/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

//extern NSString * const MUIMasterDetailContextDetailItemDidChange;

@protocol MUIMasterViewControlling, MUIDetailViewControlling;

@interface MUIMasterDetailContext : NSObject <UISplitViewControllerDelegate, UIStateRestoring>

- (instancetype)initWithSplitViewController:(UISplitViewController *)splitViewController;

//@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) UIViewController<MUIMasterViewControlling> *masterViewController;

@property (strong, nonatomic) UIViewController<MUIDetailViewControlling> *detailViewController;

@property (strong, nonatomic) UISplitViewController *splitViewController;

@property (weak, nonatomic) id<UISplitViewControllerDelegate> splitDelegate;

@end

@protocol MUIMasterViewControlling <NSObject>

- (BOOL)canSelectDetailItem:(id)detailItem;

@property (strong, nonatomic) MUIMasterDetailContext *masterDetailContext;

@end

@protocol MUIDetailViewControlling <NSObject>

@property (strong, nonatomic) MUIMasterDetailContext *masterDetailContext;

@property (strong, nonatomic, readonly) id detailItem;

@end


//@interface UISplitViewController (MUIMasterDetailContext)
//
//// returns the owning context
//@property (strong, nonatomic) MUIMasterDetailContext* masterDetailContext;
//
//@end

NS_ASSUME_NONNULL_END
