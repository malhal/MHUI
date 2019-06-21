//
//  MUISplitViewController.m
//  BigSplit
//
//  Created by Malcolm Hall on 21/08/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUISplitViewController.h"
#import "UIViewController+MUI.h"
#import "UIViewController+MUIDetail.h"
//#import "MUIDetailItemSplitter.h"
#import "UIView+MUI.h"

#define IS_IPAD_PRO_12_INCH (([UIScreen mainScreen].bounds.size.width == 1366 && [UIScreen mainScreen].bounds.size.height == 1024) || ([UIScreen mainScreen].bounds.size.width == 1024 && [UIScreen mainScreen].bounds.size.height == 1366))

@interface MUISplitViewController()

//@property (copy, nonatomic) UITraitCollection *forcedTraitCollection;

// used for the delegates when is the child split.
//@property (strong, nonatomic, readwrite) MUIMasterItemSplitter *masterItemSplitter;

//@property (strong, nonatomic) MUIRootMasterSplitViewController *rootMasterSplitViewController;
//@property (assign, nonatomic) BOOL largeSplit;

// the overlay fix is needed to allow root row selection to work in the master in overlay.
// something to do with because the split is in a popover it didn't inherit the traits like a nav controller does in a single level split view.
//@property (assign, nonatomic) BOOL overlayFix;
//@property (strong, nonatomic, readonly) UIViewController *masterViewController;
//@property (assign, nonatomic) UIViewController *preservedDetailViewController;

@end

@implementation MUISplitViewController
//@dynamic masterViewController; // private


/*
 

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.largeSplit = YES;
    // Do any additional setup after loading the view.
    //self.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible; // these 3 call view did load so dont do it here
    //UINavigationController *nav = self.viewControllers.firstObject;
    //self.rootMasterSplitViewController = self.viewControllers.firstObject;//nav.topViewController;
    
    if(self.splitViewController){
        UINavigationController *nav = self.parentViewController;
       // nav.navigationBarHidden = YES;
    }
    self.preservedDetailViewController = self.viewControllers[1];
    
    MUISplitViewController* childSplitController = self.childSplitController;
    if(childSplitController){
       // childSplitController.delegate = self.masterItemSplitter;
        //self.detailItemSplitter = [MUIDetailItemSplitter.alloc initWithSplitViewController:childSplitController];
        //self.rootMasterSplitViewController.view.insetsContentViewsToSafeArea = YES;
        CGSize size = self.view.frame.size;
        [self configureColumnsWithSize:size];
        [self configureTraitsWithSize:size];
        [self updateForcedTraitCollection];
    }
}


- (MUISplitViewController *)childSplitController{
    id i = self.viewControllers.firstObject;
    //return i; // sometimes is a nav controller
    return MHFDynamicCast(MUISplitViewController.class, i);
}

// XS hack for landscape overlay, to prevent grey horizontal bar on right side of master table in overlay.
- (void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
    MUISplitViewController* childSplitController = self.childSplitController;
    if(!childSplitController){
        return;
    }
    UIEdgeInsets b = self.view.safeAreaInsets;
    UIEdgeInsets newSafeArea = UIEdgeInsetsZero;
    if(b.left){
        newSafeArea.left = b.left + 15;
    }
    childSplitController.additionalSafeAreaInsets = newSafeArea;
}

// when the outer split changes its viewcontrollers it calls overide which causes the inner split to collapse and expand
// however that is necessary to flag the nav as allowing nested.
// no longer needed because we override it?
// Think it is necessary actually to store the preserved controller so it can be seperated to again.
- (void)setOverrideTraitCollection:(UITraitCollection *)collection forChildViewController:(UIViewController *)childViewController{
    NSLog(@"%@ %@ %@ %@", NSStringFromSelector(_cmd), self, collection, childViewController);
    if(!self.childSplitController){
        [super setOverrideTraitCollection:collection forChildViewController:childViewController];
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    if(!self.childSplitController){
        return;
    }
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self configureColumnsWithSize:size];
        [self configureTraitsWithSize:size];
    }];
}

#pragma mark - Split View Delegate

// when in 3 column with no detail item (but has events list) and dragging on messages on to right.
// and with detail iatem and dragging on messages on to right.
//  YES to throwaway master
//- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
//    id detailItem = self.mui_viewedObject;
//    if(!detailItem){
//        // If our secondary controller doesn't show a detail item, do the collapse ourself by doing nothing
//        return YES;
//    }
//    else if (![secondaryViewController mui_containsViewedObject:detailItem]) {
//        return YES;
//    }
//    return NO;
//}

// This is the inner seperating. called when collapsing from 3 to 1 because traits were changed.
// in from 1 to 3 this needs to be called second to work.
//- (nullable UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController{
//     return nil;
//}

#pragma mark - Split View

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
    super.viewControllers = viewControllers;
    if(!self.childSplitController){
        return;
    }
    [self updateForcedTraitCollection];
}

#pragma mark - Custom Methods

- (void)configureTraitsWithSize:(CGSize)size{
    if(size.width >= 1280){//< 1366){
        self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
    }
    else{
        self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact];
    }
}

- (void)configureColumnsWithSize:(CGSize)size{
    // check if we need to go back to 2 columns from 3
    if(size.width >= 1280){//1366){ // 1280  to allow for other sizes? check ipad mini. Which is 4x320

        // If we are large enough, force a regular size class
        // self.preferredPrimaryColumnWidthFraction = 0.5;
        //rootMasterSplitViewController.preferredPrimaryColumnWidthFraction = 0.5;
        
        self.maximumPrimaryColumnWidth = 640;//320 * 2;//MAXFLOAT;
        self.minimumPrimaryColumnWidth = 640;//320 * 2;
        
        //rootMasterSplitViewController.maximumPrimaryColumnWidth = MAXFLOAT;
        //  self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
    }
    else{
        // Otherwise, compact
        //self.preferredPrimaryColumnWidthFraction = UISplitViewControllerAutomaticDimension;
        //rootMasterSplitViewController.preferredPrimaryColumnWidthFraction = UISplitViewControllerAutomaticDimension;
        
        self.maximumPrimaryColumnWidth = UISplitViewControllerAutomaticDimension;//
        self.minimumPrimaryColumnWidth = UISplitViewControllerAutomaticDimension;
        
        //rootMasterSplitViewController.maximumPrimaryColumnWidth = UISplitViewControllerAutomaticDimension;
        //self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact];
    }
}

- (void)setForcedTraitCollection:(UITraitCollection *)forcedTraitCollection
{
    if (_forcedTraitCollection == forcedTraitCollection) {
        return;
    }
    _forcedTraitCollection = forcedTraitCollection.copy;
    [self updateForcedTraitCollection];
}

- (void)updateForcedTraitCollection
{
    // Use our forcedTraitCollection to override our child's traits
    [super setOverrideTraitCollection:self.forcedTraitCollection forChildViewController:self.childSplitController];
}

#pragma mark - When as a child

//- (NSString *)title{
//    return self.masterViewController.title;
//}

// decides if showDetailViewController should be passed up to the outer split, e.g. if choosing a detail item on the master
// the reason we handle it this way is so the outer split can preserve it. Then it calls show on us and we push it on the master that then handles passing it to a child nav controller.
// we need to pass it up so that the top split will preserve it.
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    //if(!self.childSplitController){
    if(self.splitViewController){
        if(action == @selector(showDetailViewController:sender:)){
            
//            UIView *view = (UIView *)sender;
//            UIViewController *vcc = view.mui_viewController; // RootViewController or MasterViewController
//            UINavigationController *nav = vcc.parentViewController; // RootNavigationController or MasterNavigationController
//            UIViewController *firstChild = self.childViewControllers.firstObject;
//            if(nav != firstChild){
//                return NO;
//            }
            UIViewController *vc = [self childContainingSender:sender];
            // if showDetail came from the detail then we pass it up the chain.
            // if the controller is not our master nav controller then it means it is the detail one
            id i = self.masterViewController;
            if(vc != self.masterViewController){
                return NO; // NO
            }
        }
    }
    return [super canPerformAction:action withSender:sender];
}

- (UIViewController *)childContainingSender:(id)sender{
    // check the detail first because when collapsed the sender will also be in the master's hierarchy.
    UIViewController *vc = self.preservedDetailViewController;
    BOOL b = [sender mui_isMemberOfViewControllerHierarchy:vc];
    if(b){
        return vc;
    }
    vc = self.masterViewController;
    b = [sender mui_isMemberOfViewControllerHierarchy:vc];
    if(b){
        return vc;
    }
    return nil;
}

- (void)showViewController:(UIViewController *)vc sender:(id)sender{
//    UINavigationController *navigationController = [self childContainingSender:sender];
//    NSAssert([navigationController isKindOfClass:UINavigationController.class],@"unexpected class");
//    //[navigationController showViewController:vc sender:sender];
//
//    [self.childSplitController showViewController:vc sender:sender];
    UIViewController *firstChild = self.childViewControllers.firstObject;
    [firstChild showViewController:vc sender:sender];
}



// called when this split is a master in another
// from 3 to 2 or 1 columns
- (void)collapseSecondaryViewController:(UIViewController *)secondaryViewController forSplitViewController:(UISplitViewController *)splitViewController{
    id i = self.masterViewController;
    [self.masterViewController collapseSecondaryViewController:secondaryViewController forSplitViewController:splitViewController];
    //self.preservedDetailViewController = nil;
}

// called when this split is a master in another
// from 1 to 2 or 3 columns
- (nullable UIViewController *)separateSecondaryViewControllerForSplitViewController:(UISplitViewController *)splitViewController{
    UINavigationController *navigationController = (UINavigationController *)self.masterViewController;
    NSArray *viewControllers = navigationController.viewControllers;
    if(viewControllers.count == 2){
        return nil;
    }
    UIViewController *result = [self.masterViewController separateSecondaryViewControllerForSplitViewController:splitViewController];
   // id d = [a topViewController];
   // id e = [b topViewController];
    return result;
}

#pragma mark overlay fix

- (UITraitCollection *)traitCollection{
    UITraitCollection *traitCollection = super.traitCollection;
    if(self.overlayFix){
        traitCollection = [UITraitCollection traitCollectionWithTraitsFromCollections:@[traitCollection, [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact]]];
    }
    return traitCollection;
}

// maybe should check for child in this to optimise
- (void)showDetailViewController:(UIViewController *)vc sender:(id)sender{
    if(self.splitViewController.displayMode == UISplitViewControllerDisplayModePrimaryOverlay){
        self.overlayFix = YES;
    }
    [super showDetailViewController:vc sender:sender];
    self.preservedDetailViewController = vc;
    self.overlayFix = NO;
}
*/

@end

@implementation UIViewController (MUISplitViewController)

- (MUISplitViewController *)mui_splitViewController{
    UISplitViewController *nav = self.splitViewController;
    if([nav isKindOfClass:MUISplitViewController.class]){
        return (MUISplitViewController *)nav;
    }
    return nav.mui_splitViewController;
}

@end
