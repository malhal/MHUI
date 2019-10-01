//
//  UIBarButtonItem+MUI.h
//  MUIKit
//
//  Created by Malcolm Hall on 13/09/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <MHFoundation/MHFoundation.h>
#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (MUI)

// but its in the navigation controller view's hierarchy so not useful
@property (strong, nonatomic, readonly) UIView *view;

@property (strong, nonatomic) UIResponder *nextResponder;

@end

NS_ASSUME_NONNULL_END
