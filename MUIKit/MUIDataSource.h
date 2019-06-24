//
//  MUIDataSource.h
//  MUIKit
//
//  Created by Malcolm Hall on 17/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MUIDataSourceDelegate;
@class MUITableViewController;

@interface MUIDataSource : NSObject <UITableViewDataSource>

@property (weak, nonatomic) id<MUIDataSourceDelegate> delegate;

- (void)configureCell:(UITableViewCell *)cell withObject:(id)object;

@property (weak, nonatomic, readonly) MUITableViewController *tableViewController;

- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)indexPathForObject:(id)object;

- (NSArray *)objects;

//@property (strong, nonatomic) MUISelectionManager *selectionManager;

- (void)registerReuseIdentifier:(NSString *)reuseIdentifier forObjectOfClass:(Class)class;

@end

@protocol MUIDataSourceDelegate <NSObject>

@optional
- (void)objectDataSource:(MUIDataSource *)objectDataSource configureCell:(nullable UITableViewCell *)cell withObject:(id)object;

- (void)objectDataSource:(MUIDataSource *)objectDataSource didDeleteObject:(id)object atIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
