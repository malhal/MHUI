//
//  UIViewController+MHU.h
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 29/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MHUI/MHUDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MHU)

@property (nonatomic, assign, setter=mhu_setLoading:) BOOL mhu_loading;

@end

NS_ASSUME_NONNULL_END