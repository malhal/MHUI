//
//  MUIObjectDataSource.h
//  MUIKit
//
//  Created by Malcolm Hall on 17/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MUIObjectDataSourceDelegate;
@class MUITableViewController;

@interface MUIObjectDataSource : NSObject <UITableViewDataSource>

@property (weak, nonatomic) id<MUIObjectDataSourceDelegate> delegate;

- (void)configureCell:(UITableViewCell *)cell withObject:(id)object;

@property (weak, nonatomic, readonly) MUITableViewController *tableViewController;

- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)indexPathForObject:(id)object;

//@property (strong, nonatomic) MUISelectionManager *selectionManager;

@end

@protocol MUIObjectDataSourceDelegate <NSObject>

- (void)objectDataSource:(MUIObjectDataSource *)objectDataSource configureCell:(nullable UITableViewCell *)cell withObject:(id)object;

@end

NS_ASSUME_NONNULL_END
