//
//  MUITableViewController.h
//  MUIKit
//
//  Created by Malcolm Hall on 28/10/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MUITableViewControllerDelegate;

@interface MUITableViewController : UITableViewController

@property (nonatomic, assign) id<MUITableViewControllerDelegate> delegate;

@end

@protocol MUITableViewControllerDelegate <NSObject>

- (void)tableViewController:(MUITableViewController *)tableViewController viewWillAppear:(BOOL)animated;

- (void)tableViewController:(MUITableViewController *)tableViewController didEndEditing:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
