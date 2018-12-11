//
//  MUIMasterTableViewController.h
//  MUIKit
//
//  Created by Malcolm Hall on 28/10/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//
// Selection can come from segue or from model changes. Also when in edit mode segues need to be disabled so rather than handle all that its best the table seclection delegate calls same method as the model changes.
#import <MHFoundation/MHFoundation.h>
#import <UIKit/UIKit.h>
#import <MUIKit/MUITableViewController.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MUIMasterTableViewControllerDataSource, MUIMasterTableViewControllerDelegate, MUISecondaryViewController;

@interface MUIMasterTableViewController : MUITableViewController //<UITableViewDelegate>

//@property (nonatomic, assign) id<MUIMasterTableViewControllerDataSource> dataSource;

@property (nonatomic, assign) id<MUIMasterTableViewControllerDelegate> delegate;

//@property (strong, nonatomic) id selectedMasterItem;

// notify will select the table cell and call didSelectMasterItem for showing the view controller.
//- (void)setSelectedMasterItem:(id)selectedMasterItem notify:(BOOL)notify;

//@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

// defaults to self.splitViewController.secondaryItemController
//@property (strong, nonatomic) UIViewController<MUISecondaryViewController> *secondaryViewController;

// the split controller that shows the detail item, defaults to self.splitViewController
//@property (strong, nonatomic) UISplitViewController *detailSplitViewController;

- (void)updateSelectionForCurrentSecondaryItem;

// call after deleting
//- (NSIndexPath *)indexPathNearIndexPath:(NSIndexPath *)indexPath;

// Can be overridden but the default implementation performs the showDetail segue with self as the sender. In prepareForSegue check sender and in this case use self.selectedMasterItem.
//- (void)showDetailViewControllerForSelectedMasterItem;

//- (void)selectMasterItem:(id)masterItem;

// if notify is true then didSelectMasterItem is called.
//- (void)selectMasterItem:(id)masterItem notify:(BOOL)notify;

// show the detail controller if necessary not collapsed. This is not show detail because it might not be the right time to show it in all cases, e.g. if collapsed.


// sets the selectedMasterItem using the current detail controller's item.
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;

@end

@protocol MUISecondaryViewController <NSObject>

@property (strong, nonatomic) id secondaryItem;

@end

@protocol MUIMasterTableViewControllerDelegate <NSObject>
//@required
//- (void)primaryTableViewControllerDidSelectMasterItem:(MUIMasterTableViewController *)primaryTableViewController;

@optional
- (NSIndexPath *)primaryTableViewController:(MUIMasterTableViewController *)primaryTableViewController indexPathForItem:(id)item;

@end

@protocol MUIMasterTableViewControllerDataSource <NSObject>



//- (id)primaryTableViewController:(MUIMasterTableViewController *)primaryTableViewController masterItemAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
