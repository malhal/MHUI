//
//  UITableViewController+MUI.m
//  MUIKit
//
//  Created by Malcolm Hall on 11/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "UITableViewController+MUI.h"

@implementation UITableViewController (MUI)

- (UITableView *)mui_tableViewIfLoaded{
    return MHFDynamicCast(UITableView.class, self.viewIfLoaded);
}

@end
