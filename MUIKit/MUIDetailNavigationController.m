//
//  MUIDetailNavigationController.m
//  MUIKit
//
//  Created by Malcolm Hall on 16/06/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MUIDetailNavigationController.h"

@interface MUIDetailNavigationController ()

@end

@implementation MUIDetailNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation UIViewController (MUIDetailNavigationController)

- (MUIDetailNavigationController *)mui_detailNavigationController{
    UINavigationController *nav = self.navigationController;
    if([nav isKindOfClass:MUIDetailNavigationController.class]){
        return (MUIDetailNavigationController *)nav;
    }
    return nav.mui_detailNavigationController;
}

@end
