//
//  UINavigationBar+MHU.h
//  MHUI
//
//  Created by Malcolm Hall on 05/01/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MHUI/MHUDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (MHU)

@property (nonatomic, readonly) UIProgressView* mhu_progressView;

@end

NS_ASSUME_NONNULL_END