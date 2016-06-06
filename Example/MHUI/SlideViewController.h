//
//  ViewController.h
//  SlideViewAnimation
//
//  Created by Malcolm Hall on 18/04/2016
//  Copyright (c) 2016 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideViewController : UIViewController{
    
}
@property (strong, nonatomic) IBOutlet UIView *RectView;
- (IBAction)animateRight:(id)sender;
- (IBAction)animateLeft:(id)sender;
- (IBAction)animateDown:(id)sender;
- (IBAction)animateUp:(id)sender;

@end
