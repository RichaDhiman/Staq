//
//  AddCardInfoViewController.m
//  gava
//
//  Created by RICHA on 9/7/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "AddCardInfoViewController.h"

@interface AddCardInfoViewController ()
/*!
 *  @brief  UIView class's object
 */
@property(nonatomic,strong)UIView* AccessoryView;
@property(nonatomic,retain)UITextField *activeField;
@property(nonatomic)BOOL flagForNext;
@end

@implementation AddCardInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewHelper];
}

#pragma mark-Accessory View
/*!
 *  @brief  To Add accessory view
 */
-(void)accessaryForDone
{
    self.AccessoryView=[[UIView alloc ]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , 40)];
    [self.tf_cardNumber setInputAccessoryView:self.AccessoryView];
    
    [self.tf_pinNumber setInputAccessoryView:self.AccessoryView];
    [self.tf_remainingBal setInputAccessoryView:self.AccessoryView];
    
    [self.AccessoryView setBackgroundColor:[UIColor colorWithRed:174.0/255.0 green:176.0/255.0 blue:184.0/255.0 alpha:1]];
    UIButton *donebtn=[[UIButton alloc]initWithFrame:CGRectMake(self.AccessoryView.frame.size.width-50, 0, 50, self.AccessoryView.frame.size.height)];
    [donebtn setTitle:@"Done" forState:UIControlStateNormal];
    [donebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [donebtn addTarget:self action:@selector(Accessory_Donebtn_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.AccessoryView addSubview:donebtn];
}

-(void)accessaryForNext
{
    self.AccessoryView=[[UIView alloc ]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , 40)];
    [self.tf_cardNumber setInputAccessoryView:self.AccessoryView];
    [self.tf_pinNumber setInputAccessoryView:self.AccessoryView];
    [self.tf_remainingBal setInputAccessoryView:self.AccessoryView];

    [self.AccessoryView setBackgroundColor:[UIColor colorWithRed:174.0/255.0 green:176.0/255.0 blue:184.0/255.0 alpha:1]];
    UIButton *Nextbtn=[[UIButton alloc]initWithFrame:CGRectMake(self.AccessoryView.frame.size.width-50, 0, 50, self.AccessoryView.frame.size.height)];
    [Nextbtn setTitle:@"Next" forState:UIControlStateNormal];
    [Nextbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Nextbtn addTarget:self action:@selector(Accessory_Nextbtn_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.AccessoryView addSubview:Nextbtn];

}

/*!
 *  @brief   Did everything that i want to do before appearance of viewcontroller
 */
-(void)viewHelper
{
//    [self.tf_brandName setTintColor:[UIColor blackColor]];
    [self.tf_brandName setTintColor:[UIColor colorWithRed:84.0/255.0 green:190.0/255.0 blue:244.0/255.0 alpha:1.0]];

    self.lbl_verify.hidden=YES;
    self.btn_done.hidden=YES;
    
    if ([self.BrandName isEqualToString:@""]) {
        self.tf_brandName.userInteractionEnabled=YES;
        [self.tf_brandName becomeFirstResponder];
    }
    else{
        self.tf_brandName.text=self.BrandName;
        self.tf_brandName.userInteractionEnabled=NO;
    }

    [self.img_cardLogo setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%d",Url_pics,self.BrandImageName,(int)(self.img_cardLogo.frame.size.width*DISPLAYSCALE*2)]] placeholderImage:nil options:SDWebImageTransformAnimatedImage progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
           [self.ld startAnimating];
     } completed:nil usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

    
    self.btn_done2.layer.cornerRadius=4;
    self.btn_done2.clipsToBounds=YES;
    self.view_BotmLine.hidden=NO;
  
    
    
    if ([self.Brand_is_valid isEqualToString:@"1"]&& [self.BrandName isEqualToString:@"Target"]) {
        self.tf_remainingBal.placeholder=@"Event Number";
        self.tf_remainingBal.hidden=NO;
        self.cnst_Line4Leading.constant=15;
        self.cnst_Line4btmToSuperView.constant=42;
        self.lbl_dollar.hidden=YES;


    }
    else if([self.Brand_is_valid isEqualToString:@"0"]){
        self.tf_remainingBal.placeholder=@"Remaining Balance";
        self.tf_remainingBal.hidden=NO;
        self.view_BotmLine.hidden=NO;
        self.cnst_Line4Leading.constant=15;
        self.cnst_Line4btmToSuperView.constant=42;
        self.lbl_dollar.hidden=NO;


    }
    else
    {
        self.tf_remainingBal.hidden=YES;
        self.view_BotmLine.hidden=YES;
        self.cnst_Line4Leading.constant=0;
        self.cnst_Line4btmToSuperView.constant=0;
        self.lbl_dollar.hidden=YES;
    
    }
}

/*!
 *  @brief  Api will be hit to add card
 */
-(void)saveInfo
{
    AppDelegate *App=[UIApplication sharedApplication].delegate;
    [self.view endEditing:YES];
    [self resignFirstResponder];
    UserProfile *ud=[[UserProfile alloc]init];
    ud=[UserProfile getProfile];
    NSDictionary *dict = [NSDictionary dictionary];
   // SCLAlertView *alert=[[SCLAlertView alloc]init];
    AlertView *alert=[[AlertView alloc]init];
        if ([[self ValidateCardInfo]length]==0)
    {
        [App StartAnimating];
        self.lbl_verify.hidden=NO;
        self.view.userInteractionEnabled=NO;
        
       
        
        if (self.is_OtherBrand==YES) {
            
            NSString *str=[[NSString alloc]init];
            str=[self.tf_remainingBal.text stringByReplacingOccurrencesOfString:@"," withString:@"."];
            
            NSString *str5=[[NSString alloc]init];
            
            if ([[str substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"$"]) {
                str5=[str substringFromIndex:1];
            }
            
            
            dict=[[NSDictionary alloc]initWithObjectsAndKeys:[self.tf_brandName.text capitalizedString],@"name",[self.tf_cardNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],@"card_number",ud.user_access_token,@"access_token",[self.tf_pinNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],@"pin",[str5 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],@"balance",nil];
            
            
        }
       else if ([self.BrandName isEqualToString:@"Target"]) {
            
             dict=[[NSDictionary alloc]initWithObjectsAndKeys:self.Brandid,@"brand_id",[self.tf_cardNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],@"card_number",ud.user_access_token,@"access_token",[self.tf_pinNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],@"pin",[self.tf_remainingBal.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],@"event_number",nil];
           
        }
        else{
               NSString *str5=[[NSString alloc]init];
            if (self.tf_remainingBal.text.length!=0) {
                NSString *str=[[NSString alloc]init];

                str=[self.tf_remainingBal.text stringByReplacingOccurrencesOfString:@"," withString:@"."];
                if ([[str substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"$"]) {
                    str5=[str substringFromIndex:1];
                }

            }
            
            dict=[[NSDictionary alloc]initWithObjectsAndKeys:self.Brandid,@"brand_id",[self.tf_cardNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],@"card_number",ud.user_access_token,@"access_token",[self.tf_pinNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],@"pin",[str5 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],@"balance",nil];
            

        }
        
        [IOSRequest uploadData:Url_saveCard parameters:dict imageData:nil success:^(NSDictionary *responseStr)
         {
             [App StopAnimating];
            self.view.userInteractionEnabled=YES;
            self.lbl_verify.hidden=YES;
             
            if ([[responseStr valueForKey:@"success"]integerValue]==1)
             {
                 UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                 MainViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"MainViewController"];
                   [self.navigationController pushViewController:controller animated:YES];
             }
             else if([[responseStr valueForKey:@"success"]integerValue]==2)
             {
                 UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Token expired! Please login." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 alert1.tag=2;
                 [alert1 show];
             }
             else if ([[responseStr valueForKey:@"success"]integerValue]==3)
             {

                 [alert showStaticAlertWithTitle:@"" AndMessage:[responseStr valueForKey:@"msg"]];
            }
             else if([[responseStr valueForKey:@"success"]integerValue]==4){
                 [alert showStaticAlertWithTitle:@"Invalid Card Info" AndMessage:@"Please check to make sure all the numbers and pin/access code are correct."];
             }
             else{
                 
                 [alert showStaticAlertWithTitle:@"" AndMessage:[responseStr valueForKey:@"msg"]];
             }
         }
            failure:^(NSError *error)
         {
            self.lbl_verify.hidden=YES;
            self.view.userInteractionEnabled=YES;
             [alert showStaticAlertWithTitle:@"" AndMessage:@"Please check your Internet Connection!"];
             NSLog(@"%@",[error description]);
             [App StopAnimating];
             
         }];
    }
    else
    {
        [alert showStaticAlertWithTitle:@"" AndMessage:[self ValidateCardInfo]];
    }
}

#pragma mark-AddCard validation
/*!
 *  @brief  To validate whether card number is entered or not
 *
 *  @return <#return value description#>
 */
-(NSString*)ValidateCardInfo
{
    NSString * str=@"";
    if (self.is_OtherBrand==YES) {
        
        if (self.tf_brandName.text.length==0) {
            str=@"Please enter Brand Name";
        }
        else if (self.tf_cardNumber.text.length==0)
        {
            str=@"Please enter a valid Card Number";
        }
        else if(self.tf_remainingBal.text.length==0)
        {
            str=@"Please enter Balance Remaining ";
        }
        return str;
    }
    
    else if ([self.BrandName isEqualToString:@"Target"]&&[self.Brand_is_valid isEqualToString:@"1"])
    {
        if (self.tf_cardNumber.text.length==0)
        {
            str=@"Please enter a valid Card Number";
        }
        else if(self.tf_remainingBal.text.length==0)
        {
            str=@"Please enter a valid Event Number";
        }
        return str;
    }
    else if ([self.Brand_is_valid isEqualToString:@"0"])
    {
        if (self.tf_cardNumber.text.length==0)
        {
            str=@"Please enter a valid Card Number";
        }
        else if(self.tf_remainingBal.text.length==0)
        {
            str=@"Please enter Balance Remaining ";
        }
        return str;
    }
    else
    {
        if (self.tf_cardNumber.text.length==0)
            str=@"Please enter a valid Card Number";
        return str;

    }
}

/*!
 *  @brief  To check which should be the next responder
 *
 *  @param textField represent active textfield
 *
 *  @return return NO to ignore
 */

#pragma mark-Textfield Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.is_OtherBrand==YES) {
        if (textField==self.tf_brandName) {
            [self accessaryForNext];
            [self.tf_cardNumber becomeFirstResponder];
        }
    }
       else if([self.Brand_is_valid isEqualToString:@"0"]|| [self.BrandName isEqualToString:@"Target"]) {
        if (textField==self.tf_cardNumber)
        {
            [self accessaryForNext];
            [self.tf_pinNumber becomeFirstResponder];
        }
        else if(textField==self.tf_pinNumber)
        {
            [self accessaryForNext];
            [self.tf_remainingBal becomeFirstResponder];
            
        }
        else
        {
            [self accessaryForDone];
            [self.view endEditing:YES];
        }
        
        
    }
    else
    {
      
        if (textField==self.tf_cardNumber)
        {
            [self accessaryForNext];
            [self.tf_pinNumber becomeFirstResponder];
        }
        else
        {
            [self accessaryForDone];
            [self.view endEditing:YES];
        }

    }
    
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    self. activeField=textField;
    if (self.is_OtherBrand==YES) {
        if (textField==self.tf_brandName) {
            [self accessaryForNext];
        }
        else if (self.activeField==self.tf_cardNumber || self.activeField==self.tf_pinNumber)
        {
            [self accessaryForNext];
        }
        else{
            [self accessaryForDone];
            [self.tf_remainingBal setText:@"$"];
        }

    }
    else if ([self.Brand_is_valid isEqualToString:@"0"]||[self.BrandName isEqualToString:@"Target"]) {
        if (self.activeField==self.tf_cardNumber || self.activeField==self.tf_pinNumber)
        {
            [self accessaryForNext];
        }
        else{
            if ([self.BrandName isEqualToString:@"Target"]) {
                      [self accessaryForDone];
            }
            else
            {
                [self.tf_remainingBal setText:@"$"];
                [self accessaryForDone];
            }
     
        }
        
        }
    
       else{
       
           if (self.activeField==self.tf_cardNumber)
           {
               [self accessaryForNext];
           }
           else{
               [self accessaryForDone];
           }

        }
    
   }
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeField=nil;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //if ((textField.text.length == 1 && [string isEqualToString:@""])||(textField.text.length>=11))
    
    if (self.activeField==self.tf_remainingBal && ![self.BrandName isEqualToString:@"Target"]) {
        if (textField.text.length == 1 && [string isEqualToString:@""]){
            //When detect backspace when have one character.
            return NO;
        }
        
        else
        {
            return YES;
        }
 
    }
    else
    {
        return YES;
    }
    
}

#pragma mark-Button Actions

- (IBAction)btn_back_pressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self resignFirstResponder];
}

- (IBAction)btn_done2_pressed:(id)sender
{
    [self saveInfo];
}

/*!
 *  @brief  To move to first view controller if access token expired
 */
-(void)MoveToRootView
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user"];
    [[NSUserDefaults standardUserDefaults]synchronize];
//    [FBSession.activeSession closeAndClearTokenInformation];
//    FBSession.activeSession=nil;
    [[FBSDKLoginManager new] logOut];
    [self performSegueWithIdentifier:@"show_firstViewController" sender:self];

}
/*!
 *  @brief  resign responder on button click
 *
 *  @param btn Accessory button
 */
-(void)Accessory_Donebtn_pressed:(UIButton*)btn
{
//    [self.tf_cardNumber resignFirstResponder];
//    [self.tf_pinNumber resignFirstResponder];
    [self saveInfo];
}

-(void)Accessory_Nextbtn_pressed:(UIButton*)btn
{
   // [self accessaryForDone];
   // [self.tf_pinNumber becomeFirstResponder];

    if (([self.Brand_is_valid isEqualToString:@"0"]|| [self.BrandName isEqualToString:@"Target"]) && (self.flagForNext==YES))
    {
       
        self.flagForNext=NO;
        [self.tf_remainingBal becomeFirstResponder];
        
    }
    else if(self.flagForNext==NO){
        self.flagForNext=YES;
         [self.tf_pinNumber becomeFirstResponder];
    }
    else {
        
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==2)
    {
        if (buttonIndex==0)
        {
            [self MoveToRootView];
        }
    }
}

@end
