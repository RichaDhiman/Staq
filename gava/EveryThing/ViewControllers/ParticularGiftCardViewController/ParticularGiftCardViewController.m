
//
//  ParticularGiftCardViewController.m
//  gava
//
//  Created by RICHA on 9/9/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "ParticularGiftCardViewController.h"
#import "UserProfile.h"
#import "CardDetails.h"

@interface ParticularGiftCardViewController ()
/*!
 *  @brief  MKPlacemark class's object
 */
@property(nonatomic,retain)MKPlacemark *DlocPM;
@property(nonatomic,retain)MKLocalSearchResponse *locs;
@property(nonatomic,retain)NSArray *GoogleLocs;
@property(nonatomic)BOOL alreadyRefreshing;
@property(nonatomic,retain)NSTimer *timer;
@property(nonatomic,strong)UIView* AccessoryView;
@end

@implementation ParticularGiftCardViewController
{
    int currMinute;
    int currSeconds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    currMinute=00;
    currSeconds=3;
    if ([self.cdet.card_is_custom isEqualToString:@"1"]) {
        self.btn_link.hidden=YES;
        self.btn_tc.hidden=YES;
        self.btn_redemp.hidden=YES;
        self.view_center.hidden=YES;
        self.mapView.hidden=NO;
        self.lbl_map_above.hidden=NO;
        self.lbl_map_bottom.hidden=NO;
        self.btn_Locator.hidden=NO;
        self.lbl_otherCardName.hidden=NO;
        self.lbl_otherCardName.text=self.cdet.card_brand_name;
        
    }
    else
    {
        self.btn_link.hidden=NO;
        self.btn_tc.hidden=NO;
        self.btn_redemp.hidden=NO;
        self.view_center.hidden=NO;
        self.mapView.hidden=NO;
        self.lbl_map_above.hidden=NO;
        self.lbl_map_bottom.hidden=NO;
        self.btn_Locator.hidden=NO;
        self.lbl_otherCardName.hidden=YES;

    }
    
    [self registerForKeyboardNotifications];
    [self.tf_price setTintColor:[UIColor whiteColor]];
    
          self.img_barcode.hidden=NO;
    
    AlertView *alert=[[AlertView alloc]init];
    if([CLLocationManager locationServicesEnabled] &&
       [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        // show the map
    } 
    else
    {
        [alert showStaticAlertWithTitle:@"" AndMessage:@"Turn On Location Services to allow 'Wallet' to determine your location."];
    }
    
    self.alreadyRefreshing=NO;
    self.locationManager1 = [[CLLocationManager alloc] init];
    self.locationManager1.distanceFilter = kCLDistanceFilterNone;
    self.locationManager1.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager1.delegate=self;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    
        //    [self.locationManager requestAlwaysAuthorization];
        [self.locationManager1 requestWhenInUseAuthorization];
    
    [self.locationManager1 startUpdatingLocation];
    
    self.lat= [NSString stringWithFormat:@"%f",self.locationManager1.location.coordinate.latitude ];
    self.lng = [NSString stringWithFormat:@"%f",self.locationManager1.location.coordinate.longitude ];
    
    [[NSUserDefaults standardUserDefaults]setValue:self.lat forKey:@"lat"];
    [[NSUserDefaults standardUserDefaults]setValue:self.lng forKey:@"lng"];
    [[NSUserDefaults standardUserDefaults] synchronize];

  
    [self AddBarCode];
   
    self.btn_refresh.layer.cornerRadius=4;
    self.btn_refresh.clipsToBounds=YES;
    
    
    [self.btn_link setTitle:[NSString stringWithFormat:@"    %@    ",self.cdet.card_link_title ] forState:UIControlStateNormal];
     [self.btn_link layoutIfNeeded];
    
    
    self.nav_title.text=[NSString stringWithFormat:@"%@ Gift Card",self.cdet.brandDet.bDet_name ];
    
    [self.btn_link setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.2]];
    
    self.view_forEdit.hidden=YES;
    self.btn_removeCard.layer.cornerRadius=4;
    self.btn_removeCard.clipsToBounds=YES;
    
    
 
    
    self.btn_cancel.layer.cornerRadius=4;
    self.btn_cancel.clipsToBounds=YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.view_actionSheet.transform=CGAffineTransformMakeTranslation(0.0,self.view_actionSheet.frame.size.height);
    } completion:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissView)];
    [self.img_forEdit addGestureRecognizer:tap];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

-(void)accessaryForDone
{
    self.AccessoryView=[[UIView alloc ]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , 40)];
    [self.tf_price setInputAccessoryView:self.AccessoryView];
    
    [self.AccessoryView setBackgroundColor:[UIColor colorWithRed:174.0/255.0 green:176.0/255.0 blue:184.0/255.0 alpha:1]];
    UIButton *donebtn=[[UIButton alloc]initWithFrame:CGRectMake(self.AccessoryView.frame.size.width-50, 0, 50, self.AccessoryView.frame.size.height)];
    [donebtn setTitle:@"Done" forState:UIControlStateNormal];
    [donebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [donebtn addTarget:self action:@selector(Accessory_Donebtn_pressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.AccessoryView addSubview:donebtn];
}

-(void)Accessory_Donebtn_pressed:(UIButton*)btn
{
    
    if ([[self ValidateEditInfo]length]==0) {
        [self editBalApiHit];
        [self.view endEditing:YES];
    }
    else
    {
      UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[self ValidateEditInfo] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag=4;
        [alert show];
        
        
        [self.view endEditing:YES];
    }

}

-(void)dismissView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.view_actionSheet.transform=CGAffineTransformMakeTranslation(0.0,self.view_actionSheet.frame.size.height);
    } completion:^(BOOL finished) {
        self.view_forEdit.hidden=YES;
    }];

}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
     [self viewHelper];
    // add the observer
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(textFieldDidChange:)
//                                                 name:@"UITextFieldTextDidChangeNotification"
//                                               object:self.tf_price];
  
   // self.view_spacerView.frame.size.height=(self.view_upper.frame.size.height-self.img_card_img.frame.size.height)/2;
    
//     self.view_spacerView setFrame:cgrectmake(self.view_upper.frame.size.height-self.img_card_img.frame.size.height)/2;
 // [self adJusttf];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //[[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    if (self.locationManager1.location!=nil)
    {
        self.lat= [NSString stringWithFormat:@"%f",self.locationManager1.location.coordinate.latitude ];
        self.lng = [NSString stringWithFormat:@"%f",self.locationManager1.location.coordinate.longitude ];
        
        [[NSUserDefaults standardUserDefaults]setValue:self.lat forKey:@"lat"];
        [[NSUserDefaults standardUserDefaults]setValue:self.lng forKey:@"lng"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [self.mapView setDelegate:self];
        [self googleNearestLoc];
        [self.locationManager1 stopUpdatingLocation];
        
    }
    
}
/*!
 *  @brief   Did everything that i want to do before appearance of viewcontroller
 */
-(void)viewHelper
{
    
    if ([self.cdet.brandDet.bDet_brand_is_valid_id isEqualToString:@"1"]) {
        self.img_refresh.image=[UIImage imageNamed:@"ic_refresh"];
        self.tf_price.userInteractionEnabled=NO;
    }
    else{
        self.img_refresh.image=[UIImage imageNamed:@"ic_edit"];
        //self.img_refresh.image=[UIImage imageNamed:@"ic_pencil"];

        
        self.tf_price.userInteractionEnabled=NO;
        
    }

    
    [self setMaskTo:self.btn_link byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomLeft];
    
    [self.img_card_img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%f",Url_pics,self.cdet.brandDet.bDet_logo,([UIScreen mainScreen].bounds.size.width-70)*DISPLAYSCALE]] placeholderImage:nil options:SDWebImageTransformAnimatedImage progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    
       
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
      [self.ld startAnimating];
    } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    

    self.lbl_card_num.text=[NSString stringWithFormat:@"# %@",self.cdet.card_number];
    
    if ([self.cdet.card_pin isEqualToString:@"0"])
    {
        [self.lbl_pin_num setText:@""];
    }
    else
    {
     self.lbl_pin_num.text=[NSString stringWithFormat:@"PIN: %@",self.cdet.card_pin];
    }
    
  
//    NSString *str=[[NSString alloc]init];
//    
//    if ([[self.cdet.card_price substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"$"]) {
//        str=[self.cdet.card_price substringFromIndex:1];
//        self.tf_price.text=str;
//    }
    
      self.tf_price.text=self.cdet.card_price;
   
    
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
   // NSDictionary* info = [aNotification userInfo];
    //CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height+20, 0.0);
//    self.my_scrollView.contentInset = contentInsets;
//    self.my_scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    //CGRect aRect = self.view.frame;
//    aRect.size.height -= kbSize.height;
//    if (!CGRectContainsPoint(aRect,self.activeField.frame.origin) )
//    {
//        [self.my_scrollView scrollRectToVisible:self.activeField.frame animated:YES];
//    }
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    self.my_scrollView.contentInset = contentInsets;
//    self.my_scrollView.scrollIndicatorInsets = contentInsets;
}









#pragma mark-Button Handling
/*!
 *  @brief  To delete the card from wallet
 *
 *  @param sender btn_edit
 */
- (IBAction)btn_edit_pressed:(id)sender
{
    
    self.view_forEdit.hidden=NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.view_actionSheet.transform=CGAffineTransformIdentity;
    } completion:nil];
    
}


/*!
 *  @brief  api to delete card will be hit
 */
-(void)delCard
{
    [self.view endEditing:YES];
    AppDelegate *App=(AppDelegate*)[UIApplication sharedApplication].delegate;
    AlertView *alert=[[AlertView alloc]init];
    UserProfile *ud=[[UserProfile alloc]init];
    ud=[UserProfile getProfile];
    [App StartAnimating];
    self.view.userInteractionEnabled=NO;
    
    NSDictionary *dict=[[NSDictionary alloc]init];
    dict=[NSDictionary dictionaryWithObjectsAndKeys:ud.user_access_token,@"access_token",self.cdet.card_id,@"card_id",self.cdet.card_is_custom,@"is_custom", nil];
    
    [IOSRequest uploadData:Url_delCard parameters:dict imageData:nil success:^(NSDictionary *responseStr)
     {
         [App StopAnimating];
        self.view.userInteractionEnabled=YES;
         
        if ([[responseStr valueForKey:@"success"] integerValue]==1)
         {
              [self.navigationController popViewControllerAnimated:YES];
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
         }
     }
            failure:^(NSError *error)
     {
        self.view.userInteractionEnabled=YES;
         [App StopAnimating];

         [alert showStaticAlertWithTitle:@"" AndMessage:@"Please check your Internet Connection!"];
     }];
}

- (IBAction)btn_back_pressed:(id)sender
{
    self.img_barcode.hidden=YES;
     [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btn_tc_pressed:(id)sender
{
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TermsConditons_RedemptionViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"TermsConditons_RedemptionViewController"];
    controller.brand_id=self.cdet.brandDet.bDet_brand_id;
    controller.show_TermCondi=YES;
    controller.navtitle=@"Terms & Conditions";
    //[self.navigationController pushViewController:controller animated:YES];
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)btn_inst_pressed:(id)sender
{
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TermsConditons_RedemptionViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"TermsConditons_RedemptionViewController"];
    controller.brand_id=self.cdet.brandDet.bDet_brand_id;
    controller.show_TermCondi=NO;
    controller.navtitle=@"Redemption Instructions";
//    [self.navigationController pushViewController:controller animated:YES];
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)btn_arrow_pressed:(id)sender
{
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        FullScreenMapViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"FullScreenMapViewController"];
    controller.cardDet=self.cdet;
    controller.GLocs=self.GoogleLocs;
    controller.CmngFromParGiftCrd=YES;
    [self.navigationController pushViewController:controller animated:YES];
  }

/*!
 *  @brief  api to refresh price will be hit
 *
 *  @param sender btn_refresh
 */

- (IBAction)btn_refresh_pressed:(id)sender
{
//    if (self.alreadyRefreshing==NO)
//    {
        if ([self.cdet.brandDet.bDet_brand_is_valid_id isEqualToString:@"1"]) {
            [self refreshApiHit];
        }
        else
        {
            self.img_refresh.hidden=YES;
            self.tf_price.userInteractionEnabled=YES;
            [self.tf_price becomeFirstResponder];
           // [self editBalApiHit];
        }
    
//    }
}

-(void)editBalApiHit

{
    self.img_refresh.hidden=NO;
    [self.tf_price resignFirstResponder];
    self.alreadyRefreshing=YES;
      // AppDelegate*App=(AppDelegate*)[UIApplication sharedApplication].delegate;
    //  [App StartAnimating];
    self.view.userInteractionEnabled=NO;
    
    AlertView *alert=[[AlertView alloc]init];
    UserProfile *ud=[[UserProfile alloc]init];
    ud=[UserProfile getProfile];
    [self.view endEditing:YES];
    
    
    NSString *str=[[NSString alloc]init];
   // str=[[str substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"$"];
    if ([[self.tf_price.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"$"]) {
        str=[self.tf_price.text substringFromIndex:1];
    }
    else
    {
        str=self.tf_price.text;
    }
    
    NSString *str1=[[NSString alloc]init];
    str1=[str stringByReplacingOccurrencesOfString:@"," withString:@"."];
    
    //[self.tf_price setText:str1];
    
    NSDictionary *dict=[[NSDictionary alloc]init];
    dict=[NSDictionary dictionaryWithObjectsAndKeys:ud.user_access_token,@"access_token",[str1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],@"balance",self.cdet.card_id,@"id",self.cdet.card_is_custom,@"is_custom",nil];
    
    [IOSRequest uploadData:Url_UpdateBal parameters:dict imageData:nil success:^(NSDictionary *responseStr)
     {
         self.view.userInteractionEnabled=YES;
         
         self.img_refresh.image=[UIImage imageNamed:@"ic_edit"];
        //self.img_refresh.image=[UIImage imageNamed:@"ic_pencil"];
         
         // [App StopAnimating];
         if ([[responseStr valueForKey:@"success"] integerValue]==1)
         {
            [CardDetails saveCardsInfo:[responseStr valueForKey:@"cards"]];
            //self.tf_price.userInteractionEnabled=NO;
             self.alreadyRefreshing=NO;
             
           //  if (![[self.tf_price.text substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"$"])
            //     self.tf_price.text=[NSString stringWithFormat:@"$%@",self.tf_price.text];
             
            
         }
         else if([[responseStr valueForKey:@"success"]integerValue]==2)
         {
             self.alreadyRefreshing=NO;
         
             UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Token expired! Please login." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             alert1.tag=2;
             [alert1 show];
         }
         else
         {
//             UIAlertView *alert7=[[UIAlertView alloc]initWithTitle:@"" message:[responseStr valueForKey:@"msg"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//             alert7.tag=7;
//             [alert7 show];
             
             [alert showStaticAlertWithTitle:@"" AndMessage:[responseStr valueForKey:@"msg"]];
         }
         
     }
            failure:^(NSError *error)
     {
         [self.timer invalidate];
         [self.img_refresh.layer removeAnimationForKey:@"rotationAnimation"];
         self.view.userInteractionEnabled=YES;
         self.alreadyRefreshing=NO;
         [alert showStaticAlertWithTitle:@"" AndMessage:@"Please check your Internet Connection!"];
         //[App StopAnimating];
     }];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)refreshApiHit
{
      self.img_refresh.image=[UIImage imageNamed:@"ic_refresh"];
    
    [self runSpinAnimationOnView:self.img_refresh duration:3 rotations:0.75 repeat:100];
    
    
    
    // AppDelegate*App=(AppDelegate*)[UIApplication sharedApplication].delegate;
    //  [App StartAnimating];
    self.view.userInteractionEnabled=NO;
    
    AlertView *alert=[[AlertView alloc]init];
    UserProfile *ud=[[UserProfile alloc]init];
    ud=[UserProfile getProfile];
    [self.view endEditing:YES];
    NSDictionary *dict=[[NSDictionary alloc]init];
    dict=[NSDictionary dictionaryWithObjectsAndKeys:ud.user_access_token,@"access_token",self.cdet.card_number,@"card_number",self.cdet.brandDet.bDet_brand_id,@"brand_id",self.cdet.card_id,@"id",self.cdet.card_is_custom,@"is_custom",nil];
    
    [IOSRequest uploadData:Url_Refresh parameters:dict imageData:nil success:^(NSDictionary *responseStr)
     {
         // [App StopAnimating];
         if ([[responseStr valueForKey:@"success"] integerValue]==1)
         {
             currMinute=00;
             currSeconds=3;
             
             [self start];
             
            // self.alreadyRefreshing=NO;
             self.tf_price.userInteractionEnabled=NO;
             
//             NSString *str=[[NSString alloc]init];
//             if ([[[responseStr valueForKeyPath:@"card.price"] substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"$"]) {
//                 str=[[responseStr valueForKeyPath:@"card.price"] substringFromIndex:1];
//                 [self.tf_price setText:str];
//             }

             [self.tf_price setText:[responseStr valueForKeyPath:@"card.price"]];

         }
         else if([[responseStr valueForKey:@"success"]integerValue]==2)
         {
              self.view.userInteractionEnabled=YES;
             currMinute=00;
             currSeconds=3;

             
            // self.alreadyRefreshing=NO;
              self.img_refresh.image=[UIImage imageNamed:@"ic_refresh"];
             [self.timer invalidate];
             [self.img_refresh.layer removeAnimationForKey:@"rotationAnimation"];
             UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Token expired! Please login." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             alert1.tag=2;
             [alert1 show];
         }
         else
         {
              self.view.userInteractionEnabled=YES;
             currMinute=00;
             currSeconds=3;

              self.img_refresh.image=[UIImage imageNamed:@"ic_refresh"];
             [self.timer invalidate];
             [self.img_refresh.layer removeAnimationForKey:@"rotationAnimation"];
             [alert showStaticAlertWithTitle:@"" AndMessage:[responseStr valueForKey:@"msg"]];
         }
         
     }
        failure:^(NSError *error)
     {
          self.view.userInteractionEnabled=YES;
         currMinute=00;
         currSeconds=3;

        [self.img_refresh.layer removeAnimationForKey:@"rotationAnimation"];
         [self.timer invalidate];
          self.img_refresh.image=[UIImage imageNamed:@"ic_refresh"];
   
         self.view.userInteractionEnabled=YES;
        // self.alreadyRefreshing=NO;
         [alert showStaticAlertWithTitle:@"" AndMessage:@"Please check your Internet Connection!"];
         //[App StopAnimating];
     }];

}
/*!
 *  @brief  To move to first view controller if access token expired
 */
-(void)MoveToRootView
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user"];
    [[NSUserDefaults standardUserDefaults]synchronize];
     [[FBSDKLoginManager new] logOut];
    [self performSegueWithIdentifier:@"show_firstViewController" sender:self];
}

#pragma mark-barcode

/*!
 *  @brief  To add barcode
 */
-(void)AddBarCode
{
    NSError *error = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    if ([self.cdet.brandDet.bDet_name isEqualToString:@"Target"]) {
        ZXBitMatrix* result = [writer encode:[self.cdet.card_number stringByAppendingString:self.cdet.card_event_number]
                                      format:kBarcodeFormatPDF417
                                       width:1600
                                      height:400
                                       error:&error];
        if (result) {
            CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
            
            self.img_barcode.image=[UIImage imageWithCGImage:image];
            
            
            // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
        } else {
            NSString *errorMessage = [error localizedDescription];
            NSLog(@"%@",errorMessage);
        }

    }
    else{
        ZXBitMatrix* result = [writer encode:self.cdet.card_number
                                      format:kBarcodeFormatCode128
                                       width:900
                                      height:300
                                       error:&error];
        if (result) {
            CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
            
            self.img_barcode.image=[UIImage imageWithCGImage:image];
            
            
            // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
        } else {
            NSString *errorMessage = [error localizedDescription];
            NSLog(@"%@",errorMessage);
        }


    }
    
    
}


-(void)googleNearestLoc
{
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    [self.mapView setDelegate:self];
    
//    NSString *url=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&radius=%@&key=AIzaSyBY5AWF0BwMMD_oxmm1KHSvEZkAuQLAx0Q&name=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"lat"], [[NSUserDefaults standardUserDefaults]valueForKey:@"lng"],@"160934",self.cdet.brandDet.bDet_name];
    
    NSString *str=[[NSString alloc]init];
//    NSRange whiteSpaceRange = [self.cdet.brandDet.bDet_name rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
//    if (whiteSpaceRange.location != NSNotFound)
        str=[NSString stringWithFormat:@"\"%@\"",self.cdet.brandDet.bDet_name];
//    else
//        str=self.cdet.brandDet.bDet_name;

    
    
     NSString *url=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&key=%@&name=%@&types=%@&rankby=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"lat"], [[NSUserDefaults standardUserDefaults]valueForKey:@"lng"],ApiKey,str ,self.cdet.brandDet.bDet_brand_type,@"distance"];

    
    [IOSRequest fetchJsonData:url success:^(NSDictionary *responseDict)
    {
        self.GoogleLocs=[[NSArray alloc]init];
        
        [[NSUserDefaults standardUserDefaults]setValue:[responseDict valueForKey:@"results"] forKey:@"result"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        self.GoogleLocs=[responseDict valueForKey:@"results"];
            [self plotPositions:self.GoogleLocs];
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)plotPositions:(NSArray *)data {
    // 1 - Remove any existing custom annotations but not the user location blue dot.
    for (id<MKAnnotation> annotation in self.mapView.annotations) {
        if ([annotation isKindOfClass:[MapPoint class]]) {
            [self.mapView removeAnnotation:annotation];
        }
   
    }
    
    if([self.GoogleLocs count]==0)
    {
        [self.mapView setCenterCoordinate:self.locationManager1.location.coordinate];
    
    }
    else
    {
        [self.GoogleLocs firstObject];
        NSDictionary* place =[self.GoogleLocs firstObject];
        // 3 - There is a specific NSDictionary object that gives us the location info.
        NSDictionary *geo = [place objectForKey:@"geometry"];
        // Get the lat and long for the location.
        NSDictionary *loc = [geo objectForKey:@"location"];
        // 4 - Get your name and address info for adding to a pin.
        NSString *name=[place objectForKey:@"name"];
        NSString *vicinity=[place objectForKey:@"vicinity"];
        // Create a special variable to hold this coordinate info.
        CLLocationCoordinate2D placeCoord;
        // Set the lat and long.
        placeCoord.latitude=[[loc objectForKey:@"lat"] doubleValue];
        placeCoord.longitude=[[loc objectForKey:@"lng"] doubleValue];
        // 5 - Create a new annotation.
        MapPoint *placeObject = [[MapPoint alloc] initWithName:name address:vicinity coordinate:placeCoord];
        [self.mapView addAnnotation:placeObject];
        
        
        MKCoordinateSpan zoom;
        zoom.latitudeDelta = .2f; //the zoom level in degrees
        zoom.longitudeDelta = .2f;//the zoom level in degrees
        [self.mapView setCenterCoordinate:[placeObject coordinate] animated:YES];
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([placeObject  coordinate], 200, 200);
        region.span=zoom;
        [self.mapView setRegion:region];
        [self.mapView selectAnnotation:placeObject animated:YES];
        
    }
    
    

}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
//    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    FullScreenMapViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"FullScreenMapViewController"];
//    controller.cardDet=self.cdet;
//    controller.GLocs=self.GoogleLocs;
//    controller.CmngFromParGiftCrd=YES;
//    [self.navigationController pushViewController:controller animated:YES];
    
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    // Define your reuse identifier.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    static NSString *identifier = @"MapPoint";
    
   if ([annotation isKindOfClass:[MapPoint class]]) {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
       
//       UIButton *btn=[[UIButton alloc]initWithFrame:annotationView.frame];
//    [btn addTarget:self action:@selector(annotationSelectAction) forControlEvents:UIControlEventTouchUpInside];
//       [annotationView addSubview:btn];
      annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
       
   

        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

        } else {
            annotationView.annotation = annotation;
        }
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
    
       
   
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FullScreenMapViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"FullScreenMapViewController"];
    controller.cardDet=self.cdet;
    controller.GLocs=self.GoogleLocs;
    controller.CmngFromParGiftCrd=YES;
    [self.navigationController pushViewController:controller animated:YES];

}
-(void)annotationSelectAction
{
        UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        FullScreenMapViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"FullScreenMapViewController"];
        controller.cardDet=self.cdet;
        controller.GLocs=self.GoogleLocs;
        controller.CmngFromParGiftCrd=YES;
        [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)btn_removeCard_pressed:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.view_actionSheet.transform=CGAffineTransformMakeTranslation(0.0,self.view_actionSheet.frame.size.height);
    } completion:^(BOOL finished) {
        self.view_forEdit.hidden=YES;
         [self delCard];
    }];
}
- (IBAction)btn_cancel_pressed:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
         self.view_actionSheet.transform=CGAffineTransformMakeTranslation(0.0,self.view_actionSheet.frame.size.height);
    } completion:^(BOOL finished) {
        self.view_forEdit.hidden=YES;
    }];
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
    else if (alertView.tag==4)
    {
        if (buttonIndex==0)
        {
            [self.tf_price becomeFirstResponder];
        }
    }
    else if(alertView.tag==7)
    {
        if (buttonIndex==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (IBAction)btn_link_pressed:(id)sender
{

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.cdet.card_affiliate_link]];
}
- (IBAction)btn_copy_pressed:(id)sender
{
//    NSString *copyStringverse = [[NSString alloc] initWithFormat:@"%@",self.lbl_card_num.text];
    NSString *copyStringverse = [[NSString alloc] initWithFormat:@"%@",self.cdet.card_number];

    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setString:copyStringverse];
}


#pragma mark - Animating View

- (void) runSpinAnimationOnView:(UIImageView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:- M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}



-(void) setMaskTo:(UIButton*)btn byRoundingCorners:(UIRectCorner)corners
{
    
  //[self.btn_link setTitle:[NSString stringWithFormat:@"  %@  ",self.cdet.card_link_title ] forState:UIControlStateNormal];

    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(10.0, 10.0)];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    btn.layer.mask = shape;
    [self.btn_link setTitle:[NSString stringWithFormat:@"    %@    ",self.cdet.card_link_title ] forState:UIControlStateNormal];
    [self.btn_link layoutIfNeeded];
    

}

- (IBAction)btn_locator_pressed:(id)sender
{
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FullScreenMapViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"FullScreenMapViewController"];
    controller.cardDet=self.cdet;
    controller.GLocs=self.GoogleLocs;
    controller.CmngFromParGiftCrd=YES;
    [self.navigationController pushViewController:controller animated:YES];

}
- (IBAction)btn_myLoc_pressed:(id)sender {
    
    MKCoordinateSpan zoom;
    zoom.latitudeDelta = .1f; //the zoom level in degrees
    zoom.longitudeDelta = .1f;//the zoom level in degrees
    [self.mapView setCenterCoordinate:[self.locationManager1.location coordinate] animated:YES];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([self.locationManager1.location  coordinate], 200, 200);
    region.span=zoom;
    [self.mapView setRegion:region];
}


#pragma mark-Timer
-(void)start
{
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    
}

-(void)timerFired
{
    if((currMinute>0 || currSeconds>=0) && currMinute>=0)
    {
        if(currSeconds>0)
        {
            currSeconds-=1;
        }
        
        if(currSeconds==1||currMinute==2||currMinute==3)
        {
            [self.img_refresh.layer removeAnimationForKey:@"rotationAnimation"];
            self.img_refresh.image=[UIImage imageNamed:@"ic_check_green"];

        }
        if(currSeconds==0){
            [self.img_refresh.layer removeAnimationForKey:@"rotationAnimation"];
            self.img_refresh.image=[UIImage imageNamed:@"ic_check_white"];
            [self.timer invalidate];
            self.view.userInteractionEnabled=YES;

        }
        
    }
}

#pragma mark-Textfield Delegate
-(void)adJusttf
{
    UILabel *lbl = [[UILabel alloc] init];
    //[lbl setFont:[UIFont fontWithName:@"Helvetica-Neue" size:18]];
    [lbl setFont:[UIFont boldSystemFontOfSize:20]];
    [lbl setText:self.tf_price.text];
    [lbl setNumberOfLines:0];
    [lbl setPreferredMaxLayoutWidth:self.view.frame.size.width-32];
    
    [lbl sizeToFit];
    //if(lbl.frame.size.width>self.view.frame.size.width-32)
    self.widthConstant.constant = lbl.frame.size.width+4;
    //    else
    //        self.widthConstant.constant = self.view.frame.size.width- 64;
    [self.tf_price sizeToFit];
    [self.tf_price layoutIfNeeded];

}
// the method to call on a change
- (void)textFieldDidChange:(NSNotification*)aNotification
{
   // UITextField *txt = (UITextField *)[aNotification object];
  //  [self adJusttf];
    
   //    [self.tf_price updateConstraints];
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    AlertView*alert=[[AlertView alloc]init];
    
    if (textField==self.tf_price) {
        
        if ([[self ValidateEditInfo]length]==0) {
            [self editBalApiHit];
            [self.view endEditing:YES];
        }
        else
        {
            [alert showStaticAlertWithTitle:@"" AndMessage:[self ValidateEditInfo]];
            [self.view endEditing:YES];
        }
        
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //if ((textField.text.length == 1 && [string isEqualToString:@""])||(textField.text.length>=11))
    if (textField.text.length == 1 && [string isEqualToString:@""]){
        //When detect backspace when have one character.
        return NO;
    }
    
    else
    {
       return YES;
    }
   
}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    self.tf_price.text=textField.text;
//    
//    [self.tf_price layoutIfNeeded];
//   // [self.tf_price updateConstraints];
//    return YES;
//}// return NO to disallow editing.



- (void)textFieldDidBeginEditing:(UITextField *)textField;
    {
        [self accessaryForDone];
    }

-(NSString*)ValidateEditInfo
{
    
    NSString * str=@"";
    
    if (self.tf_price.text.length==1||self.tf_price.text.length==1) {
        str=@"Please enter Number";
    }
    return str;
    
}




#pragma mark-Map Handling using search request query
/*!
 *  @brief  Show nearest location on mapview
 */
-(void)mapWork
{
    //    [self.mapView setMapType:MKMapTypeStandard];
    //    [self.mapView setShowsUserLocation:YES];
    //
    //    [self.mapView setZoomEnabled:YES];
    //    [self.mapView setScrollEnabled:YES];
    //[self.mapView setDelegate:self];
    
    ///Search
    
    // Create and initialize a search request object.
    //    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    //    request.naturalLanguageQuery =self.cdet.brandDet.bDet_name;
    
    //request.region = self.mapView.region;
    
    // Create and initialize a search object.
    //  MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    // Start the search and display the results as annotations on the map.
    //    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error)
    //     {
    //
    //         if (!error)
    //         {
    //             self.locs=response;
    //             NSLog(@"%@",response);
    //
    //             NSMutableDictionary *distances = [NSMutableDictionary dictionary];
    //
    //             for (MKMapItem *item in response.mapItems)
    //             {
    //                 CLLocation *loc = [[CLLocation alloc] initWithLatitude:item.placemark.coordinate.latitude longitude:item.placemark.coordinate.longitude];
    //
    //                 CLLocationDistance distance = [loc distanceFromLocation:self.locationManager.location];
    //
    //                 NSLog(@"Distance from Annotations - %f", distance);
    //
    //                 [distances setObject:item.placemark forKey:@( distance )];
    //             }
    //
    //             NSArray *sortedKeys = [[distances allKeys] sortedArrayUsingSelector:@selector(compare:)];
    //             NSArray *closestKeys = [sortedKeys subarrayWithRange:NSMakeRange(0, MIN(3, sortedKeys.count))];
    //
    //             NSArray *closestAnnotations = [distances objectsForKeys:closestKeys notFoundMarker:[NSNull null]];
    //             self.DlocPM=[closestAnnotations firstObject];
    //             [self.mapView addAnnotation:[closestAnnotations firstObject]];
    //
    //
    //
    //             //[self.mapView setCenterCoordinate:[[closestAnnotations firstObject] coordinate] animated:YES];
    //             MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([[closestAnnotations firstObject]coordinate], 500, 500);
    //             [self.mapView setRegion:region];
    //        }
    //         else
    //         {
    //             NSLog(@"%@",[error description]);
    //         }
    //     }];
    
    
    //[self googleNearestLoc];
}



//-(float)kilometresBetweenPlace1:(CLLocationCoordinate2D) currentLocation andPlace2:(CLLocationCoordinate2D) place2
//{
//    CLLocation *userLoc = [[CLLocation alloc] initWithLatitude:currentLocation.latitude longitude:currentLocation.longitude];
//    CLLocation *poiLoc = [[CLLocation alloc] initWithLatitude:place2.latitude longitude:place2.longitude];
//    //CLLocationDistance dist = [userLoc getDistanceFrom:poiLoc]/(1000*distance);
//    
//    CLLocationDistance dist=[userLoc distanceFromLocation:poiLoc];
//    
//    
//    NSString *strDistance = [NSString stringWithFormat:@"%.2f", dist];
//    NSLog(@"%@",strDistance);
//    return [strDistance floatValue];
//}





-(void)extra
{
    //           MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    //
    //                    point = [closestAnnotations firstObject];
    //
    //                      point.title = @"Where am I?";
    //                      point.subtitle = @"I'm here!!!";
    //
    // point.title=self.cdet.brandDet.bDet_name;
    
    //  [self.mapView addAnnotation:point];
    
    
    
    
    
    
    //         NSMutableArray *placemarks = [NSMutableArray array];
    //         for (MKMapItem *item in response.mapItems) {
    //             [placemarks addObject:item.placemark];
    //         }
    
    //          //Add an annotation
    //            //
    //
    //
    //
    
    //         [self.mapView removeAnnotations:[self.mapView annotations]];
    //         //[self.mapView addAnnotations:placemarks];
    //
    //
    //         [self.mapView showAnnotations:placemarks animated:NO];
}

//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
//{

//
//    ///Search
//
//    // Create and initialize a search request object.
//    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
//    request.naturalLanguageQuery =self.cdet.brandDet.bDet_name;
//    request.region = self.mapView.region;
//
//    // Create and initialize a search object.
//    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
//
//    // Start the search and display the results as annotations on the map.
//    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error)
//    {
//        NSMutableArray *placemarks = [NSMutableArray array];
//        for (MKMapItem *item in response.mapItems) {
//            [placemarks addObject:item.placemark];
//        }
//        [self.mapView removeAnnotations:[self.mapView annotations]];
//        [self.mapView showAnnotations:placemarks animated:NO];
//    }];
//
//
//
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate,800, 800);
//    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];


//}

@end
