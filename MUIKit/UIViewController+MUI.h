//
//  UIViewController+MUI.h
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 29/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MUI)

@property (nonatomic, assign, setter=mui_setLoading:) BOOL mui_loading;

@property (nonatomic, assign, readonly) BOOL mui_isViewVisible;

// on iPad in a splitview the detail view loads with no detail item. This allows you to
// override default view and when no detail item show a place holder view.
// Then when the detail item is available call this and in load view call super, e.g.
/*
- (void)loadView{
    if(!self.fetchedResultsController){
        self.view = [UIView.alloc init];
        return;
    }
    [super loadView];
}
*/
// Not actually using this because decided to set a default UIViewController on the nav controller at start up instead.
- (void)mui_reloadView;

+ (__kindof UIViewController *)mui_viewControllerForView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
