//
//  UIView+MUI.m
//  MUIKit
//
//  Created by Malcolm Hall on 08/01/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "UIView+MUI.h"

@implementation UIView (MUI)

-(void)mui_setHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
    if (!animated) {
        self.hidden = hidden;
    }
    else if (self.hidden != hidden) {
        [UIView transitionWithView:self
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            self.hidden = hidden;
                        }
                        completion:completion];
    }
}

-(UIVisualEffectView*)mui_createBlurredBackgroundView{
    UIVisualEffectView* v = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    v.frame = self.frame;
    v.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    return v;
}

-(void)mui_transitionSlide:(MHViewAnimationTransitionSlide)transitionSlide completion:(void (^ __nullable)(BOOL finished))completion{
    CGAffineTransform onscreen = CGAffineTransformIdentity;
    CGAffineTransform offscreen;
    switch (transitionSlide) {
        case MHViewAnimationTransitionSlideToFromLeft:
            offscreen = CGAffineTransformMakeTranslation(-self.bounds.size.width, 0);
            break;
        case MHViewAnimationTransitionSlideToFromRight:
            offscreen = CGAffineTransformMakeTranslation(self.bounds.size.width, 0);
            break;
        case MHViewAnimationTransitionSlideToFromTop:
            offscreen = CGAffineTransformMakeTranslation(0, -self.bounds.size.height);
            break;
        case MHViewAnimationTransitionSlideToFromBottom:
            offscreen = CGAffineTransformMakeTranslation(0, self.bounds.size.height);
            break;
        default:
            if(completion){
                completion(NO);
            }
            return;
    }
    
    BOOL hide = NO;
    // if visible and in onscreen position or heading towards onscreen.
    if(!self.hidden && CGAffineTransformEqualToTransform(self.transform, onscreen)){
        hide = YES;
    }else{
        self.hidden = NO;
        self.transform = offscreen;
    }
    [UIView animateWithDuration:0.4
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:(void (^)(void)) ^{
                         self.transform = hide ? offscreen : onscreen;
                     }
                     completion:^(BOOL finished){
                         // workaround or finished always true on iOS 9.
                         CALayer* layer = self.layer.presentationLayer;
                         // find the transforms current position in the animation.
                         CGAffineTransform a = layer.affineTransform;
                         BOOL realFinished = NO;
                         if(hide && CGAffineTransformEqualToTransform(a, offscreen)){
                             // make hidden and return transform to onscreen position in case made unhidden again directly.
                             self.transform = CGAffineTransformIdentity;
                             self.hidden = YES;
                             realFinished = YES;
                         }
                         else if(!hide && CGAffineTransformEqualToTransform(a, onscreen)){
                             realFinished = YES;
                         }
                         if(completion){
                             completion(realFinished);
                         }
                     }];
}

@end
