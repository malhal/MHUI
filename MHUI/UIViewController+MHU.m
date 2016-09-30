//
//  UIViewController+MHU.m
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 29/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "UIViewController+MHU.h"
#import "UINavigationItem+MHU.h"
#import <objc/runtime.h>

@implementation UIViewController (MHU)

-(void)mhu_setLoading:(BOOL)loading{
    BOOL mhu_loading = [objc_getAssociatedObject(self, @selector(mhu_loading)) boolValue];
    if(loading == mhu_loading){
        return;
    }
    self.view.userInteractionEnabled = !loading;
    self.navigationItem.rightBarButtonItem.enabled = !loading;
    self.navigationItem.hidesBackButton = loading;
    if(loading){
        [self.navigationItem mhu_beginTitleRefreshing];
    }else{
        [self.navigationItem mhu_endTitleRefreshing];
    }
    NSString* keyPath = NSStringFromSelector(@selector(mhu_loading));
    [self willChangeValueForKey:keyPath];
    objc_setAssociatedObject(self, @selector(mhu_loading), @(loading), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:keyPath];
}

-(BOOL)mhu_loading{
    return [objc_getAssociatedObject(self, @selector(mhu_loading)) boolValue];
}

@end
