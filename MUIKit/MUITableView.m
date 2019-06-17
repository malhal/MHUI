//
//  TableView.m
//  CloudEvents
//
//  Created by Malcolm Hall on 11/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MUITableView.h"

@interface MUITableView()

@end

@implementation MUITableView
@dynamic delegate;

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    if(editing){
        [super setEditing:editing animated:animated];
        return;
    }
//    else if(editing == self.isEditing){
//        return;
//    }
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        if(self.isEditing){
            [self tableViewDidEndEditing];
        }
        else{
            // the perform is only needed in the case where a row is editing and the done button is tapped.
            [self performSelector:@selector(tableViewDidEndEditing) withObject:nil afterDelay:0];
        }
    }];
    [super setEditing:editing animated:animated];
    [CATransaction commit];
}

- (void)tableViewDidEndEditing{
    if([self.delegate respondsToSelector:@selector(tableViewDidEndEditing:)]){
        [self.delegate performSelector:@selector(tableViewDidEndEditing:) withObject:self];
    }
    
}


@end
