//
//  TableView.h
//  CloudEvents
//
//  Created by Malcolm Hall on 11/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@class MUITableView;

@protocol MUITableViewDelegate <UITableViewDelegate>

@optional
- (void)tableViewDidEndEditing:(MUITableView *)tableView;

@end

@interface MUITableView : UITableView

@property (weak, nonatomic) id<MUITableViewDelegate> delegate;

@end


NS_ASSUME_NONNULL_END
