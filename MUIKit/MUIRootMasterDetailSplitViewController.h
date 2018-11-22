//
//  MUIRootMasterDetailSplitViewController.h
//  BigSplit
//
//  Created by Malcolm Hall on 21/08/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface MUIRootMasterDetailSplitViewController : UISplitViewController

@property (strong, nonatomic) UIBarButtonItem *threeColumnsButtonItem;

- (void)changeTraits;

@end

NS_ASSUME_NONNULL_END
