//
//  TermsConditons&RedemptionViewController.m
//  gava
//
//  Created by RICHA on 9/29/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "TermsConditons&RedemptionViewController.h"

@interface TermsConditons_RedemptionViewController ()
@property(nonatomic,retain)AppDelegate *App;
@end

@implementation TermsConditons_RedemptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.App=(AppDelegate*)[UIApplication sharedApplication].delegate;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.App StopAnimating];
    
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.show_TermCondi==YES?[self Load_TermCondi]:[self load_Redemp];
    self.lbl_nav_title.text=self.navtitle;
}

-(void)Load_TermCondi
{
    NSString *url=[NSString stringWithFormat:@"%@/%@",Url_TermCon,self.brand_id];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

-(void)load_Redemp
{
    NSString *url=[NSString stringWithFormat:@"%@/%@",Url_Redemp,self.brand_id];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

#pragma mark-Button Actions

- (IBAction)btn_close_pressed:(id)sender
{
    [self.App StopAnimating];
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark-web view Handling
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
    //    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    //    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    //
    //    if(networkStatus == NotReachable)
    //    {
    //        [alert showStaticAlertWithTitle:nil AndMessage:@"No Internet Error"];
    //    }
    
    [self.App StopAnimating];
}


@end
