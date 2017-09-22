//
//  MUIMultilineTableCell.h
//  MUIKit
//
//  Created by Malcolm Hall on 21/10/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

// Enables built in cell styles to expand their row height to fit multiline labels and support dynamic type.
// In storyboard set:
//  Number of lines on the labels.
//  Font to a style to support dynamic type.
// Configure tableView in viewDidLoad as follows:
//  self.tableView.estimatedRowHeight = 44.0;
//  self.tableView.rowHeight = UITableViewAutomaticDimension;

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

@interface MUIMultilineTableCell : UITableViewCell

@end
