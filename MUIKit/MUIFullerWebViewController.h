//
//  DLFullerWebViewController.h
//  Simple RSS Reader
//
//  Created by marek on 07/01/2013.
//  Copyright (c) 2013 Malc and Marek. All rights reserved.
//

// You need the UI in your storyboard copied form another app like readster or wififofum.

//make a unwind in the controller that presents the controller, e.g.:
//- (IBAction)unwindFromHelp:(UIStoryboardSegue *)unwindSegue{}
//drag from action on the done button to the Exit and choose the unwind method

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface MUIFullerWebViewController : UIViewController // TSMiniWebBrowser... Tried to extend this but TSMiniWebBrowser is REALLY designed to be totally self contained in code with no link to a XIB or Storyboard so all customisation would have to be done in code.  Def think it's easier to stick with a view linked to IB, particularly with a Storyboard in play.  Will copy a few of the useful things like the < iOS 6 rotation bug fix and the youtube opening stuff from the class though.

@property (strong) NSURLRequest *initialRequest;

@end

NS_ASSUME_NONNULL_END
