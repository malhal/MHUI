//
//  UINavigationItem+MUI.m
//  MUIKit
//
//  Created by Malcolm Hall on 10/04/2015.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "UINavigationItem+MUI.h"
#import <objc/runtime.h>

@implementation UINavigationItem (TitleRefresh)

- (UIView*)mui_getTitleRefreshView{

    UIView* titleRefreshView = objc_getAssociatedObject(self, @selector(mui_getTitleRefreshView));
    
    if(!titleRefreshView){
        // create a default
        static UIActivityIndicatorView* kDefault = nil;
        if(!kDefault){
            kDefault = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [kDefault startAnimating];
        }
        // return the default
        return kDefault;
    }
    
    return titleRefreshView;
}

- (void)mui_setTitleRefreshView:(UIView *)titleRefreshView {
    [self willChangeValueForKey:@"titleRefreshView"];
    objc_setAssociatedObject(self, @selector(mui_getTitleRefreshView),
                             titleRefreshView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"titleRefreshView"];
}

- (NSInteger)mui_getBeginTitleRefreshingCount{
    NSNumber* number = objc_getAssociatedObject(self, @selector(mui_getBeginTitleRefreshingCount));
    return number.integerValue;
}

- (void)mui_setBeginTitleRefreshingCount:(NSInteger)count{
    objc_setAssociatedObject(self, @selector(mui_getBeginTitleRefreshingCount),
                             [NSNumber numberWithInteger:count],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)mui_beginTitleRefreshing{
    
    NSInteger count = [self mui_getBeginTitleRefreshingCount];
    count++;
    [self mui_setBeginTitleRefreshingCount:count];
    
    self.titleView = [self mui_getTitleRefreshView];
}

- (void)mui_endTitleRefreshing{
    [self mui_endTitleRefreshingResetCounter:NO];
}

- (void)mui_endTitleRefreshingResetCounter:(BOOL)resetCounter{
    self.titleView = nil;
    
//    NSInteger count = [self mui_getBeginTitleRefreshingCount];
//    count--;
//    
//    if(resetCounter){
//        count = 0;
//    }
//    [self mui_setBeginTitleRefreshingCount:count];
//    
//    // The assertion helps to find programmer errors in activity indicator management.
//    // Since a negative NumberOfCallsToSetVisible is not a fatal error,
//    // it should probably be removed from production code.
//    NSAssert(count >= 0, @"mui_endTitleRefreshing was called more often than begin");
//    
//    // hide if our count is zero
//    if(count <= 0){
//        self.titleView = nil;
//    }
}

@end
