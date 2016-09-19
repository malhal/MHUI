//
//  UINavigationItem+MHU.m
//  MHUI
//
//  Created by Malcolm Hall on 10/04/2015.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "UINavigationItem+MHU.h"
#import <objc/runtime.h>

@implementation UINavigationItem (TitleRefresh)

-(UIView*)mhu_getTitleRefreshView{

    UIView* titleRefreshView = objc_getAssociatedObject(self, @selector(mhu_getTitleRefreshView));
    
    if(!titleRefreshView){
        // create a default
        static UIActivityIndicatorView* kDefault = nil;
        if(!kDefault){
            kDefault = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [kDefault startAnimating];
        }
        // return the default
        return kDefault;
    }
    
    return titleRefreshView;
}

- (void)mhu_setTitleRefreshView:(UIView *)titleRefreshView {
    [self willChangeValueForKey:@"titleRefreshView"];
    objc_setAssociatedObject(self, @selector(mhu_getTitleRefreshView),
                             titleRefreshView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"titleRefreshView"];
}

-(NSInteger)mhu_getBeginTitleRefreshingCount{
    NSNumber* number = objc_getAssociatedObject(self, @selector(mhu_getBeginTitleRefreshingCount));
    return number.integerValue;
}

-(void)mhu_setBeginTitleRefreshingCount:(NSInteger)count{
    objc_setAssociatedObject(self, @selector(mhu_getBeginTitleRefreshingCount),
                             [NSNumber numberWithInteger:count],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)mhu_beginTitleRefreshing{
    
    NSInteger count = [self mhu_getBeginTitleRefreshingCount];
    count++;
    [self mhu_setBeginTitleRefreshingCount:count];
    
    self.titleView = [self mhu_getTitleRefreshView];
}

-(void)mhu_endTitleRefreshing{
    [self mhu_endTitleRefreshingResetCounter:NO];
}

-(void)mhu_endTitleRefreshingResetCounter:(BOOL)resetCounter{
    self.titleView = nil;
    
//    NSInteger count = [self mhu_getBeginTitleRefreshingCount];
//    count--;
//    
//    if(resetCounter){
//        count = 0;
//    }
//    [self mhu_setBeginTitleRefreshingCount:count];
//    
//    // The assertion helps to find programmer errors in activity indicator management.
//    // Since a negative NumberOfCallsToSetVisible is not a fatal error,
//    // it should probably be removed from production code.
//    NSAssert(count >= 0, @"mhu_endTitleRefreshing was called more often than begin");
//    
//    // hide if our count is zero
//    if(count <= 0){
//        self.titleView = nil;
//    }
}

@end
