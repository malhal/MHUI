//
//  UIViewController+MUI.m
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 29/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "UIViewController+MUI.h"
#import "UINavigationItem+MUI.h"
#import <objc/runtime.h>

@implementation UIViewController (MUI)

-(void)mui_setLoading:(BOOL)loading{
    BOOL mui_loading = [objc_getAssociatedObject(self, @selector(mui_loading)) boolValue];
    if(loading == mui_loading){
        return;
    }
    self.view.userInteractionEnabled = !loading;
    self.navigationItem.rightBarButtonItem.enabled = !loading;
    self.navigationItem.hidesBackButton = loading;
    if(loading){
        [self.navigationItem mui_beginTitleRefreshing];
    }else{
        [self.navigationItem mui_endTitleRefreshing];
    }
    NSString* keyPath = NSStringFromSelector(@selector(mui_loading));
    [self willChangeValueForKey:keyPath];
    objc_setAssociatedObject(self, @selector(mui_loading), @(loading), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:keyPath];
}

-(BOOL)mui_loading{
    return [objc_getAssociatedObject(self, @selector(mui_loading)) boolValue];
}

- (BOOL)mui_isViewVisible{
    return self.isViewLoaded && self.view.window;
}

@end
