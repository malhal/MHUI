//
//  UIImage+MUI.m
//  MUIKit
//
//  Created by Malcolm Hall on 14/02/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "UIImage+MUI.h"

@implementation UIImage (MUI)

// todo watch check
+ (UIImage *)mui_imageNamed:(NSString *)name inBundle:(NSBundle *)bundle{
    UITraitCollection *tc;
    // if(!UIDevice.mui_isWatchCompanion && !UIDevice.mui_isWatch)
    tc = UIScreen.mainScreen.traitCollection;
    return [self imageNamed:name inBundle:bundle compatibleWithTraitCollection:tc];
}

@end

