//
//  MUITableViewController.h
//  MUIKit
//
//  Created by Malcolm Hall on 05/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <MHFoundation/MHFoundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MUITableViewControllerDelegate, MUITableViewControllerDataSource;
@class MUIFetchedDataSource;

@interface MUITableViewController : UITableViewController

// override, default implementation does nothing.
//- (void)tableViewDidEndEditing;

// calls tableViewDidEndEditing after the animations end, so table rows can be reselected.
- (void)setEditing:(BOOL)editing animated:(BOOL)animated NS_REQUIRES_SUPER;

// disables the edit button
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;

// enables the edit button and delay invokes tableViewDidEndEditing
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath NS_REQUIRES_SUPER;

@property (assign, nonatomic) id<MUITableViewControllerDelegate> delegate;

//@property (assign, nonatomic) id<UITableViewDataSource> dataSource;
@property (strong, nonatomic) MUIFetchedDataSource *dataSource;

@end

@protocol MUITableViewControllerDelegate <NSObject>

- (void)tableViewControllerViewDidLoad:(MUITableViewController *)tableViewController;

- (void)tableViewControllerDidEndEditing:(MUITableViewController *)tableViewController;

@end

//@protocol MUITableViewControllerDataSource <UITableViewDataSource>

//- (id)masterViewController:(MasterViewController *)masterViewController objectAtIndexPath:(NSIndexPath *)indexPath;

//- (void)masterViewController:(MasterViewController *)masterViewController didLoadTableView:(UITableView *)tableView;

//@end


NS_ASSUME_NONNULL_END
