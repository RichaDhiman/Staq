//
//  FamilyShareViewController.m
//  gava
//
//  Created by RICHA on 10/17/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "FamilyShareViewController.h"

@interface FamilyShareViewController ()
@property(nonatomic,retain)UIPanGestureRecognizer *panGestureRecognizer;
@property(nonatomic,retain)NSArray *SyncFriends;
@property(nonatomic,retain)NSMutableArray* filteredPlacesNames;
@property(nonatomic,retain)NSMutableArray* filteredPlacesTypes;
@property(nonatomic,retain)NSMutableArray *Names;
@property(nonatomic,retain)NSArray *MyCards;

@end

@implementation FamilyShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view_top.hidden=YES;
    self.view_middle.hidden=YES;
    [self viewHelper];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewHelper
{
    self.MyCards=[[NSArray alloc]init];
    
    self.lbl_versionNo.text=[NSString stringWithFormat:@"v%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissMenu)];
    
    [self.img_back_img addGestureRecognizer:tap];
    self.panGestureRecognizer=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
    self.panGestureRecognizer.delegate = self;
    [self.panGestureRecognizer setCancelsTouchesInView:NO];
    [self.view_sidePanel addGestureRecognizer:self.panGestureRecognizer];
    
    
    
    UIScreenEdgePanGestureRecognizer *leftEdgeGesture=[[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handleLeftEdgeGesture:)];
    [leftEdgeGesture setEdges:UIRectEdgeLeft];
    
    [leftEdgeGesture setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:leftEdgeGesture];
    
    
    self.view_sidePanel.transform=CGAffineTransformMakeTranslation(-self.view_sidePanel.frame.size.width, 0.0);
    self.img_back_img.alpha=0.0;
    self.img_back_img.hidden=YES;
    self.img_back_img.userInteractionEnabled=NO;
    self.view_sidePanel.hidden=YES;
    
    UserProfile *up=[[UserProfile alloc]init];
    up=[UserProfile getProfile];

    [self.lbl_email setTitle:up.user_email forState:UIControlStateNormal];
    
    self.lbl_total.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"total"];
    self.lbl_NoofCards.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"NoOfCards"];
    
    
    [self.tbl_familyShare setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
  
    [self getSyncApiHit];
    
    
}

-(void)getSyncApiHit
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
    dict=[NSDictionary dictionaryWithObjectsAndKeys:ud.user_access_token,@"access_token", nil];
    
    [IOSRequest uploadData:Url_GetSyncUsers parameters:dict imageData:nil success:^(NSDictionary *responseStr)
     {
         [App StopAnimating];
         self.view.userInteractionEnabled=YES;
         
         if ([[responseStr valueForKey:@"success"] integerValue]==1)
         {
             [UserProfile saveSyncFrndsInfo:[responseStr valueForKey:@"users"]];
             [self getSyncFrnds];
             
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

-(void)getSyncFrnds
{
    self.SyncFriends=[[NSArray alloc]init];
    self.SyncFriends=[UserProfile getSyncFrndsInfo];
    
    if (self.SyncFriends.count==0) {
        self.tbl_familyShare.hidden=YES;
        self.view_top.hidden=NO;
        self.view_middle.hidden=NO;
    }
    else
    {
        self.tbl_familyShare.hidden=NO;
        self.view_top.hidden=YES;
        self.view_middle.hidden=YES;
       // [self.tbl_familyShare reloadData];
        [self.tbl_familyShare performSelectorOnMainThread:@selector(reloadData)
                                         withObject:nil
                                      waitUntilDone:NO];
    }
 
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

#pragma mark - gesture handler
-(void)moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)gesture{
    //    NSLog(@"pan");
    
    
    self.img_back_img.hidden=NO;
    if ([gesture state]== UIGestureRecognizerStateChanged) {
        CGPoint touchLocation = [gesture locationInView:self.view];
        
        //        NSLog(@"Changed %f %f",touchLocation.x,touchLocation.y);
        CGPoint translation = [gesture translationInView:self.view_sidePanel];
        //        NSLog(@"transform %f",translation.x);
        if (touchLocation.x >= self.view_sidePanel.frame.size.width || touchLocation.x == 5) {
            NSLog(@"return");
            return ;
        }
        else if (touchLocation.x <= 5) {
            NSLog(@"return");
            return ;
        }
        else
        {
            if (translation.x <= 0) {
                self.view_sidePanel.transform=CGAffineTransformMakeTranslation(translation.x,0);
            }
            
            
            
        }
        
    }
    else if ([gesture state]== UIGestureRecognizerStateEnded) {
        CGPoint touchLocation = [gesture locationInView:self.view];
        //        NSLog(@"Ended %f %f",touchLocation.x,touchLocation.y);
        if (touchLocation.x >= self.view_sidePanel.frame.size.width/2) {
            [UIView animateWithDuration:0.2 animations:^{
                self.view_sidePanel.transform=CGAffineTransformIdentity;
                
            }];
            
            
        }
        else if (touchLocation.x <= self.view_sidePanel.frame.size.width/2) {
            [UIView animateWithDuration:0.2 animations:^{
                self.view_sidePanel.transform=CGAffineTransformMakeTranslation(-self.view_sidePanel.frame.size.width,0);
                
            } completion:^(BOOL finished) {
                //self.ViewObj.overLayView.hidden=YES;
                self.img_back_img.hidden=YES;
            }];
            
        }
    }
    
}


- (void)handleLeftEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    //    NSLog(@"edge");
    // [self.ViewObj.view setHidden:NO];
    //self.ViewObj.overLayView.hidden=NO;
    self.view_sidePanel.hidden=NO;
    self.img_back_img.hidden=NO;
    self.img_back_img.alpha=0.7;
    self.img_back_img.userInteractionEnabled=YES;
    
    //[self.ViewObj.slideTableView reloadData];
    // Get the current view we are touching
    if ([gesture state]== UIGestureRecognizerStateChanged) {
        CGPoint touchLocation = [gesture locationInView:self.view];
        NSLog(@"Changed %f %f",touchLocation.x,touchLocation.y);
        float tranform = self.view_sidePanel.frame.size.width-touchLocation.x;
        if (touchLocation.x >= self.view_sidePanel.frame.size.width || touchLocation.x == 5) {
            NSLog(@"return");
            return ;
        }
        else if (touchLocation.x <= 5) {
            NSLog(@"return");
            return ;
        }
        else
        {
            self.view_sidePanel.transform=CGAffineTransformMakeTranslation(-tranform,0);
            
        }
        
    }
    else if ([gesture state]== UIGestureRecognizerStateEnded) {
        CGPoint touchLocation = [gesture locationInView:self.view];
        //        NSLog(@"Ended %f %f",touchLocation.x,touchLocation.y);
        if (touchLocation.x >= self.view_sidePanel.frame.size.width/2) {
            [UIView animateWithDuration:0.2 animations:^{
                self.view_sidePanel.transform=CGAffineTransformIdentity;
                
            }];
            
        }
        else if (touchLocation.x <= self.view_sidePanel.frame.size.width/2) {
            [UIView animateWithDuration:0.2 animations:^{
                self.view_sidePanel.transform=CGAffineTransformMakeTranslation(-self.view_sidePanel.frame.size.width,0);
                
            } completion:^(BOOL finished) {
                // self.ViewObj.overLayView.hidden=YES;
                self.img_back_img.hidden=YES;
                self.img_back_img.alpha=0.0;
                self.img_back_img.userInteractionEnabled=NO;
            }];
            
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // You can customize the way in which gestures can work
    // Enabling multiple gestures will allow all of them to work together, otherwise only the topmost view's gestures will work (i.e. PanGesture view on bottom)
    if (gestureRecognizer == self.panGestureRecognizer ) {
        return NO;
    }
    else
        return YES;
}

/*!
 *  @brief  called on tap gesture
 */

-(void)dismissMenu
{
    [UIView animateWithDuration:0.3 animations:^{
        self.view_sidePanel.transform=CGAffineTransformMakeTranslation(-self.view_sidePanel.frame.size.width, 0.0);
    } completion:^(BOOL finished) {
        
        self.view_sidePanel.hidden=YES;
        self.img_back_img.hidden=YES;
        self.img_back_img.alpha=0.0;
        self.img_back_img.userInteractionEnabled=NO;
        
    }];
}

#pragma mark-Button Actions

- (IBAction)btn_menu_pressed:(id)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view_sidePanel.transform=CGAffineTransformIdentity;
        self.img_back_img.alpha=0.7;
        self.img_back_img.userInteractionEnabled=YES;
        self.view_sidePanel.hidden=NO;
        self.img_back_img.hidden=NO;
        
    } completion:nil];

}

- (IBAction)btn_wallet_pressed:(id)sender {
//    [UIView animateWithDuration:0.3 animations:^{
//        self.view_sidePanel.transform=CGAffineTransformMakeTranslation(-self.view_sidePanel.frame.size.width, 0.0);
//    } completion:^(BOOL finished)
//     {
//         self.view_sidePanel.hidden=YES;
//         self.img_back_img.hidden=YES;
//         
//         self.img_back_img.alpha=0.0;
//         self.img_back_img.userInteractionEnabled=NO;
//         
//     }];
    
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)btn_addGiftCard_pressed:(id)sender {
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddGiftCardViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"AddGiftCardViewController"];
    
    [self.navigationController pushViewController:controller animated:YES];

}

- (IBAction)btn_map_pressed:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.view_sidePanel.transform=CGAffineTransformMakeTranslation(-self.view_sidePanel.frame.size.width, 0.0);
    } completion:^(BOOL finished) {
        
        self.view_sidePanel.hidden=YES;
        self.img_back_img.hidden=YES;
        self.img_back_img.alpha=0.0;
        self.img_back_img.userInteractionEnabled=NO;
        
    }];
    
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FullScreenMapViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"FullScreenMapViewController"];
    //    controller.cardDet=self.cdet;
    controller.cmngFromMainViewController=YES;
 
    controller.NamesArrayFromMain=[[NSUserDefaults standardUserDefaults]valueForKey:@"PlacesNames"];
    controller.TypesArrayFromMain=[[NSUserDefaults standardUserDefaults]valueForKey:@"PlacesTypes"];
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)btn_logout_pressed:(id)sender {
    
    // SCLAlertView *alert=[[SCLAlertView alloc]init];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Do you want to sign out?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];

}

- (IBAction)btn_familyShare_pressed:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.view_sidePanel.transform=CGAffineTransformMakeTranslation(-self.view_sidePanel.frame.size.width, 0.0);
        [self getSyncApiHit];
        
    } completion:^(BOOL finished)
     {
         self.view_sidePanel.hidden=YES;
         self.img_back_img.hidden=YES;
         
         self.img_back_img.alpha=0.0;
         self.img_back_img.userInteractionEnabled=NO;
         
     }];
    
    
}
- (IBAction)btn_sync_pressed:(id)sender {
    
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddCodeToSyncViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"AddCodeToSyncViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)btn_addFamily_pressed:(id)sender {
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ContactsViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"ContactsViewController"];
    [self.navigationController pushViewController:controller animated:YES];
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
    else
    {
        if (buttonIndex==1)
        {
            [self IsSignout];
        }
    }
    
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

-(void)IsSignout
{
    [self SignOutApi];
}
/*!
 *  @brief  signout api hit
 */
-(void)SignOutApi
{
    AppDelegate *App=(AppDelegate*)[UIApplication sharedApplication].delegate;
    UserProfile *up=[[UserProfile alloc]init];
    up=[UserProfile getProfile];
    AlertView *alert=[[AlertView alloc]init];
    [App StartAnimating];
    self.view.userInteractionEnabled=NO;
    
    [self.view endEditing:YES];
    [self resignFirstResponder];
    NSDictionary *dict = [NSDictionary dictionary];
    dict=[[NSDictionary alloc]initWithObjectsAndKeys:up.user_access_token,@"access_token",nil];
    [IOSRequest uploadData:Url_logout parameters:dict imageData:nil success:^(NSDictionary *responseStr)
     {
         [App StopAnimating];
         self.view.userInteractionEnabled=YES;
         
         if ([[responseStr valueForKey:@"success"]integerValue]==1)
         {
          
             [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user"];
             [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"total"];
             [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"cards"];
             [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"NoofCards"];
             [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"PlacesNames"];
             [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"PlacesTypes"];
             [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"result"];
             [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"users"];
             [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"PlacesNames"];
             [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"PlacesTypes"];
             

             [[NSUserDefaults standardUserDefaults]synchronize];
             
             ///////facebook token clearance
             [[FBSDKLoginManager new] logOut];
             
             self.img_back_img.hidden=YES;
             self.view_sidePanel.hidden=YES;
             
             [self performSegueWithIdentifier:@"show_firstViewController" sender:self];
         }
         
         else if([[responseStr valueForKey:@"success"]integerValue]==2)
         {
             UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Token expired! Please login." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             alert1.tag=2;
             [alert1 show];
             
         }
         
     } failure:^(NSError *error) {
         [App StopAnimating];
         self.view.userInteractionEnabled=YES;
         [alert showStaticAlertWithTitle:@"" AndMessage:@"Please check your Internet Connection!"];
         
         
     }];
}

#pragma mark-TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.SyncFriends.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FamilyShareTableCell *cell=[tableView dequeueReusableCellWithIdentifier:@"FamilyShareTableCell" forIndexPath:indexPath];
    
    [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:85.0f];
    cell.delegate =self;
    cell.tag=indexPath.row;
    
   
    
    [cell configure:[self.SyncFriends objectAtIndex:indexPath.row]];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tbl_familyShare deselectRowAtIndexPath:indexPath animated:NO];
}


- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:245.0/255.0 green:94.0/255.0 blue:93.0/255.0 alpha:1.0] title:@"Remove"];
    return rightUtilityButtons;
}


- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index
{
    
}
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    FamilyShareTableCell *cell1=(FamilyShareTableCell*)cell;
    
    if (index==0)
    {
        
        [self.view endEditing:YES];
        [self resignFirstResponder];
        AppDelegate *App=(AppDelegate*)[UIApplication sharedApplication].delegate;
        AlertView *alert=[[AlertView alloc]init];
        UserProfile *ud=[[UserProfile alloc]init];
        ud=[UserProfile getProfile];
        
        
        UserProfile *fd=[[UserProfile alloc]init];
        fd=[self.SyncFriends objectAtIndex:cell1.tag];
        
        [App StartAnimating];
        self.view.userInteractionEnabled=NO;
        
        NSDictionary *dict=[[NSDictionary alloc]init];
        dict=[NSDictionary dictionaryWithObjectsAndKeys:ud.user_access_token,@"access_token",fd.user_id,@"other_id", nil];
        
        [IOSRequest uploadData:Url_UnsyncUsers parameters:dict imageData:nil success:^(NSDictionary *responseStr)
         {
             [App StopAnimating];
             self.view.userInteractionEnabled=YES;
             
             if ([[responseStr valueForKey:@"success"] integerValue]==1)
             {
                 [UserProfile saveSyncFrndsInfo:[responseStr valueForKey:@"users"]];
                 [self getSyncFrnds];
                 
                 [CardDetails saveCardsInfo:[responseStr valueForKey:@"cards"]];
                 [self GetCards];
                 [[NSUserDefaults standardUserDefaults]setValue:[responseStr valueForKey:@"total"] forKey:@"total"];
                 [self.lbl_total setText:[responseStr valueForKey:@"total"]];
                 
             }
             else if([[responseStr valueForKey:@"success"]integerValue]==2)
             {
                 UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Token expired! Please login." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 alert1.tag=2;
                 [alert1 show];
             }
         }
                       failure:^(NSError *error)
         {
             self.view.userInteractionEnabled=YES;
             [App StopAnimating];
             
             [alert showStaticAlertWithTitle:@"" AndMessage:@"Please check your Internet Connection!"];
         }];
        
        [cell hideUtilityButtonsAnimated:YES];
    }
}
- (BOOL)swipeableTableViewCell:(FamilyShareTableCell *)cell canSwipeToState:(SWCellState)state
{
    return YES;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
    
    
}
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    return YES;
}

#pragma mark-swipeable row
- (void)hideUtilityButtonsAnimated:(BOOL)animated
{
    
}

- (void)showRightUtilityButtonsAnimated:(BOOL)animated
{
    
}


-(void)GetCards
{
    self.MyCards=[CardDetails getCardsInfo];
    
    self.filteredPlacesNames=[[NSMutableArray alloc]init];
    self.Names=[[NSMutableArray alloc]init];
    self.filteredPlacesTypes=[[NSMutableArray alloc]init];
    
    for (CardDetails *temp in self.MyCards)
    {
        if ([self.Names containsObject:temp.brandDet.bDet_name]) {
            
        }
        else
        {
            if ([temp.brandDet.bDet_name rangeOfString:@"\""].location != NSNotFound)
            {
                NSString *str=[[NSString alloc]init];
                str = [temp.brandDet.bDet_name stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                [self.filteredPlacesNames addObject:[NSString stringWithFormat:@"\"%@\"",str]];
                [self.Names addObject:temp.brandDet.bDet_name];
            }
            else
            {
                [self.filteredPlacesNames addObject:[NSString stringWithFormat:@"\"%@\"",temp.brandDet.bDet_name]];
                [self.Names addObject:temp.brandDet.bDet_name];
            }
            [self.filteredPlacesTypes addObject:temp.brandDet.bDet_brand_type];
            
        }
        
    }
    
    self.lbl_NoofCards.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.MyCards.count ];
    [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%lu",(unsigned long)self.MyCards.count ] forKey:@"NoOfCards"];
    
    [[NSUserDefaults standardUserDefaults]setValue:self.filteredPlacesNames forKey:@"PlacesNames"];
    [[NSUserDefaults standardUserDefaults]setValue:self.filteredPlacesTypes forKey:@"PlacesTypes"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
