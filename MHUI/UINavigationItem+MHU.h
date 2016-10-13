//
//  UINavigationItem+MHU
//  MHUI
//
//  Created by Malcolm Hall on 10/04/2015.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MHUI/MHUDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationItem (MHU)

- (UIView *)mhu_getTitleRefreshView;
- (void)mhu_setTitleRefreshView:(UIView *)titleRefreshView;
- (void)mhu_beginTitleRefreshing;
- (void)mhu_endTitleRefreshing;

// by default calls to begin end are counted, use this method to override and hide the activity view by setting resetCounter YES.
- (void)mhu_endTitleRefreshingResetCounter:(BOOL)resetCounter;

@end

NS_ASSUME_NONNULL_END