//
//  SignupViewController.h
//  gava
//
//  Created by RICHA on 9/4/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IOSRequest.h"
#import "LoginViewController.h"
#import "SignupViewController.h"
#import "Constants.h"
#import "MainViewController.h"
#import "UserProfile.h"
#import <SCLAlertView.h>
#import <SCLAlertView.h>
#import "AppDelegate.h"
#import "AlertView.h"

@interface SignupViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *tf_firstName;
@property (strong, nonatomic) IBOutlet UITextField *tf_lastName;

@property (strong, nonatomic) IBOutlet UITextField *tf_email;

@property (strong, nonatomic) IBOutlet UITextField *tf_pswd;
@property (strong, nonatomic) IBOutlet UIButton *btn_signUp;

- (IBAction)btn_signup_pressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn_login;
- (IBAction)btn_login_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *my_scrollView;
@property (strong, nonatomic) IBOutlet UIButton *btn_back;
- (IBAction)btn_back_pressed:(id)sender;


@end
