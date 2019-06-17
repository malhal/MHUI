//
//  MUISelectionManager.h
//  MUIKit
//
//  Created by Malcolm Hall on 17/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <MUIKit/MUIDefines.h>
#import <MUIKit/MUITableView.h>
//#import <MUIKit/MUIObjectDataSource.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MUISelectionManagerDelegate;
@class MUIObjectDataSource;

@interface MUISelectionManager : NSObject <MUITableViewDelegate>

@property (strong, nonatomic, readonly) id selectedObject;

- (void)selectObject:(id)object;

//@property (weak, nonatomic) id<UITableViewDelegate> tableViewDelegate;

// allow changing of table view controller?
//- (instancetype)initWithTableViewController:(TableViewController *)tableViewController;

//- (instancetype)initWithFetchedDataSource:(FetchedDataSource *)fetchedDataSource;
//TableChangeManager
- (void)reselectTableRowIfNecessary;

@property (weak, nonatomic, readonly) MUIObjectDataSource *objectDataSource;

@property (weak, nonatomic) id<MUISelectionManagerDelegate> delegate;

@end

@protocol MUISelectionManagerDelegate <NSObject>

//- (id)selectedObjectForSelectionManager:(SelectionManager *)selectionManager;

- (void)selectionManager:(MUISelectionManager *)selectionManager didSelectObject:(id)object;

@end

NS_ASSUME_NONNULL_END
