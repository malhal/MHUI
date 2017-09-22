//
//  ICLongRunningTaskController.m
//  MUIKit
//
//  Created by Malcolm Hall on 22/09/2017.
//  Copyright © 2017 Malcolm Hall. All rights reserved.
//

#import "MUILongRunningTaskController.h"

static void * const kMUILongRunningTaskControllerKVOContext = (void*)&kMUILongRunningTaskControllerKVOContext;

@implementation MUILongRunningTaskController

- (void)closeProgressDialog{
    if(self.progressViewController){
        return;
    }
    self.progressViewController.progressDelegate = nil;
    UIViewController *presentingViewController = self.progressViewController.presentingViewController;
    self.progressViewController = nil;
    if(self.progressViewControllerDidFinishPresenting){
        [presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        self.shouldDismissProgressViewController = YES;
    }
}

- (void)completeTaskIfNecessary{
    if(self.completionBlock){
        self.completionBlock(self.isCancelled);
        self.completionBlock = nil;
    }
    if(self.progress){
        if(self.openProgressDate){
            NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.openProgressDate];
            if(interval < 0.0){
                [NSThread sleepForTimeInterval:-interval];
            }
            [self closeProgressDialog];
            self.openProgressDate = nil;
        }
        [self.progress removeObserver:self forKeyPath:@"fractionCompleted"];
        self.progress = nil;
    }
    self.keepAlive = nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if(context != kMUILongRunningTaskControllerKVOContext){
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateProgress];
    });
}

- (void)openProgressDialog{
    
}

- (void)startTask:(void (^)(NSProgress *progress))progressBlock completionBlock:(void (^)(BOOL cancelled))completionBlock{
    self.keepAlive = self;
    self.completionBlock = completionBlock;
    NSProgress *progress = [[NSProgress alloc] initWithParent:nil userInfo:nil];
    self.progress = progress;
    [progress addObserver:self forKeyPath:@"fractionCompleted" options:0 context:kMUILongRunningTaskControllerKVOContext];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        progressBlock(progress);
        dispatch_semaphore_signal(semaphore);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self completeTaskIfNecessary];
        });
    });
    
    if(dispatch_semaphore_wait(semaphore, dispatch_time(0, self.intervalBeforeOpeningProgressDialog))){
        if(self.progress.totalUnitCount != 1){
            self.openProgressDate = [NSDate date];
            [self openProgressDialog];
        }
    }
}

// todo
- (void)updateProgress{
    
}

- (void)willDismissProgressViewController:(MUIProgressViewController *)pvc{
    [self.progress cancel];
}

@end
