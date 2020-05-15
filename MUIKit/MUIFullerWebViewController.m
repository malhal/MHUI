//
//  DLFullerWebViewController.m
//  Simple RSS Reader
//
//  Created by marek on 07/01/2013.
//  Copyright (c) 2013 Malc and Marek. All rights reserved.
//

#import "MUIFullerWebViewController.h"
#import "MUIExternalWebActivity.h"
#import <MessageUI/MessageUI.h>
//#import "NetworkActivityIndicatorController.h"
//#import "MFMailComposeViewController+ForcedStaticSubjectAndBody.h"

@interface MUIFullerWebViewController () <UIWebViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;

@property (weak, nonatomic) IBOutlet UIButton *exitFullscreenButton;
@property (weak, nonatomic) IBOutlet UIButton *backFullscreenButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardFullscreenButton;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *shareButton;

@property int loadingCount;
@property BOOL stopping;

@end

@implementation MUIFullerWebViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    }
}

#pragma mark - Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.delegate = self;
    self.navigationController.toolbarHidden = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.loadingCount = 0;
    [self.webView loadRequest:self.initialRequest];
    [self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
//    if(self.webView.isLoading){
//        [self.webView stopLoading];
//        //[[NetworkActivityIndicatorController sharedNetworkActivityIndicatorController] stopNetworkActivity];
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        NSLog(@"Loading");
//    } else {
//        NSLog(@"Not loading");
//    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.webView.isLoading) {
        [self.webView stopLoading];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"GOT IT IN THE VIEWDIDDISAPPEAR!!");
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    NSComparisonResult order = [[UIDevice currentDevice].systemVersion compare: @"6.0" options: NSNumericSearch];
    if (order == NSOrderedSame || order == NSOrderedDescending) {
        // no bug, so do nothing
        [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    } else {
        CGFloat ratioAspect = self.webView.bounds.size.width/self.webView.bounds.size.height;
        switch (toInterfaceOrientation) {
            case UIInterfaceOrientationPortraitUpsideDown:
            case UIInterfaceOrientationPortrait:
                // Going to Portrait mode
                for (UIScrollView *scroll in [self.webView subviews]) { //we get the scrollview
                    // Make sure it really is a scroll view and reset the zoom scale.
                    if ([scroll respondsToSelector:@selector(setZoomScale:)]){
                        scroll.minimumZoomScale = scroll.minimumZoomScale/ratioAspect;
                        scroll.maximumZoomScale = scroll.maximumZoomScale/ratioAspect;
                        [scroll setZoomScale:(scroll.zoomScale/ratioAspect) animated:YES];
                    }
                }
                break;
            default:
                // Going to Landscape mode
                for (UIScrollView *scroll in [self.webView subviews]) { //we get the scrollview
                    // Make sure it really is a scroll view and reset the zoom scale.
                    if ([scroll respondsToSelector:@selector(setZoomScale:)]){
                        scroll.minimumZoomScale = scroll.minimumZoomScale *ratioAspect;
                        scroll.maximumZoomScale = scroll.maximumZoomScale *ratioAspect;
                        [scroll setZoomScale:(scroll.zoomScale*ratioAspect) animated:YES];
                    }
                }
                break;
        }
    }
}

#pragma mark - UI

- (void)updateUI {
    BOOL shareOn = ![_initialRequest.URL isFileURL];
    if (shareOn) {
        if (![self.toolbarItems containsObject:_shareButton]) {
            NSMutableArray *mar = [NSMutableArray arrayWithArray:self.toolbarItems];
            [mar insertObject:_shareButton atIndex:2];
            self.toolbarItems = mar;
        }
    } else {
        if ([self.toolbarItems containsObject:_shareButton]) {
            NSMutableArray *mar = [NSMutableArray arrayWithArray:self.toolbarItems];
            [mar removeObject:_shareButton];
            self.toolbarItems = mar;
        }
    }
    
    _shareButton.enabled = shareOn;
    if (!shareOn) {
        [_shareButton setImage:nil];
    }
    
    self.backButton.enabled = self.webView.canGoBack;
    self.forwardButton.enabled = self.webView.canGoForward;
    
    if (self.navigationController.navigationBarHidden) {
        self.backFullscreenButton.hidden = !self.webView.canGoBack;
        self.forwardFullscreenButton.hidden = !self.webView.canGoForward;
        self.exitFullscreenButton.hidden = NO;
        [UIView animateWithDuration:0.25 animations:^{
            self.backFullscreenButton.alpha = self.forwardFullscreenButton.alpha = self.exitFullscreenButton.alpha = 1.0f;
        }];
    } else {
        self.backFullscreenButton.hidden = self.forwardFullscreenButton.hidden = self.exitFullscreenButton.hidden = YES;
        [UIView animateWithDuration:0.25 animations:^{
            self.backFullscreenButton.alpha = self.forwardFullscreenButton.alpha = self.exitFullscreenButton.alpha = 0.0f;
        }];
    }
    
    NSLog(@"Current loading count: %d", self.loadingCount);
    if (self.loadingCount > 0 /* self.webView.isLoading*/) {
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stopBrowser:)];
        self.navigationItem.rightBarButtonItem = bbi;
    } else {
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload:)];
        self.navigationItem.rightBarButtonItem = bbi;
    }
}

#pragma mark - Actions

- (IBAction)toggleNifty:(id)sender {
    if (self.navigationController.navigationBarHidden) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self.navigationController setToolbarHidden:NO animated:YES];
    } else {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [self.navigationController setToolbarHidden:YES animated:YES];
    }
    [self updateUI];
}

- (IBAction)webOpen:(id)sender {
    [[UIApplication sharedApplication] openURL:self.webView.request.URL];
}

- (IBAction)back:(id)sender {
    [self.webView goBack];
}

- (IBAction)forward:(id)sender {
    [self.webView goForward];
}

- (IBAction)reload:(id)sender {
    NSLog(@"RELOAD");
    self.loadingCount = 0;
    [self.webView reload];
}

- (IBAction)stopBrowser:(id)sender {
    NSLog(@"STOP");
    self.stopping = YES;
    [self.webView stopLoading];
    self.loadingCount = 0;
    [self updateUI];
}

- (IBAction)share:(id)sender {
    //    UIImage *imageToShare = nil;[UIImage imageNamed:@"salmantiger.jpeg"];
    NSURL *url = self.webView.request.URL.absoluteString.length ? self.webView.request.URL : self.initialRequest.URL;
    NSLog(@"%@", url);
    
//    int majorVersion = [[UIDevice currentDevice].systemVersion intValue];
//    if(majorVersion > 5){
        NSArray *activityItems = self.navigationItem.title != nil ? @[url, self.navigationItem.title] : @[url];

//        [MFMailComposeViewController setStaticSubject:self.navigationItem.title];
        MUIExternalWebActivity *ewa = [[MUIExternalWebActivity alloc] init];
        
        NSArray *applicationActivities = @[ewa];
        UIActivityViewController *activityVC =
        [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                          applicationActivities:applicationActivities];
        activityVC.completionHandler = ^(NSString *activityType, BOOL completed) {
//            [MFMailComposeViewController setStaticSubject:nil];
//            [MFMailComposeViewController setStaticBody:nil];
        };
        [self presentViewController:activityVC animated:YES completion:nil];
//    }else{
//        UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Open in Web", @"Mail", @"Tweet", @"Message", nil];
//        [as showFromToolbar:self.navigationController.toolbar];
//    }
}

//#pragma mark - UIActionSheet Delegate
//
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
//    if ([title rangeOfString:@"web" options:NSCaseInsensitiveSearch].location != NSNotFound) {
//        [[UIApplication sharedApplication] openURL:self.webView.request.URL];
//    } else if ([title rangeOfString:@"mail" options:NSCaseInsensitiveSearch].location != NSNotFound) {
//        MFMailComposeViewController *mcvc = [[MFMailComposeViewController alloc] init];
//        [mcvc setMessageBody:self.webView.request.URL.absoluteString isHTML:NO];
//        [mcvc setSubject:self.navigationItem.title];
//        [mcvc setMailComposeDelegate:self];
//        [self presentViewController:mcvc animated:YES completion:nil];
//    } else if ([title rangeOfString:@"tweet" options:NSCaseInsensitiveSearch].location != NSNotFound) {
//        TWTweetComposeViewController *tcvc = [[TWTweetComposeViewController alloc] init];
//        [tcvc addURL:self.webView.request.URL];
//        [tcvc setInitialText:self.navigationItem.title];
//        [self presentViewController:tcvc animated:YES completion:nil];
//    } else if ([title rangeOfString:@"message" options:NSCaseInsensitiveSearch].location != NSNotFound) {
//        MFMessageComposeViewController *mcvc = [[MFMessageComposeViewController alloc] init];
//        mcvc.body = self.webView.request.URL.absoluteString;
//        [mcvc setMessageComposeDelegate:self];
//        [self presentViewController:mcvc animated:YES completion:nil];
//    }
//}

#pragma mark - MFMailCompose Delegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)resul {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    switch (navigationType) {
        case UIWebViewNavigationTypeLinkClicked:
        case UIWebViewNavigationTypeReload:
            self.loadingCount = 0;
            self.stopping = NO;
            break;
        case UIWebViewNavigationTypeOther:
            if (self.stopping) {
                return NO;
            }
            break;
        default:
            break;
    }
    
    if ([[request.URL absoluteString] hasPrefix:@"sms:"]) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    
    if ([[request.URL absoluteString] hasPrefix:@"http://www.youtube.com/v/"] ||
        [[request.URL absoluteString] hasPrefix:@"http://itunes.apple.com/"] ||
        [[request.URL absoluteString] hasPrefix:@"http://phobos.apple.com/"]) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    
//    NSLog(@"%@", request);
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
    self.loadingCount++;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateUI];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.loadingCount--;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateUI];
    NSString *pageTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.title = pageTitle;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateUI];
    
    // To avoid getting an error alert when you click on a link
    // before a request has finished loading.
    if ([error code] == NSURLErrorCancelled) {
        return;
    }
    
    self.loadingCount--;
    
    // Show error alert
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Could not load page", nil)
                                                    message:error.localizedDescription
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:NSLocalizedString(@"Dismiss", nil), nil];
	[alert show];
}

@end
