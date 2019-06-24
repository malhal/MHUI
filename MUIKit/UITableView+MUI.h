//
//  UITableView+MUI.h
//  MUIKit
//
//  Created by Malcolm Hall on 19/01/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UITableViewDelegate_MUI;

@interface UITableView (MUI)

@property (nonatomic, weak, nullable) id <UITableViewDelegate_MUI> delegate;

// returns all the indexPaths in the table.
- (NSArray *)mui_indexPaths;

// for selecting another index after current index is deleted. Either returns same if still availbale or count - 1 if not
// for when the last one was deleted.
- (NSIndexPath *)mui_indexPathNearDeletedIndexPath:(NSIndexPath *)indexPath;

@end

@protocol UITableViewDelegate_MUI <UITableViewDelegate>

@optional
- (void)tableView:(UITableView *)tableView didUpdateTextFieldForRowAtIndexPath:(NSIndexPath *)indexPath withValue:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
