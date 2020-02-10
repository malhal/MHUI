//
//  MUIAnimationFixStoryboardSegue.h
//  RootMasterDetail
//
//  Created by Malcolm Hall on 07/11/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//
// Fixes that UIStoryboardSegueTemplate _performWithDestinationViewController enables animations based on the animates
// checkbox regardless if animations are currently disabled.

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface MUIAnimationFixStoryboardSegue : UIStoryboardSegue

@end

NS_ASSUME_NONNULL_END
