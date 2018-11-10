//
//  MUIDetailSplitter.h
//  MUIKit
//
//  Created by Malcolm Hall on 03/11/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MUIDetailSplitterDelegate;

@interface MUIDetailSplitter : NSObject <UISplitViewControllerDelegate>

- (instancetype)initWithSplitViewController:(UISplitViewController *)splitController;

@property (nonatomic, assign, readonly) UISplitViewController *splitController;

//@property (nonatomic, assign) id<UISplitViewControllerDelegate> splitDelegate;

@property (nonatomic, assign) id<MUIDetailSplitterDelegate> delegate;

@end

@protocol MUIDetailSplitterDelegate <NSObject>

- (UIViewController *)createDetailViewControllerForDetailSplitter:(MUIDetailSplitter *)detailSplitter;

@end

NS_ASSUME_NONNULL_END
