//
//  MUITableViewController.m
//  MUIKit
//
//  Created by Malcolm Hall on 05/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUITableViewController.h"

@interface MUITableViewController ()

@end

@implementation MUITableViewController

- (id)forwardingTargetForSelector:(SEL)aSelector{
    if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDataSource), aSelector)){
        if([self.dataSource respondsToSelector:aSelector]){
            return self.dataSource;
        }
    }
    else if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDelegate), aSelector)){
        if([self.delegate respondsToSelector:aSelector]){
            return self.delegate;
        }
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    if([super respondsToSelector:aSelector]){
        return YES;
    }
    else if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDataSource), aSelector)){
        return [self.dataSource respondsToSelector:aSelector];
    }
    else if(MHFProtocolHasInstanceMethod(@protocol(UITableViewDelegate), aSelector)){
        return [self.delegate respondsToSelector:aSelector];
    }
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    //self.selectedRowBeforeEditing = editing ? self.tableView.indexPathForSelectedRow : nil;
    if(!editing && animated){
        // because otherwise the checkmark gets selected when sliding back.
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            //[self.masterSupport updateSelectionForCurrentSelectedMasterItem];
            [self tableViewControllerDidEndEditing];
        }];
    }
    [super setEditing:editing animated:animated];
    if(!editing){
        if(animated){
            [CATransaction commit];
        }
        else{
            //[self.masterSupport updateSelectionForCurrentSelectedMasterItem]; // test if needs a perform after delay.
            [self tableViewControllerDidEndEditing];
        }
    }
}

- (void)tableViewControllerDidEndEditing{
    if([self.delegate respondsToSelector:@selector(tableViewControllerDidEndEditing:)]){
        [self.delegate tableViewControllerDidEndEditing:self];
    }
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.editButtonItem.enabled = NO;
}

-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    self.editButtonItem.enabled = YES;
    [self performSelector:@selector(tableViewControllerDidEndEditing) withObject:nil afterDelay:0];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    if([self.delegate respondsToSelector:@selector(tableViewControllerViewDidLoad:)]){
        [self.delegate tableViewControllerViewDidLoad:self];
    }
}

@end
