//
//  MUIExternalWebActivity.m
//  Simple RSS Reader
//
//  Created by marek on 11/01/2013.
//  Copyright (c) 2013 Malc and Marek. All rights reserved.
//

#import "MUIExternalWebActivity.h"
//#import "Reachability.h"

@implementation MUIExternalWebActivity

- (NSString *)activityType {
    return @"Web";
}

- (NSString *)activityTitle {
    return @"Web Browser";
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"safarishare"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
//    if (![Reachability reachabilityForInternetConnection].currentReachabilityStatus) {
//        return NO;
//    }
    for (id ai in activityItems) {
        if ([ai isKindOfClass:[NSURL class]]) {
            return YES;
        }
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
//    if (![Reachability reachabilityForInternetConnection].currentReachabilityStatus) {
//        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Web Unavailable" message:@"This action is only available when an internet connection is available" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
//        [av show];
//    }
    for (id ai in activityItems) {
        if ([ai isKindOfClass:[NSURL class]]) {
            [[UIApplication sharedApplication] openURL:ai];
        }
    }
}

@end
