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

@protocol MUITableViewDelegate;

@interface UITableView (MUI)

@property (nonatomic, weak, nullable) id <MUITableViewDelegate> delegate;

@end

@protocol MUITableViewDelegate <UITableViewDelegate>

@optional
- (void)tableView:(UITableView *)tableView didUpdateTextFieldForRowAtIndexPath:(NSIndexPath *)indexPath withValue:(NSString *)value;
- (void)tableViewDidFinishReload:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
