//
//  UINavigationItem+MUI
//  MUIKit
//
//  Created by Malcolm Hall on 10/04/2015.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationItem (MUI)

- (UIView *)mui_getTitleRefreshView;
- (void)mui_setTitleRefreshView:(UIView *)titleRefreshView;
- (void)mui_beginTitleRefreshing;
- (void)mui_endTitleRefreshing;

// by default calls to begin end are counted, use this method to override and hide the activity view by setting resetCounter YES.
- (void)mui_endTitleRefreshingResetCounter:(BOOL)resetCounter;

@end

NS_ASSUME_NONNULL_END
