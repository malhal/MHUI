//
//  DetailNavigationController.h
//  MUIKit
//
//  Created by Malcolm Hall on 12/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MUIDetailNavigationController : UINavigationController

//@property (strong, nonatomic, readonly) UIBarButtonItem *nextDetailButtonItem;
//@property (strong, nonatomic, readonly) UIBarButtonItem *previousDetailButtonItem;

@end

@interface UIViewController (MUIDetailNavigationController)

@property (strong, nonatomic, readonly) MUIDetailNavigationController *mui_detailNavigationController;

@end

NS_ASSUME_NONNULL_END
