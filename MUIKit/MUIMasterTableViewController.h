//
//  MUIMasterTableViewController.h
//  MUIKit
//
//  Created by Malcolm Hall on 15/09/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MUIMasterTableViewControllerDelegate, MUIMasterTableViewControllerDataSource;

@interface MUIMasterTableViewController : UITableViewController

- (void)showItemNearIndexPath:(NSIndexPath *)indexPath;

- (void)updateSelectionForCurrentVisibleDetailItem;

@property (strong, nonatomic, readonly) id selectedObject;

// called either when edit animations ended or swipe menu closed animation has ended
- (void)didEndEditing;

- (NSIndexPath *)indexPathForObject:(id)object;

- (id)objectAtIndexPath:(NSIndexPath *)object;

- (void)showSelectedItem;

@end

NS_ASSUME_NONNULL_END
