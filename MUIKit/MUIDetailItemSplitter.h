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


//@class MUISplitViewController;

@interface MUIItemSplitter : NSObject <UISplitViewControllerDelegate>

//- (instancetype)initWithSplitViewController:(UISplitViewController *)splitController;

//@property (nonatomic, assign, readonly) UISplitViewController *splitController;

@property (nonatomic, assign) NSObject<UISplitViewControllerDelegate> *splitControllerDelegate;

@end

@protocol MUIDetailItemSplitterDelegate;

@interface MUIDetailItemSplitter : MUIItemSplitter

@property (nonatomic, assign) id<MUIDetailItemSplitterDelegate> delegate;

@end

@protocol MUIDetailItemSplitterDelegate <NSObject>
@optional
// implement if after being in portrait and moving back from detail, and rotating landscape, to show a default detail rather than the preserved one.
// usually use the storyboard to instantiate the detail navigation controller by its storyboard ID.
- (UIViewController *)createDetailViewControllerForDetailSplitter:(MUIDetailItemSplitter *)splitter;

@end

@protocol MUIMasterItemSplitterDelegate;

@interface MUIMasterItemSplitter : MUIItemSplitter

@property (nonatomic, assign) id<MUIMasterItemSplitterDelegate> delegate;

@end

@protocol MUIMasterItemSplitterDelegate <NSObject>
@optional
// implement if after being in portrait and moving back from detail, and rotating landscape, to show a default detail rather than the preserved one.
// usually use the storyboard to instantiate the detail navigation controller by its storyboard ID.
- (UIViewController *)createMasterViewControllerForMasterSplitter:(MUIMasterItemSplitter *)splitter;

@end


NS_ASSUME_NONNULL_END
