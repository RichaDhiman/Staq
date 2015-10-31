//
//  AddCodeToSyncViewController.m
//  gava
//
//  Created by RICHA on 10/19/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "AddCodeToSyncViewController.h"

@interface AddCodeToSyncViewController ()
@property(nonatomic,retain)NSDictionary *tempResp;
@property(nonatomic,strong)UIView* AccessoryView;
@property(nonatomic,retain)NSString *other_id;
@property(nonatomic,retain)NSString* otherName;

@end

@implementation AddCodeToSyncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewHelper];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewHelper
{
    //self.tf_code.text=@"2200001";
    
    self.lbl_AddCode.preferredMaxLayoutWidth=self.view.frame.size.width-120;
    self.lbl_AddCode.text=@"Paste code to sync Family Share";
}
- (IBAction)btn_back_pressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btn_sync_pressed:(id)sender {
    
    AlertView *alert1=[[AlertView alloc]init];
    if ([[self ValidateCodeInfo]length]==0) {
        
//        UIAlertView *alert2=[[UIAlertView alloc]initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"NO,thanks" otherButtonTitles:@"OK", nil];
        
         [self SyncCard];
    }
    else
    {
        [alert1 showStaticAlertWithTitle:@"" AndMessage:[self ValidateCodeInfo]];
    }
   
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [self resignFirstResponder];
}

-(void)accessaryForDone
{
    self.AccessoryView=[[UIView alloc ]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , 40)];
    [self.tf_code setInputAccessoryView:self.AccessoryView];
    
    [self.AccessoryView setBackgroundColor:[UIColor colorWithRed:174.0/255.0 green:176.0/255.0 blue:184.0/255.0 alpha:1]];
    UIButton *donebtn=[[UIButton alloc]initWithFrame:CGRectMake(self.AccessoryView.frame.size.width-50, 0, 50, self.AccessoryView.frame.size.height)];
    [donebtn setTitle:@"Sync" forState:UIControlStateNormal];
    [donebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [donebtn addTarget:self action:@selector(Accessory_Donebtn_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.AccessoryView addSubview:donebtn];
}

-(void)Accessory_Donebtn_pressed:(UIButton*)btn
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    AlertView *alert1=[[AlertView alloc]init];
    if ([[self ValidateCodeInfo]length]==0) {
        
        //        UIAlertView *alert2=[[UIAlertView alloc]initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"NO,thanks" otherButtonTitles:@"OK", nil];
        
        [self SyncCard];
    }
    else
    {
        [alert1 showStaticAlertWithTitle:@"" AndMessage:[self ValidateCodeInfo]];
    }

}

- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    [self accessaryForDone];
}

-(void)SyncCard
{
    [self.view endEditing:YES];
    [self resignFirstResponder];
    AppDelegate *App=(AppDelegate*)[UIApplication sharedApplication].delegate;
    AlertView *alert=[[AlertView alloc]init];
    UserProfile *ud=[[UserProfile alloc]init];
    ud=[UserProfile getProfile];
    [App StartAnimating];
    self.view.userInteractionEnabled=NO;
    
//    NSString *str1=[[NSString alloc]init];
//    str1=[self.tf_code.text stringByReplacingOccurrencesOfString:@"," withString:@"."];

    
    NSDictionary *dict=[[NSDictionary alloc]init];
    dict=[NSDictionary dictionaryWithObjectsAndKeys:ud.user_access_token,@"access_token",[self.tf_code.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],@"code", nil];
    
    [IOSRequest uploadData:Url_SyncCard parameters:dict imageData:nil success:^(NSDictionary *responseStr)
     {
         [App StopAnimating];
         self.view.userInteractionEnabled=YES;
         
         if ([[responseStr valueForKey:@"success"] integerValue]==1)
         {
             self.other_id=[[NSString alloc]init];
             self.otherName=[[NSString alloc]init];
             
             self.other_id=[responseStr valueForKey:@"other_id"];
             self.otherName=[responseStr valueForKey:@"username"];
             
             [CardDetails saveCardsInfo:[responseStr valueForKey:@"cards"]];
             [[NSUserDefaults standardUserDefaults]setValue:[responseStr valueForKey:@"total"] forKey:@"total"];
             [[NSUserDefaults standardUserDefaults]synchronize];

//             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Family Share Activated" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                 alert.tag=4;
//                 [alert show];
             
             
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Family Share Activated" message:[NSString stringWithFormat:@"Wish to sync your gift cards back with %@ ?",self.otherName] delegate:self cancelButtonTitle:@"No, thanks" otherButtonTitles:@"YES", nil];
             alert.tag=5;
             [alert show];

             
            // [self.navigationController popViewControllerAnimated:YES];
         }
         else if([[responseStr valueForKey:@"success"]integerValue]==2)
         {
             UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Token expired! Please login." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             alert1.tag=2;
             [alert1 show];
         }
         else
         {
             [alert showStaticAlertWithTitle:@"" AndMessage:[responseStr valueForKey:@"msg"]];
             NSLog(@"%@",[responseStr valueForKey:@"msg"]);
         }
     }
        failure:^(NSError *error)
     {
         self.view.userInteractionEnabled=YES;
         [App StopAnimating];
         
         [alert showStaticAlertWithTitle:@"" AndMessage:@"Please check your Internet Connection!"];
     }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==self.tf_code) {
        [self resignFirstResponder];
        [self.view endEditing:YES];
        AlertView *alert1=[[AlertView alloc]init];
        if ([[self ValidateCodeInfo]length]==0) {
            
            //        UIAlertView *alert2=[[UIAlertView alloc]initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"NO,thanks" otherButtonTitles:@"OK", nil];
            
            [self SyncCard];
        }
        else
        {
            [alert1 showStaticAlertWithTitle:@"" AndMessage:[self ValidateCodeInfo]];
        }
    }
   
    return YES;
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==5) {
        if (buttonIndex==0) {
            
              [self performSegueWithIdentifier:@"show_MainViewController" sender:self];
         
        }
        else
        {
            //Apihit
            [self SyncBack];
        }
        
    }
    
   else if(alertView.tag==4)
    {
        if (buttonIndex==0) {
            
               }
       
    }
    else
    {
        if (buttonIndex==0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
   
}

-(void)SyncBack
{
    [self.view endEditing:YES];
    [self resignFirstResponder];
    AppDelegate *App=(AppDelegate*)[UIApplication sharedApplication].delegate;
    AlertView *alert=[[AlertView alloc]init];
    UserProfile *ud=[[UserProfile alloc]init];
    ud=[UserProfile getProfile];
    [App StartAnimating];
    self.view.userInteractionEnabled=NO;
    
    NSDictionary *dict=[[NSDictionary alloc]init];
    dict=[NSDictionary dictionaryWithObjectsAndKeys:ud.user_access_token,@"access_token",self.other_id,@"other_id", nil];
    
    [IOSRequest uploadData:Url_syncBack parameters:dict imageData:nil success:^(NSDictionary *responseStr)
     {
         [App StopAnimating];
         self.view.userInteractionEnabled=YES;
         
         if ([[responseStr valueForKey:@"success"] integerValue]==1)
         {
            [self performSegueWithIdentifier:@"show_MainViewController" sender:self];
         }
         else if([[responseStr valueForKey:@"success"]integerValue]==2)
         {
             UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Token expired! Please login." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             alert1.tag=2;
             [alert1 show];
         }
         else
         {
             [alert showStaticAlertWithTitle:@"" AndMessage:[responseStr valueForKey:@"msg"]];
             NSLog(@"%@",[responseStr valueForKey:@"msg"]);
         }
     }
            failure:^(NSError *error)
     {
         self.view.userInteractionEnabled=YES;
         [App StopAnimating];
         
         [alert showStaticAlertWithTitle:@"" AndMessage:@"Please check your Internet Connection!"];
     }];

}

-(NSString*)ValidateCodeInfo
{
    UserProfile *ud=[[UserProfile alloc]init];
    ud=[UserProfile getProfile];

    NSString * str=@"";
    
        if (self.tf_code.text.length==0) {
            str=@"Please enter Code";
        }
        else if ([self.tf_code.text isEqualToString:ud.user_code])
        {
            str=@"Please enter a valid Code. You can't syncronize with yourself.";
        }
        return str;
    
}


@end
