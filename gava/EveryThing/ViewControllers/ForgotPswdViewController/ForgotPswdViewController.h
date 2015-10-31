//
//  ForgotPswdViewController.h
//  gava
//
//  Created by RICHA on 9/4/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SCLAlertView.h> 
#import "IOSRequest.h"
#import "Constants.h"
#import <MMMaterialDesignSpinner.h>
#import "AppDelegate.h"
#import "AlertView.h"

@interface ForgotPswdViewController : UIViewController

- (IBAction)btn_back_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_back;
@property (strong, nonatomic) IBOutlet UIButton *btn_close;
- (IBAction)btn_close_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lbl_msgShow;
@property (strong, nonatomic) IBOutlet UIButton *btn_done;
- (IBAction)btn_done_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *tf_email;
@property (strong, nonatomic) IBOutlet UILabel *lbl_confirmationMsg;
@property (strong, nonatomic) IBOutlet UIView *view_email;

@end
