//
//  MUIDetailNavigationController.h
//  MUIKit
//
//  Created by Malcolm Hall on 16/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface MUIDetailNavigationController : UINavigationController

@property (strong, nonatomic) id detailObject;

@end

@interface UIViewController (MUIDetailNavigationController)

@property (strong, nonatomic, readonly) MUIDetailNavigationController *mui_detailNavigationController;

@end


NS_ASSUME_NONNULL_END
