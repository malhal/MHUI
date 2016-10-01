//
//  MHUEditableTableCell.m
//  MHUI
//
//  Created by Malcolm Hall on 5/7/13.
//  Copyright (c) 2013 Malcolm Hall. All rights reserved.
//

#import "MHUEditableTableCell.h"

@interface MHUEditableTableCell()

@property (nonatomic, strong) UITextField* textField;

@property (nonatomic, assign) UITableViewCellStyle cellStyle;

@property (nonatomic, assign) BOOL textFieldResized;

@end

@implementation MHUEditableTableCell

-(UITextField *)textField{
    if(!_textField){
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.delegate = self;
        _textField.font = self.detailTextLabel.font;
        _textField.text = self.detailTextLabel.text;
        _textField.placeholder = self.textLabel.text;
        _textField.textAlignment = self.textLabel.textAlignment;;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:_textField];
    }
    return _textField;
}

-(void)layoutSubviews{
    // prevent infinite loop that occurs with Right Detail cells.
    if(!self.textFieldResized){
        // trick to make the text field the full size of the cell rather than just the size of current label.
        NSString* text = self.detailTextLabel.text;
        self.detailTextLabel.text = [[NSString string] stringByPaddingToLength:100 withString:NSStringFromClass(self.class) startingAtIndex:0];
        [super layoutSubviews];
        self.textField.frame = CGRectMake(self.detailTextLabel.frame.origin.x, 1, self.detailTextLabel.frame.size.width, self.frame.size.height) ;
        self.detailTextLabel.text = text;
        self.textFieldResized = YES;
        return;
    }
    self.textFieldResized = NO;
    
    [super layoutSubviews];
    
    if(self.alwaysEditable){
        self.detailTextLabel.hidden = YES;
        self.textField.hidden = NO;
    }else{
        //show either the detail label or the text field depending on if editing.
        self.detailTextLabel.hidden = self.editing || self.detailTextLabel.text.length == 0; // This OR prevents the placeholder being blanked out by the white label background when the delete animation plays.
        self.textField.hidden = !self.editing && self.detailTextLabel.text.length > 0; //  The OR makes sure the placeholder stays visble when animating out of edit.
    }
}



- (void)textFieldDidChange:(UITextField *)textField{
    self.detailTextLabel.text = textField.text; // keep them in sync
    if([self.delegate respondsToSelector:@selector(editableTableCell:textDidChange:)]){
        [self.delegate editableTableCell:self textDidChange:self.textField.text];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (_fullTextSelect) {
        [textField setSelectedTextRange:[textField textRangeFromPosition:textField.beginningOfDocument toPosition:textField.endOfDocument]];
    }
}

//hide keyboard
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    if(!editing){
        if([self.textField isFirstResponder]){
            [self.textField resignFirstResponder];
        }
    }
    [super setEditing:editing animated:animated];
}


-(void)prepareForReuse{
    [super prepareForReuse];
    self.textField.text = self.detailTextLabel.text;
    [self.textField resignFirstResponder];
}



@end
