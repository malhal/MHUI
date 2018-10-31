//
//  MUIMasterController.h
//  MUIKit
//
//  Created by Malcolm Hall on 28/10/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <MHFoundation/MHFoundation.h>
//#import <UIKit/UIKit.h>
//#import <MUIKit/MUIDefines.h>
#import <MUIKit/MUITableViewController.h>
NS_ASSUME_NONNULL_BEGIN

@protocol MUIMasterControllerDelegate, MUIMasterControllerDataSource;
@class MUITableViewController;

@interface MUIMasterController : NSObject<MUITableViewControllerDelegate, UITableViewDelegate>

- (instancetype)initWithTableViewController:(MUITableViewController *)tableViewController;

@property (assign, nonatomic, readonly) MUITableViewController *tableViewController;

@property (nonatomic, assign) id<MUIMasterControllerDelegate> delegate;

@property (nonatomic, assign) id<MUIMasterControllerDataSource> dataSource;

@property (nonatomic, assign) id<UINavigationControllerDelegate> navigationDelegate;

@property (nonatomic, assign) id<UITableViewDelegate> tableDelegate;
//
//@property (assign, nonatomic, readonly) UINavigationController *navigationController;

@property (strong, nonatomic, readwrite) id selectedMasterItem;

- (void)updateSelectionForCurrentVisibleDetailItem;

// call after deleting
- (void)selectMasterItemNearIndexPath:(NSIndexPath *)indexPath;

@end

@protocol MUIMasterControllerDelegate <NSObject>

- (void)showSelectedItemForMasterController:(MUIMasterController *)masterController;

@end

@protocol MUIMasterControllerDataSource <NSObject>

- (NSIndexPath *)masterController:(MUIMasterController *)masterController indexPathForMasterItem:(id)masterItem;

- (id)masterController:(MUIMasterController *)masterController masterItemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
