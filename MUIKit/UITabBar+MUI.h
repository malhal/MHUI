//
//  UITabBar+MUI.h
//  MUIKit
//
//  Created by Malcolm Hall on 08/01/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//
// Progress bar that appears at top of tab bar.

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (MUI)

@property (nonatomic, strong, readonly) UIProgressView *mui_progressView;

@end

NS_ASSUME_NONNULL_END
