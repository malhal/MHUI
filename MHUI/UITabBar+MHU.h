//
//  UITabBar+MHU.h
//  MHUI
//
//  Created by Malcolm Hall on 08/01/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//
// Progress bar that appears at top of tab bar.

#import <UIKit/UIKit.h>
#import <MHUI/MHUDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (MHU)

@property (nonatomic, strong, readonly) UIProgressView *mhu_progressView;

@end

NS_ASSUME_NONNULL_END