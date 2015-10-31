//
//  LoginViewController.h
//  gava
//
//  Created by RICHA on 9/5/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignupViewController.h"
#import "ForgotPswdViewController.h"
#import "IOSRequest.h"
#import <MMMaterialDesignSpinner.h>
#import "Constants.h"
#import "ForgotPswdViewController.h"
#import <SCLAlertView.h>
#import <Facebook-iOS-SDK/FBSDKCoreKit/FBSDKCoreKit.h>
#import <Facebook-iOS-SDK/FBSDKLoginKit/FBSDKLoginKit.h>
#import <Facebook-iOS-SDK/FBSDKShareKit/FBSDKShareKit.h>
#import "AppDelegate.h"
#import "AlertView.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UITextField *tf_email;
@property (strong, nonatomic) IBOutlet UITextField *tf_pswd;
@property (strong, nonatomic) IBOutlet UIButton *btn_login;
- (IBAction)btn_login_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_signUp;
- (IBAction)btn_SignUp_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_fbLogin;
- (IBAction)btn_fbLogin_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_fPswd;
- (IBAction)btn_fPswd_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_back;
- (IBAction)btn_back_pressed:(id)sender;


/*!
 *  @brief These are to store facebook details like id,email,name,dob
 */
@property(nonatomic,retain)NSString *fb_id;
@property(nonatomic,retain)NSString* fb_email;
@property(nonatomic,retain)NSString* fb_name;
@property(nonatomic,retain)NSString* fb_dob;
@end
