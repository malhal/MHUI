//
//  MUICompletionStoryboardSegue.h
//  MUIKit
//
//  Created by Malcolm Hall on 20/09/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface MUICompletionStoryboardSegue : UIStoryboardSegue

@property (nonatomic, copy) void(^completion)(void);

@end

NS_ASSUME_NONNULL_END
