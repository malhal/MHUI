//
//  MUIProgressViewController.h
//  MUIKit
//
//  Created by Malcolm Hall on 22/09/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@class MUICircularProgressView;

@protocol MUIProgressViewControllerDelegate;

@interface MUIProgressViewController : UIViewController

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) MUICircularProgressView *circularProgressView;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) NSProgress *observedProgress;
@property (weak, nonatomic) id<MUIProgressViewControllerDelegate> progressDelegate;
@property (nonatomic) BOOL showsCancel;

- (instancetype)initWithDelegate:(id<MUIProgressViewControllerDelegate>)delegate;

@end

@protocol MUIProgressViewControllerDelegate

- (void)willDismissProgressViewController:(MUIProgressViewController *)pvc;

@end


NS_ASSUME_NONNULL_END
