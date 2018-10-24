//
//  MUIMasterTableViewController.h
//  MUIKit
//
//  Created by Malcolm Hall on 15/09/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MUIMasterTableViewController : UITableViewController

- (NSIndexPath *)indexPathForItem:(id)item;

- (void)showItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)showItemNearIndexPath:(NSIndexPath *)indexPath;

- (void)updateSelectionForCurrentVisibleDetailItem;

@end

NS_ASSUME_NONNULL_END
