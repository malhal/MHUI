//
//  UIResponder+MUI.h
//  MUIKit
//
//  Created by Malcolm Hall on 13/09/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (MUI)

- (__kindof UIViewController *)mui_viewController;

//- (__kindof NSPersistentContainer *)mui_persistentContainer;

@end

NS_ASSUME_NONNULL_END
