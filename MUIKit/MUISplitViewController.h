//
//  MUISplitViewController.h
//  BigSplit
//
//  Created by Malcolm Hall on 21/08/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MHFoundation/MHFoundation.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@class MUIMasterItemSplitter;

@interface MUISplitViewController : UISplitViewController

//@property (strong, nonatomic) UIBarButtonItem *threeColumnsButtonItem;

@property (strong, nonatomic, readonly) MUIMasterItemSplitter *masterItemSplitter;

@property (strong, nonatomic, readonly) MUISplitViewController *childSplitController;

@end

NS_ASSUME_NONNULL_END
