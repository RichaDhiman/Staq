//
//  TermsConditons&RedemptionViewController.h
//  gava
//
//  Created by RICHA on 9/29/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"
#import "CardDetails.h"
#import "Constants.h"
#import "IOSRequest.h"
#import <SCLAlertView.h>
#import "AppDelegate.h"

@interface TermsConditons_RedemptionViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *btn_close;

- (IBAction)btn_close_pressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIWebView *myWebView;


@property(nonatomic,retain)NSString* brand_id;

@property(nonatomic)BOOL show_TermCondi;
@property(nonatomic,retain)NSString* navtitle;
@property (strong, nonatomic) IBOutlet UILabel *lbl_nav_title;

@end
