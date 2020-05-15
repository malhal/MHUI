//
//  DLIdentifier.m
//  WiFiFoFum Nearby
//
//  Created by marek on 24/07/2013.
//  Copyright (c) 2013 Dynamically Loaded. All rights reserved.
//

#import "UIDevice+MUI.h"

@implementation UIDevice (MUI)

// because the inbuilt identifier for vender can be nil if you try to get it in the background or in some other cases this method
// will store it into userdefaults as soon as it is not nil. That way we can subsequently access it whenever we like.

//BUT it will be lost of they uninstall and install again, unless there is another DL app installed.
//Even if they have another DL app if they restore a backup to a new device if they uninstall and install again it will be lost.
- (NSString *)mui_cachedIdentifierForVendor{
    static NSString * const key = @"MUIIdentifierForVender";
    NSString *identifier = [NSUserDefaults.standardUserDefaults objectForKey:key];
    if (identifier == nil) {
        identifier = UIDevice.currentDevice.identifierForVendor.UUIDString;
        if (identifier) {
            [NSUserDefaults.standardUserDefaults setObject:identifier forKey:key];
            [NSUserDefaults.standardUserDefaults synchronize];
        }
    }
    #warning SO what if its nil the first time?? We need a loop
    return identifier;
}

@end
