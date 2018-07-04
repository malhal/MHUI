//
//  UITableViewCell+MUI.m
//  MUIKit
//
//  Created by Malcolm Hall on 19/01/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "UITableViewCell+MUI.h"
#import <objc/runtime.h>

const UITableViewCellStyle MUITableViewCellStyleEditable1 = 1000;

@implementation UITableViewCell (MUI)

- (UITableView *)mui_tableView{
    return [self valueForKey:@"_tableView"];
//    UIView *view = self.superview;
//    if(!view){
//        return nil;
//    }
//    static Class tableViewClass;
//    if(!tableViewClass){
//        tableViewClass = UITableView.class;
//    }
//    if([view isKindOfClass:tableViewClass]){
//        return (UITableView *)view;
//    }
//    view = view.superview;
//    if([view isKindOfClass:tableViewClass]){
//        return (UITableView *)view;
//    }
//    return nil;
}

- (UITextField *)mui_editableTextField{
    return [self valueForKey:@"_editableTextField"];
}

@end
