//
//  UIImage+MUI.h
//  MUIKit
//
//  Created by Malcolm Hall on 14/02/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (MUI)

+ (UIImage *)mui_imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;

@end

NS_ASSUME_NONNULL_END
