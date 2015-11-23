//
//  ForgotPswdViewController.m
//  gava
//
//  Created by RICHA on 9/4/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "ForgotPswdViewController.h"

@interface ForgotPswdViewController ()
/*!
 *  @brief MMMaterialDesignSpinner class's object
 */
@property(nonatomic,retain)MMMaterialDesignSpinner *spinnerView;
@end

@implementation ForgotPswdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewHelper];
    [self AddLoaderView];
    self.lbl_confirmationMsg.preferredMaxLayoutWidth=[UIScreen mainScreen].bounds.size.width-20;
    self.lbl_msgShow.preferredMaxLayoutWidth=[UIScreen mainScreen].bounds.size.width-20;
    [self viewHelper];
    // Do any additional setup after loading the view.
}

/*!
 *  @brief   Did everything that i want to do before appearance of viewcontroller
 */
-(void)viewHelper
{
    self.lbl_confirmationMsg.hidden=YES;
    self.lbl_msgShow.hidden=NO;
    self.view_email.hidden=NO;
    self.btn_close.hidden=YES;
    self.btn_done.hidden=NO;
    self.btn_back.hidden=NO;
}

/*!
 *  @brief  To go back to previous ViewController
 *
 *  @param sender <#sender description#>
 */
- (IBAction)btn_back_pressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*!
 *  @brief  To go back to previous ViewController
 *
 *  @param sender <#sender description#>
 */
- (IBAction)btn_close_pressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*!
 *  @brief  Set Spinner properties
 *
 *  @return <#return value description#>
 */
#pragma mark-LoaderView
-(void)AddLoaderView
{
    self.spinnerView = [[MMMaterialDesignSpinner alloc] init];
    self.spinnerView.frame=CGRectMake(0, 0, 40, 40);
    self.spinnerView.center=self.view.center;
    // Set the line width of the spinner
    self.spinnerView.lineWidth = 3.0f;
    // Set the tint color of the spinner
    self.spinnerView.tintColor = [UIColor colorWithRed:84.0/255.0 green:190.0/255.0 blue:244.0/255.0 alpha:1.0];
    // Add it as a subview
    [self.view addSubview:self.spinnerView];
    
}

/*!
 *  @brief  Action performed on  clicking Done button
 *
 *  @param sender <#sender description#>
 */
- (IBAction)btn_done_pressed:(id)sender
{
    [self forgotPswdApiHit];
}

-(void)forgotPswdApiHit
{
    [self.view endEditing:YES];
    AppDelegate *App=(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    AlertView *alert=[[AlertView alloc]init];
    
    if ([[self ValidateForgotPswdInfo]length]==0) {
        [App StartAnimating];
        self.view.userInteractionEnabled=NO;
        
        NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:self.tf_email.text,@"email",nil];
        [IOSRequest uploadData:Url_forgotpswd parameters:dict imageData:nil success:^(NSDictionary *responseStr) {
            NSLog(@"%@",responseStr);
            [App StopAnimating];
            self.view.userInteractionEnabled=YES;
            
            if ([[responseStr valueForKey:@"success"]integerValue]==1)
            {
                self.lbl_confirmationMsg.hidden=NO;
                self.lbl_msgShow.hidden=YES;
                self.view_email.hidden=YES;
                self.btn_close.hidden=NO;
                self.btn_done.hidden=YES;
                self.btn_back.hidden=YES;
            }
            else
            {
                [alert showStaticAlertWithTitle:@"Notice" AndMessage:[responseStr valueForKey:@"msg" ]];
                [App StopAnimating];
            }
        }
                       failure:^(NSError *error)
         {
             self.view.userInteractionEnabled=YES;
             NSLog(@"%@",[error description]);
             
             [alert showStaticAlertWithTitle:@"" AndMessage:@"Please check your Internet Connection!"];
             NSLog(@"%@",[error description]);
             
             [App StopAnimating];
         }];
        self.tf_email.text=@"";
    }
    else
    {
        self.tf_email.text=@"";
        [alert showStaticAlertWithTitle:@"" AndMessage:[self ValidateForgotPswdInfo]];
    }
    
}
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

-(NSString*)ValidateForgotPswdInfo
{
    NSString * str=@"";
    if ([self email_validation:self.tf_email.text]==NO)
    {
        str=@" Please enter valid email address";
    }
    return str;
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
    if (textField==self.tf_email) {
    
         [self forgotPswdApiHit];
    }
    return YES;
}

@end
