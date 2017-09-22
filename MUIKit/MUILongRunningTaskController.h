//
//  ICLongRunningTaskController.h
//  MUIKit
//
//  Created by Malcolm Hall on 22/09/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>
#import <MUIKit/MUIProgressViewController.h>

NS_ASSUME_NONNULL_BEGIN

@interface MUILongRunningTaskController : NSObject <MUIProgressViewControllerDelegate>

@property (copy, nonatomic, nullable) void (^completionBlock)(BOOL cancelled);
@property (nonatomic) double intervalBeforeOpeningProgressDialog;
@property (nonatomic) BOOL isCancelled;
@property (strong, nonatomic, nullable) id keepAlive;
@property (strong, nonatomic) NSDate *lastAccessibilityAnnouncementDate;
@property (strong, nonatomic, nullable) NSDate *openProgressDate;
@property (strong, nonatomic, nullable) NSProgress *progress;
@property (copy, nonatomic) NSString *progressFormatString;
@property (strong, nonatomic, nullable) MUIProgressViewController *progressViewController;
@property (nonatomic) BOOL progressViewControllerDidFinishPresenting;
@property (nonatomic) BOOL shouldDismissProgressViewController;
@property (nonatomic) BOOL shouldShowCancelButton;
@property (nonatomic) BOOL shouldShowCircularProgress;
@property (copy, nonatomic) void (^updateProgressUIBlock)(float progress); // ?
@property (strong, nonatomic) UIViewController *viewControllerToPresentFrom;
@property (strong, nonatomic) UIWindow *window;

+ (void)setMainWindow:(UIWindow *)window;
- (void)closeProgressDialog;
- (void)completeTaskIfNecessary;
- (instancetype)init;
- (instancetype)initWithWindow:(UIWindow *)window intervalBeforeOpeningProgressDialog:(double)interval;
- (void)openProgressDialog;
- (void)startTask:(void (^)(NSProgress *progress))progressBlock completionBlock:(void (^)(BOOL cancelled))completionBlock;
- (void)updateProgress;
- (void)willDismissProgressViewController:(id)arg1;

@end

NS_ASSUME_NONNULL_END
