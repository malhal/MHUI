//
//  MHUEditableTableCell.h
//  MHU
//
//  Created by Malcolm Hall on 5/7/13.
//  Copyright (c) 2013 Malcolm Hall. All rights reserved.
//

//when using UITableViewCellStyleValue1, any change to the detailTextLabel.text causes layoutSubviews to be called.
//so this keeps the label and text field in sync but introduces a problem with matching the frames.

#import <UIKit/UIKit.h>
#import <MHUI/MHUDefines.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MHUEditableTableCellDelegate;

@interface MHUEditableTableCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, assign, nullable) id<MHUEditableTableCellDelegate> delegate;

//the cell needs to keep which index path it is editing because when it goes off screen cellForIndexPath table method no longer returns the cell.
//@property (copy) NSIndexPath* indexPath;

@property (nonatomic, strong, readonly) UITextField *textField;

//set if you want the textfield to be editable even when table is not in editing mode.
@property (nonatomic, assign) BOOL alwaysEditable;

//set if you want to select the text when tapping to begin editing. I.e. if the expected behavior is to replace all text.
@property (nonatomic, assign) BOOL fullTextSelect;

@end

@protocol MHUEditableTableCellDelegate <NSObject>

@optional

-(void)editableTableCell:(MHUEditableTableCell *)editableTableCell textDidChange:(NSString *)text;

@end

NS_ASSUME_NONNULL_END