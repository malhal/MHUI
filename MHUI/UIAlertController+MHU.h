//
//  UIAlertController+MHU.h
//  MHUI
//
//  Created by Malcolm Hall on 04/02/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (MHU)

// Gives previous behavior of UIAlertView in that alerts are queued up.
-(void)mhu_show;

@end
