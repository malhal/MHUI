//
//  DLIdentifier.h
//  WiFiFoFum Nearby
//
//  Created by marek on 24/07/2013.
//  Copyright (c) 2013 Dynamically Loaded. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (MUI)

// should this even be cached?
- (NSString *)mui_cachedIdentifierForVendor;

@end

NS_ASSUME_NONNULL_END
