//
//  MapViewController.m
//  gava
//
//  Created by RICHA on 9/15/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
@property(nonatomic,retain)AppDelegate *App;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ViewHelper];
    self.btn_done.layer.cornerRadius=4;
    self.btn_done.clipsToBounds=YES;
    self.App=(AppDelegate*)[UIApplication sharedApplication].delegate;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.App StopAnimating];
    
    // Dispose of any resources that can be recreated.
}


#pragma mark-ViewHelper
-(void)ViewHelper
{
    
//    NSString* mystr = [NSString stringWithFormat: @"http://maps.apple.com/maps?saddr=Current+Location&daddr=%f,%f",self.Dloc.latitude,self.Dloc.longitude];
    
   // NSString *mystr=[[NSString alloc] initWithFormat:@"http://maps.apple.com/maps?saddr=Current+Location&daddr=Newyork"];
    NSURL *myurl=[[NSURL alloc] initWithString:self.link];
   // [[UIApplication sharedApplication] openURL:myurl];
    [self.mywebview loadRequest:[NSURLRequest requestWithURL:myurl]];
}

#pragma mark-Button Action
- (IBAction)btn_done_pressed:(id)sender {
    [self.App StopAnimating];
    [self.navigationController popViewControllerAnimated:YES];

}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.App StartAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.App StopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog( @"%@",[error description]);
    
    //    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    //    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    //
    //    if(networkStatus == NotReachable)
    //    {
    //        [alert showStaticAlertWithTitle:nil AndMessage:@"No Internet Error"];
    //    }
    //
    [self.App StopAnimating];
}

@end
