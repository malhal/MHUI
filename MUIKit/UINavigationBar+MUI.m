//
//  UINavigationBar+MUI.m
//  MUIKit
//
//  Created by Malcolm Hall on 05/01/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "UINavigationBar+MUI.h"
#import <objc/runtime.h>

@implementation UINavigationBar (MUI)

-(UIProgressView*)mui_progressView{
    // find prev instance
    UIProgressView *progress = objc_getAssociatedObject(self, "mui_progressView");
    if(!progress){
        progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        [self addSubview:progress];
        // pin to bottom
        [progress.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
        [progress.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
        [progress.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
        progress.translatesAutoresizingMaskIntoConstraints = NO;
        // remember it
        objc_setAssociatedObject(self, "mui_progressView", progress, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return progress;
}

@end
