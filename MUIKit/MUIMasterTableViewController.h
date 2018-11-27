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
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MUIMasterTableViewControllerDelegate, MUIMasterTableViewControllerDelegate;

@interface MUIMasterTableViewController : UITableViewController <UITableViewDelegate>

@property (nonatomic, assign) id<MUIMasterTableViewControllerDelegate> delegate;

@property (strong, nonatomic, readonly) id selectedMasterItem;

- (void)updateSelectionForCurrentSelectedMasterItem;

// call after deleting
- (NSIndexPath *)indexPathNearIndexPath:(NSIndexPath *)indexPath;

// Can be overridden but the default implementation performs the showDetail segue with self as the sender. In prepareForSegue check sender and in this case use self.selectedMasterItem.
//- (void)showDetailViewControllerForSelectedMasterItem;

- (void)selectMasterItem:(id)masterItem;

// if notify is true then didSelectMasterItem is called.
- (void)selectMasterItem:(id)masterItem notify:(BOOL)notify;

// show the detail controller if necessary not collapsed.
- (void)didSelectMasterItem;

// sets the selectedMasterItem using the current detail controller's item.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;

@end


@protocol MUIMasterTableViewControllerDelegate <NSObject>

@optional

- (NSIndexPath *)masterTableViewController:(MUIMasterTableViewController *)masterTableViewController indexPathForMasterItem:(id)masterItem;

- (id)masterTableViewController:(MUIMasterTableViewController *)masterTableViewController masterItemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
