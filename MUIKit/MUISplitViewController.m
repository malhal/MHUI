//
//  MUISplitViewController.m
//  MUIKit
//
//  Created by Malcolm Hall on 26/11/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MUISplitViewController+Private.h"
#import "UIViewController+MUI.h"
#import <objc/runtime.h>

NSString * const UIViewControllerCurrentDetailModelIdentifierDidChangeNotification = @"UIViewControllerCurrentDetailModelIdentifierDidChangeNotification";

@interface MUISplitViewController ()

@property (strong, nonatomic, setter=mui_setDetailShownViewController:) UIViewController *mui_detailShownViewController;

@end

@interface UIViewController (MUISplitViewController)

@end

@implementation MUISplitViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    //self.childViewControllers.lastObject.showingDetailSplitViewController = self;
    NSAssert(self.childViewControllers.count == 2, @"Needs 2 children");
    UIViewController *vc = self.childViewControllers.lastObject;
    //vc.mui_detailShowingViewController = self;
    _mui_detailShownViewController = vc;
    vc.mui_detailShowingViewController = self;
}

- (void)showDetailViewController:(UIViewController *)vc sender:(id)sender{
    [super showDetailViewController:vc sender:sender];
    //vc.mui_detailShowingViewController = self;
    self.mui_detailShownViewController = vc;
    
}

- (void)mui_setDetailShownViewController:(UIViewController *)vc{
    if(vc == _mui_detailShownViewController){
        return;
    }
    else if(_mui_detailShownViewController.mui_detailShowingViewController == self){
        _mui_detailShownViewController.mui_detailShowingViewController = nil;
    }
    _mui_detailShownViewController = vc;
    vc.mui_detailShowingViewController = self;
    [self mui_viewControllerUpdatedDetailModelIdentifier:vc];
}

@end

@implementation UIViewController (MUISplitViewController)

- (void)mui_viewControllerUpdatedDetailModelIdentifier:(UIViewController *)vc{
    NSString *s = vc.mui_detailModelIdentifier;
    NSDictionary *userInfo;
    if(s){
        userInfo = @{@"DetailModelIdentifier" : s};
    }
    [NSNotificationCenter.defaultCenter postNotificationName:UIViewControllerCurrentDetailModelIdentifierDidChangeNotification object:self userInfo:userInfo];
}

- (NSString *)mui_currentDetailModelIdentifier{
    return self.mui_detailShownViewController.mui_detailModelIdentifier;
}

//- (NSString *)mui_currentDetailModelIdentifier{
//    return objc_getAssociatedObject(self, @selector(mui_currentDetailModelIdentifier));
//}
//
//- (void)mui_setCurrentDetailModelIdentifier:(NSString *)identifier{
//    objc_setAssociatedObject(self, @selector(mui_currentDetailModelIdentifier), identifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}

- (UIViewController *)mui_detailShowingViewController{
    return objc_getAssociatedObject(self, @selector(mui_detailShowingViewController));
}

- (void)mui_setDetailShowingViewController:(MUISplitViewController *)svc{
    //[self willChangeValueForKey:kSplitItemKeyPath];
    if(svc == self.mui_detailShowingViewController){
        return;
    }
    objc_setAssociatedObject(self, @selector(mui_detailShowingViewController), svc, OBJC_ASSOCIATION_ASSIGN);
    //[svc mui_viewControllerUpdatedDetailModelIdentifier:self];
   // [self.showingDetailSplitViewController viewControllerUpdatedDetailModelIdentifier:splitItem];
    //[self didChangeValueForKey:kSplitItemKeyPath];
    //[NSNotificationCenter.defaultCenter postNotificationName:MUISplitViewControllerDidChangeSplitItem object:self userInfo:nil];
}

- (void)mui_setDetailModelIdentifier:(NSString *)identifier{
    if([identifier isEqualToString:self.mui_detailModelIdentifier]){
        return;
    }
    //[self willChangeValueForKey:kSplitItemKeyPath];
    objc_setAssociatedObject(self, @selector(mui_detailModelIdentifier), identifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self.mui_detailShowingViewController mui_viewControllerUpdatedDetailModelIdentifier:self]; // does nothing if not shownDetail yet
   // [self.showingDetailSplitViewController viewControllerUpdatedDetailModelIdentifier:splitItem];
    //[self didChangeValueForKey:kSplitItemKeyPath];
    //[NSNotificationCenter.defaultCenter postNotificationName:MUISplitViewControllerDidChangeSplitItem object:self userInfo:nil];
}

- (NSString *)mui_detailModelIdentifier{
    return objc_getAssociatedObject(self, @selector(mui_detailModelIdentifier));
}

- (MUISplitViewController *)mui_splitViewController{
    UISplitViewController *svc = self.splitViewController;
    if([svc isKindOfClass:MUISplitViewController.class]){
        return (MUISplitViewController *)svc;
    }
    return svc.mui_splitViewController;
}

@end
