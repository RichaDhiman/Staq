//
//  SignupViewController.m
//  gava
//
//  Created by RICHA on 9/4/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "SignupViewController.h"
#import "IOSRequest.h"

@interface SignupViewController ()
/*!
 *  @brief  textfield class's object
 */
@property(nonatomic,retain)UITextField *activeField;
@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewhelper];
}

/*!
 *  @brief  Did everything that i want to do before appearance of viewcontroller like initializaton of objects etc

 */
-(void)viewhelper
{
    self.btn_signUp.layer.cornerRadius=4;
    self.btn_signUp.clipsToBounds=YES;
    [self registerForKeyboardNotifications];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard:)];
    
    [self.my_scrollView addGestureRecognizer:tap];
 }

/*!
 *  @brief  <#Description#>
 *
 *  @param gesture <#gesture description#>
 */
-(void)dismissKeyboard:(UITapGestureRecognizer*)gesture
{
    [self.view endEditing:YES];
}

#pragma mark-Buttons Handling
/*!
 *  @brief  Signup Api hit
 *
 *  @param sender btn_signup
 */
- (IBAction)btn_signup_pressed:(id)sender
{
    [self sighUp];
}
-(void)sighUp
{
    AppDelegate *App=(AppDelegate*)[UIApplication sharedApplication].delegate;
    AlertView *alert=[[AlertView alloc]init];
    [self.view endEditing:YES];
    if ([[self ValidateSignupInfo] length]==0)
    {
        [App StartAnimating];
        self.view.userInteractionEnabled=NO;
        
        NSDictionary *dict = [NSDictionary dictionary];
        dict=[[NSDictionary alloc]initWithObjectsAndKeys:[self.tf_firstName.text capitalizedString],@"first_name",[self.tf_lastName.text capitalizedString],@"last_name",self.tf_email.text,@"email",self.tf_pswd.text,@"password",nil];
        [IOSRequest uploadData:Url_Signup parameters:dict imageData:nil success:^(NSDictionary *responseStr)
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
             self.view.userInteractionEnabled=YES;
             [alert showStaticAlertWithTitle:@"" AndMessage:@"Please check your Internet Connection!"];
             [App StopAnimating];
             
         }];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[self ValidateSignupInfo] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];

       // [alert showStaticAlertWithTitle:@"" AndMessage:[self ValidateSignupInfo]];
    }
}

- (IBAction)btn_login_pressed:(id)sender
{
    [self.view endEditing:YES];
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
      [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)btn_back_pressed:(id)sender
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-KeyBoard Handling
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}


- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height+20, 0.0);
    self.my_scrollView.contentInset = contentInsets;
    self.my_scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect,self.activeField.frame.origin) )
    {
        [self.my_scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.my_scrollView.contentInset = contentInsets;
    self.my_scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark-Textfield handling

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    self. activeField=textField;
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField=nil;
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
    if (textField==self.tf_firstName) {
        [self.tf_lastName becomeFirstResponder];
    }
    else if (textField==self.tf_lastName)
    {
        [self.tf_email becomeFirstResponder];
    }
    else if (textField==self.tf_email)
    {
        [self.tf_pswd becomeFirstResponder];
    }
    else
    {
     
        [self sighUp];
    }
    return YES;
}

#pragma mark-EmailFormat Validation Function
/*!
 *  @brief  To validate email format
 *
 *  @param checkString entered email
 *
 *  @return return No if wrong format
 */
-(BOOL)email_validation:(NSString*)checkString
{
    
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:checkString];
    
}
/*!
 *  @brief  To validate if any textfield is blank
 *
 *  @param NSString string that is to show as an alert

 *
 *  @return return string that is to show as an alert
 */
#pragma mark-Signup validation
-(NSString*)ValidateSignupInfo
{
    NSString * str=@"";
    
    if (self.tf_firstName.text.length==0)
    {
        str=@"Please enter your fullname";
    }
    else if (self.tf_lastName.text.length == 0)
    {
        str=@" Please enter your email address";
    }
    else if ([self email_validation:self.tf_email.text]==NO)
        
    {
        str=@" Please enter valid email address";
    }
    
    else if (self.tf_pswd.text.length==0)
    {
        str=@" Please enter your password";
    }
    else if (self.tf_pswd.text.length<5)
    {
        str=@"Please enter minimum 5 characters";
    }
    return str;
}



@end
