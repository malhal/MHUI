//
//  UINavigationBar+MUI.h
//  MUIKit
//
//  Created by Malcolm Hall on 05/01/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (MUI)

@property (nonatomic, readonly) UIProgressView* mui_progressView;

@end

NS_ASSUME_NONNULL_END
