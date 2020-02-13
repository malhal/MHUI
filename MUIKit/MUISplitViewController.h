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

extern NSString * const UIViewControllerCurrentDetailModelIdentifierDidChangeNotification;

@interface MUISplitViewController : UISplitViewController

//@property (strong, nonatomic, readonly) __kindof UIViewController *detailViewController;

@end

@interface UIViewController (MUISplitViewController)

@property (strong, nonatomic, setter=mui_setDetailModelIdentifier:) NSString *mui_detailModelIdentifier;

@property (strong, nonatomic, readonly) MUISplitViewController *mui_splitViewController;

@property (copy, nonatomic, readonly) NSString *mui_currentDetailModelIdentifier;





@end

NS_ASSUME_NONNULL_END
