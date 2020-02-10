//
//  MUISplitViewController.h
//  MUIKit
//
//  Created by Malcolm Hall on 26/11/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface MUISplitViewController : UISplitViewController

@property (strong, nonatomic, readonly) __kindof UIViewController *detailViewController;

@end

NS_ASSUME_NONNULL_END
