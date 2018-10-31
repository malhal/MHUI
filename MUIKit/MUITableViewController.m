//
//  MUITableViewController.m
//  MUIKit
//
//  Created by Malcolm Hall on 28/10/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUITableViewController+Internal.h"
#import "MUIMasterController+Internal.h"

@interface MUITableViewController ()

@end

@implementation MUITableViewController

//- (void)setMasterController:(MUIMasterController *)masterController{
//    if(masterController == _masterController){
//        return;
//    }
//    else if(_masterController){
//        _masterController.tableViewController = nil;
//    }
//    _masterController = masterController;
//    if(!masterController){
//        return;
//    }
//    masterController.tableViewController = self;
//}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    //self.selectedRowBeforeEditing = editing ? self.tableView.indexPathForSelectedRow : nil;
    if(!editing && animated){
        // because otherwise the checkmark gets selected when sliding back.
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            //[self.masterController updateSelectionForCurrentVisibleDetailItem];
            [self.delegate tableViewController:self didEndEditing:animated];
        }];
    }
    [super setEditing:editing animated:animated];
    if(!editing){
        if(animated){
            [CATransaction commit];
        }
        else{
            //[self.masterController updateSelectionForCurrentVisibleDetailItem]; // test if needs a perform after delay.
            [self.delegate tableViewController:self didEndEditing:animated];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
//    id item = [self mui_currentVisibleDetailItemWithSender:self]; // wont find it on rotate from portrait
//    if(item){
//        self.masterController.selectedMasterItem = item;
//    }
    [super viewWillAppear:animated];
    //[self.masterController updateForViewWillAppear];
    [self.delegate tableViewController:self viewWillAppear:animated];
}

// delegate is not configured yet
//- (void)viewDidLoad{
//    [super viewDidLoad];
//    [self.delegate viewDidLoadForTableViewController:self];
//}

@end
