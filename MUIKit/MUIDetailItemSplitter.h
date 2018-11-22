//
//  MUILargeDetailSplitter.h
//  MUIKit
//
//  Created by Malcolm Hall on 03/11/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//
// A split view delegate that performs the usual behavior for a master detail app when using the mui_detailItem design.

#import <UIKit/UIKit.h>
#import <MHFoundation/MHFoundation.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MUIDetailItemSplitterDelegate;
@class MUISplitViewController;

@interface MUIDetailItemSplitter : NSObject <UISplitViewControllerDelegate>

- (instancetype)initWithSplitViewController:(MUISplitViewController *)splitController;

@property (nonatomic, assign, readonly) MUISplitViewController *splitController;

@property (nonatomic, assign) NSObject<UISplitViewControllerDelegate> *splitControllerDelegate;

@property (nonatomic, assign) id<MUIDetailItemSplitterDelegate> delegate;

@end

@protocol MUIDetailItemSplitterDelegate <NSObject>
@optional
- (UIViewController *)createDetailViewControllerForDetailSplitter:(MUIDetailItemSplitter *)splitter;

@end

NS_ASSUME_NONNULL_END
