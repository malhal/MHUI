//
//  MUISecondaryItemController.h
//  MUIKit
//
//  Created by Malcolm Hall on 05/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const MUISecondaryItemControllerItemDidChangeNotification;

@interface MUISecondaryItemController : NSObject <UISplitViewControllerDelegate>

@property (strong, nonatomic, nullable) id item;

@property (strong, nonatomic) UISplitViewController *splitViewController;

- (instancetype)initWithSplitViewController:(UISplitViewController *)splitViewController;

@end

@interface UISplitViewController (MUISecondaryItemController)

@property (weak, nonatomic) MUISecondaryItemController *secondaryItemController;

@end

NS_ASSUME_NONNULL_END
