//
//  TableView.m
//  CloudEvents
//
//  Created by Malcolm Hall on 11/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MUITableView.h"

@interface MUITableView()

@property (assign, nonatomic) BOOL completionSet;

@end

@implementation MUITableView
@dynamic delegate;

- (void)loadView{
    
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    if(editing){
        [super setEditing:editing animated:animated];
        return;
    }
    
    BOOL isEditing = self.isEditing;
    BOOL isEditing2 = [[self valueForKey:@"_viewDelegate"] isEditing];
    
    if(!isEditing){
        if(animated && !self.completionSet){
            [self performSelector:@selector(notifyTableViewDidEndEditing) withObject:nil afterDelay:0];
        }
        return;
    }
    
    [CATransaction begin];
//
//    if(isEditing){
        self.completionSet = YES;
        [CATransaction setCompletionBlock:^{
            self.completionSet = NO;
            //if(self.isEditing){
               // [self notifyTableViewDidEndEditing];
//            }
//            else{
            // check if editing had been set again while waiting for anim to finish, otherwise would select in edit mode if swipe then done double tapped.
            if(!self.isEditing){
                // the perform is only needed in the case where the selected row is editing and the done button is tapped but we do it in all cases anyway.
                [self performSelector:@selector(notifyTableViewDidEndEditing) withObject:nil afterDelay:0];
            }
        }];
//    }
//    else{
//        if(!self.completionSet){
//            [self performSelector:@selector(notifyTableViewDidEndEditing) withObject:nil afterDelay:0];
//        }
//    }

    [super setEditing:editing animated:animated];
   //
//    BOOL pe = self.preventReentry;
//    if(editing == self.isEditing){ // this is called when view controller appears
//        [super setEditing:editing animated:animated];
//        if(!pe){
//            [self performSelector:@selector(notifyTableViewDidEndEditing) withObject:nil afterDelay:0];
//        }
//        return;
//    }
//    if(!pe){
    

//    }
//    self.preventReentry = YES;
//    [super setEditing:editing animated:animated];
//    self.preventReentry = NO;
//    if(!pe){
        [CATransaction commit];
//    }
}

- (void)notifyTableViewDidEndEditing{
    if([self.delegate respondsToSelector:@selector(tableViewDidEndEditing:)]){
        [self.delegate tableViewDidEndEditing:self];
    }
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    if([self.delegate respondsToSelector:@selector(tableViewDidMoveToSuperview:)]){
        [self.delegate tableViewDidMoveToSuperview:self];
    }
}

//- (void)willMoveToWindow:(UIWindow *)newWindow{
//    if([self.delegate respondsToSelector:@selector(tableView:willMoveToWindow:)]){
//        [self.delegate tableView:self willMoveToWindow:newWindow];
//    }
//}

//- (void)didMoveToWindow{
//    if([self.delegate respondsToSelector:@selector(tableViewDidMoveToWindow:)]){
//        [self.delegate tableViewDidMoveToWindow:self];
//    }
//}



@end
