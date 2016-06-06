//
//  UITabBar+MHU.m
//  MHUI
//
//  Created by Malcolm Hall on 08/01/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "UITabBar+MHU.h"
#import <objc/runtime.h>

@implementation UITabBar (MHU)

-(UIProgressView*)mhu_progressView{
    // find prev instance
    UIProgressView *progress = objc_getAssociatedObject(self, "mhu_progressView");
    if(!progress){
        progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        [self addSubview:progress];
        // pin to bottom
        [progress.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
        [progress.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
        [progress.bottomAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        progress.translatesAutoresizingMaskIntoConstraints = NO;
        // remember it
        objc_setAssociatedObject(self, "mhu_progressView", progress, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return progress;
}

@end
