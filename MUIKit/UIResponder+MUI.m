//
//  UIResponder+MUI.m
//  MUIKit
//
//  Created by Malcolm Hall on 13/09/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "UIResponder+MUI.h"
#import "UIBarButtonItem+MUI.h"

@implementation UIResponder (MUI)

- (__kindof UIViewController *)mui_viewController{
    UIResponder *responder = self;
    while (responder && ![responder isKindOfClass:UIViewController.class]){ // from the cell go up the views to the controller.
        responder = [responder nextResponder];
    }
    return (UIViewController *)responder;
}

//- (NSPersistentContainer *)mui_persistentContainer{
//    NSPersistentContainer *result;
//    if (self.nextResponder != nil){
//        if ([self.nextResponder respondsToSelector:@selector(mui_persistentContainer)]){
//            result = self.nextResponder.mui_persistentContainer;
//        }
//    }
//    return result;
//}

@end

