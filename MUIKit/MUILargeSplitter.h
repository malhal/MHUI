//
//  MUILargeDetailSplitter.h
//  MUIKit
//
//  Created by Malcolm Hall on 03/11/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MHFoundation/MHFoundation.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MUILargeSplitterDelegate;
@class MUIRootMasterDetailSplitViewController;

@interface MUILargeSplitter : NSObject <UISplitViewControllerDelegate>

- (instancetype)initWithLargeSplitViewController:(MUIRootMasterDetailSplitViewController *)splitController;

@property (nonatomic, assign, readonly) MUIRootMasterDetailSplitViewController *splitController;

@property (nonatomic, assign) NSObject<UISplitViewControllerDelegate> *splitControllerDelegate;

@property (nonatomic, assign) id<MUILargeSplitterDelegate> delegate;

@end

@protocol MUILargeSplitterDelegate <NSObject>

- (UINavigationController *)createDetailNavigationControllerForLargeSplitter:(MUILargeSplitter *)splitter;

@end

NS_ASSUME_NONNULL_END
