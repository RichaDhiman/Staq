//
//  LoginViewController.m
//  gava
//
//  Created by RICHA on 9/5/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewHelper];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*!
 *  @brief   Did everything that i want to do before appearance of viewcontroller
 */
-(void)viewHelper
{
    self.btn_login.layer.cornerRadius=4;
    self.btn_fbLogin.layer.cornerRadius=4;
    self.btn_fbLogin.clipsToBounds=YES;
    self.btn_fbLogin.clipsToBounds=YES;
}

/*!
 *  @brief  To check which should be the next responder
 *
 *  @param textField represent active textfield
 *
 *  @return return NO to ignore
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  (textField==self.tf_email)?[self.tf_pswd becomeFirstResponder]:[self emailLogin];
    
  return YES;
}

#pragma mark-Buttons Handling
/*!
 *  @brief  Action to request for  read permissions like your public_profile,birthday,email
 *
 *  @param sender is Btn_fbSignup
 */
- (IBAction)btn_fbLogin_pressed:(id)sender
{
    
    if ([[[FBSDKAccessToken currentAccessToken] permissions]allObjects])
    {
        [self performSelectorOnMainThread:@selector(fbLoginHandler) withObject:nil waitUntilDone:NO];
    }
    else
    {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithReadPermissions: @[@"public_profile",@"user_birthday",@"email"]
                                handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                    if (error) {
                                        NSLog(@"%@",[error description]);
                                    } else if (result.isCancelled) {
                                        NSLog(@"Cancelled");
                                    } else {
                                        NSLog(@"Logged in");
                                        [self performSelectorOnMainThread:@selector(fbLoginHandler) withObject:nil waitUntilDone:NO];
                                    }
                                }];
        
    }

}

/*!
 *  @brief  To fetch Facebook Account Details like id,name,email after taking permissions
 */
-(void)fbLoginHandler
{
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields":@"id,name,email"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"fetched user:%@", result);
             
             NSDictionary *UserData=(NSDictionary*)result;
             NSLog(@"%@",[UserData description]);
             self.fb_name=[UserData valueForKey:@"name"];
             
             self.fb_id=[UserData valueForKey:@"id"];
             // self.fb_email=[UserData valueForKey:@"email"];
             self.fb_email=([result valueForKey:@"email"] != nil) ?[UserData valueForKey:@"email"]:@"";
             
             [self performSelectorOnMainThread:@selector(performLogin) withObject:nil waitUntilDone:NO];
         }
         else{
             NSLog(@"%@",error);
             // An error occurred, we need to handle the error
             // See: https://developers.facebook.com/docs/ios/errors
         }
     }];

}

/*!
 *  @brief  To Sign up or Login(if already registered) by facebook
 */
-(void)performLogin
{
    AppDelegate *App=(AppDelegate*)[UIApplication sharedApplication].delegate;
    [App StartAnimating];
    self.view.userInteractionEnabled=NO;
    
    [self.view endEditing:YES];
    [self resignFirstResponder];
    NSArray *myArray = [self.fb_name componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
    NSString *str1=[myArray objectAtIndex:0];
    NSString*str2=[myArray lastObject];
    
    NSDictionary *dict = [NSDictionary dictionary];
    dict=[[NSDictionary alloc]initWithObjectsAndKeys:self.fb_id, @"facebook_id",str1,@"first_name",str2,@"last_name",self.fb_email,@"email",nil];
    
    [IOSRequest uploadData:Url_fbSignUp parameters:dict imageData:nil success:^(NSDictionary *responseStr)
     {
          [App StopAnimating];
         self.view.userInteractionEnabled=YES;
         
         if ([[responseStr valueForKey:@"success"]integerValue]==1)
         {
            [UserProfile saveProfile:[responseStr valueForKey:@"user"]];
             UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
             MainViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"MainViewController"];
             [self.navigationController pushViewController:controller animated:YES];
         }
         
     } failure:^(NSError *error)
     {
        self.view.userInteractionEnabled=YES;
         [App StopAnimating];
     }];
}
/*!
 *  @brief  login api hit
 *
 *  @param sender btn_login
 */

- (IBAction)btn_login_pressed:(id)sender
{
    [self emailLogin];
}


-(void)emailLogin
{
    AppDelegate *App = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [App StartAnimating];
    self.view.userInteractionEnabled=NO;
    
    [self.view endEditing:YES];
    [self resignFirstResponder];
    NSDictionary *dict = [NSDictionary dictionary];
    AlertView *alert=[[AlertView alloc]init];
    
    dict=[[NSDictionary alloc]initWithObjectsAndKeys:self.tf_email.text,@"email",self.tf_pswd.text,@"password",nil];
    
    [IOSRequest uploadData:Url_Login parameters:dict imageData:nil success:^(NSDictionary *responseStr)
     {
         [App StopAnimating];
         self.view.userInteractionEnabled=YES;
         
         if ([[responseStr valueForKey:@"success"]integerValue]==1)
         {
             [UserProfile saveProfile:[responseStr valueForKey:@"user"]];
             UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
             MainViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"MainViewController"];
             [self.navigationController pushViewController:controller animated:YES];
         }
         else
         {
             
             [alert showStaticAlertWithTitle:@"" AndMessage:[responseStr valueForKey:@"msg"]];
         }
     }
                   failure:^(NSError *error)
     {
         [alert showStaticAlertWithTitle:@"" AndMessage:@"Please check your Internet Connection!"];
         NSLog(@"%@",[error description]);
         [App StopAnimating];
         self.view.userInteractionEnabled=YES;
     }];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self.view resignFirstResponder];
}

/*!
 *  @brief  forgotpassword api hit
 *
 *  @param sender btn_fPswd
 */
- (IBAction)btn_fPswd_pressed:(id)sender
{

    
    [self.view endEditing:YES];
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ForgotPswdViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"ForgotPswdViewController"];
    [self.navigationController pushViewController:controller animated:YES];
  
}
/*!
 *  @brief  Action performed on signup button click
 *
 *  @param sender btn_SignUp
 */
- (IBAction)btn_SignUp_pressed:(id)sender
{
   // [self.navigationController popViewControllerAnimated:YES];
    [self.view endEditing:YES];
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SignupViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"SignupViewController"];
    [self.navigationController pushViewController:controller animated:YES];

}
/*!
 *  @brief  Action performed on back button click
 *
 *  @param sender <#sender description#>
 */
- (IBAction)btn_back_pressed:(id)sender
{
  [self.navigationController popViewControllerAnimated:YES];
}

@end
