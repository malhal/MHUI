//
//  UITableViewCell+MUI.h
//  MUIKit
//
//  Created by Malcolm Hall on 19/01/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

extern const UITableViewCellStyle MUITableViewCellStyleEditable1;

@interface UITableViewCell (MUI)

// the tableView this cell is in, it is used by the text field to call the end editing delegate method.
@property (nonatomic, weak, readonly) UITableView *mui_tableView;

@property (nonatomic, strong, readonly) UITextField *mui_editableTextField;

@end

NS_ASSUME_NONNULL_END
