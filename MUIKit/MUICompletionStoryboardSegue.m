//
//  MUICompletionStoryboardSegue.m
//  MUIKit
//
//  Created by Malcolm Hall on 20/09/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MUICompletionStoryboardSegue.h"

@implementation MUICompletionStoryboardSegue

- (void)perform{
    [super perform];
    if(!self.completion){
        return;
    }
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.destinationViewController.transitionCoordinator;
    if(!transitionCoordinator){
        self.completion();
        return;
    }
    [self.destinationViewController.transitionCoordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        if(!context.isCancelled){
          self.completion();
        }
    }];
}

@end
