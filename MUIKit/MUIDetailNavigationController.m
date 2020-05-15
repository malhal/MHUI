//
//  DetailNavigationController.m
//  MUIKit
//
//  Created by Malcolm Hall on 12/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "MUIDetailNavigationController.h"
#import "MUISplitViewController+Private.h"

@interface MUIDetailNavigationController ()

@property (strong, nonatomic, readwrite) UIBarButtonItem *nextDetailButtonItem;
@property (strong, nonatomic, readwrite) UIBarButtonItem *previousDetailButtonItem;

@property (copy, nonatomic) NSString *nextDetailModelIdentifier;
@property (copy, nonatomic) NSString *previousDetailModelIdentifier;

@end

@implementation MUIDetailNavigationController

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
    UIViewController *vc = self.childViewControllers.firstObject;
    vc.mui_detailShowingViewController = self;
    //self.mui_detailShownViewController = vc;
//    self.nextDetailButtonItem = [UIBarButtonItem.alloc initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextDetail:)];
//    self.previousDetailButtonItem = [UIBarButtonItem.alloc initWithTitle:@"Prev" style:UIBarButtonItemStylePlain target:self action:@selector(previousDetail:)];
}

- (UIViewController *)mui_detailShownViewController{
    return self.viewControllers.firstObject;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    //[self configureViewForCurrentDetailModelIdentifier];
    [super viewWillAppear:animated];
}

//- (void)configureViewForCurrentDetailModelIdentifier{
//    NSString *nextIdentifier;
//    NSString *previousIdentifier;
//
//    if([self conformsToProtocol:@protocol(UIDataSourceModelAssociation)]){
//        NSString *currentDetailModelIdentifier = self.mui_currentDetailModelIdentifier;
//        if(currentDetailModelIdentifier){
//            id<UIDataSourceModelAssociation> dataSource = (id<UIDataSourceModelAssociation>)self;
//            NSIndexPath *indexPath = [dataSource indexPathForElementWithModelIdentifier:currentDetailModelIdentifier inView:self.view];
//            if(indexPath){
//                previousIdentifier = [self identifierBeforeIndexPath:indexPath];
//                nextIdentifier = [self identifierAfterIndexPath:indexPath];
//            }
//        }
//    }
//    self.nextDetailModelIdentifier = nextIdentifier;
//    self.previousDetailModelIdentifier = previousIdentifier;
//
//    self.nextDetailButtonItem.enabled = nextIdentifier;
//    self.previousDetailButtonItem.enabled = previousIdentifier;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)previousDetail:(id)sender{
    self.mui_detailModelIdentifier = self.previousDetailModelIdentifier;;
}

- (IBAction)nextDetail:(id)sender{
    self.mui_detailModelIdentifier = self.nextDetailModelIdentifier;
}

- (NSString *)identifierBeforeIndexPath:(NSIndexPath *)indexPath{
    id<UIDataSourceModelAssociation> dataSource = (id<UIDataSourceModelAssociation>)self;
    NSUInteger i = [indexPath indexAtPosition:0];
    i--;
    return [dataSource modelIdentifierForElementAtIndexPath:[NSIndexPath indexPathWithIndex:i] inView:self.view];
}
    
- (NSString *)identifierAfterIndexPath:(NSIndexPath *)indexPath{
    id<UIDataSourceModelAssociation> dataSource = (id<UIDataSourceModelAssociation>)self;
    NSUInteger i = [indexPath indexAtPosition:0];
    i++;
    return [dataSource modelIdentifierForElementAtIndexPath:[NSIndexPath indexPathWithIndex:i] inView:self.view];
}

- (void)showDetailViewController:(UIViewController *)vc sender:(id)sender{
    [self setViewControllers:@[vc] animated:NO];
    vc.mui_detailShowingViewController = self; // so it can update the item
    //self.mui_detailShownViewController = vc;
    
   // [self configureViewForCurrentDetailModelIdentifier];
}

//- (void)viewControllerUpdatedDetailModelIdentifier:(UIViewController *)vc{
//    //self.mui_currentDetailModelIdentifier = vc.mui_detailModelIdentifier;
//    [NSNotificationCenter.defaultCenter postNotificationName:UIViewControllerCurrentDetailModelIdentifierDidChangeNotification object:self];
//}

@end

@implementation UIViewController (MUIDetailNavigationController)

- (MUIDetailNavigationController *)mui_detailNavigationController{
    UINavigationController *nc = self.navigationController;
    if([nc isKindOfClass:MUIDetailNavigationController.class]){
        return (MUIDetailNavigationController *)nc;
    }
    return nc.mui_detailNavigationController;
}


@end
