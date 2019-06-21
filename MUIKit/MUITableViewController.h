//
//  MUITableViewController.h
//  MUIKit
//
//  Created by Malcolm Hall on 05/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <MHFoundation/MHFoundation.h>
#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>
//#import <MUIKit/MUIFetchedDataSource.h>
#import <MUIKit/MUITableView.h>
#import <MUIKit/MUIObjectDataSource.h>
//#import <MUIKit/MUISelectionManager.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MUITableViewControllerDelegate;//, MUITableViewControllerDataSource;

@interface MUITableViewController : UITableViewController <MUIObjectDataSourceDelegate>

// override, default implementation does nothing.
//- (void)tableViewDidEndEditing;

// calls tableViewDidEndEditing after the animations end, so table rows can be reselected.
- (void)setEditing:(BOOL)editing animated:(BOOL)animated NS_REQUIRES_SUPER;

// disables the edit button
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;

// enables the edit button and delay invokes tableViewDidEndEditing
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath NS_REQUIRES_SUPER;

@property (assign, nonatomic) id<MUITableViewDelegate> tableViewDelegate;

@property (assign, nonatomic) id<MUITableViewControllerDelegate> delegate;

//@property (strong, nonatomic) MUISelectionManager *selectionManager;

//@property (assign, nonatomic) id<UITableViewDataSource> dataSource;
@property (strong, nonatomic) MUIObjectDataSource *dataSource;

@property (strong, nonatomic, readonly) id selectedObject;
- (void)selectObject:(id)object;
- (void)selectObject:(id)object notifyDelegate:(BOOL)notifyDelegate;
- (void)didSelect:(id)object;
- (void)reselectTableRowIfNecessary;
- (void)reselectTableRowIfNecessaryScrollToSelection:(BOOL)scrollToSelection;

@property (assign, nonatomic) BOOL isMasterViewController;

- (BOOL)shouldSelectObject;

@end

@protocol MUITableViewControllerDelegate <NSObject>

//- (void)tableViewController:(MUITableViewController *)tableViewController viewDidAppear:(BOOL)animated;
//- (void)tableViewController:(MUITableViewController *)tableViewController viewWillAppear:(BOOL)animated;
//- (void)tableViewController:(MUITableViewController *)tableViewController viewWillDisappear:(BOOL)animated;
//- (void)tableViewControllerViewDidLoad:(MUITableViewController *)tableViewController;
//- (void)tableViewControllerDidEndEditing:(MUITableViewController *)tableViewController;

// so that a popped master can have access to the split controller.
// another way could be to set self weak on the detail controller given I don't need a new method its just getting access to the parent.
- (UIViewController *)showDetailTargetForTableViewController:(MUITableViewController *)tableViewController;

@end

//@protocol MUITableViewControllerDataSource <UITableViewDataSource>

//- (id)masterViewController:(MasterViewController *)masterViewController objectAtIndexPath:(NSIndexPath *)indexPath;
//- (void)masterViewController:(MasterViewController *)masterViewController didLoadTableView:(UITableView *)tableView;

//@end

NS_ASSUME_NONNULL_END
