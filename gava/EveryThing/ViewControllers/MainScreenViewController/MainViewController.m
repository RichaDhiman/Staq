
//
//  MainViewController.m
//  gava
//
//  Created by RICHA on 9/4/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property(nonatomic,retain)UIBarButtonItem *MenuButton;
@property(nonatomic,retain)UIBarButtonItem *AddButton;
@property(nonatomic,retain)UIDynamicAnimator *animator;
@property(nonatomic)BOOL alreadyLoading;
@property(assign,nonatomic)CGPoint lastContentOffset;
@property(nonatomic)CGPoint currentOffset;
@property(nonatomic,retain)NSString* PlacesNames;
@property(nonatomic,retain)NSString* PlacesTypes;
@property(nonatomic,retain)UIPanGestureRecognizer *panGestureRecognizer;
@property(nonatomic,retain)NSMutableArray* filteredPlacesNames;
@property(nonatomic,retain)NSMutableArray* filteredPlacesTypes;
@property(nonatomic,retain)NSMutableArray *Names;




@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.lbl_versionNum.text=[NSString stringWithFormat:@"v%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];

    
    AlertView *alert=[[AlertView alloc]init];
    
    if([CLLocationManager locationServicesEnabled] &&
       [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        // show the map
    }
    else {
        // show error
        [alert showStaticAlertWithTitle:@"" AndMessage:@"Turn On Location Services to allow 'STAQ' to determine your location."];
    }
    
    [self GetCards:NO];
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    
    self.alreadyLoading=YES;
    self.lbl_NoResult.hidden=YES;
    self.img_ifNoCard.hidden=YES;
    self.searchBar.hidden=YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissMenu)];
    
    [self.img_backimg addGestureRecognizer:tap];
    
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(AddGiftCard)];
    
    [self.img_ifNoCard addGestureRecognizer:tap2];
    
   self.panGestureRecognizer=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveViewWithGestureRecognizer:)];
    self.panGestureRecognizer.delegate = self;
    [self.panGestureRecognizer setCancelsTouchesInView:NO];
    [self.view_sidePanel addGestureRecognizer:self.panGestureRecognizer];
    

    
    UIScreenEdgePanGestureRecognizer *leftEdgeGesture=[[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handleLeftEdgeGesture:)];
    [leftEdgeGesture setEdges:UIRectEdgeLeft];
   
     [leftEdgeGesture setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:leftEdgeGesture];


    self.img_backimg.alpha=0.0;
    self.img_backimg.hidden=YES;
    self.img_backimg.userInteractionEnabled=NO;
    self.view_sidePanel.hidden=YES;
    self.view_sidePanel.transform=CGAffineTransformMakeTranslation(-self.view_sidePanel.frame.size.width, 0.0);

    [self getAccessToken:YES];
}




//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    UIView *vi=(UIView *)object;
//    NSLog(@"%f",vi.frame.origin.x);
//    float av=fabsf(vi.frame.origin.x);
//    NSLog(@"%f",av/250);
//    self.img_backimg.alpha=(1-(av/250))*0.6;
//    
//}




/*!
 *  @brief  Did everything that i want to do before appearance of viewcontroller
 */
-(void)viewHelper
{
    self.FilteredCards=[[NSMutableArray alloc]init];
    //float height=(([UIScreen mainScreen].bounds.size.width-16)*5)/9;
    float height=(([UIScreen mainScreen].bounds.size.width-16)*10)/16;

    [self.img_ifNoCard setFrame:CGRectMake(8, 72,[UIScreen mainScreen].bounds.size.width-16,height)];
    
    UserProfile *up=[[UserProfile alloc]init];
    up=[UserProfile getProfile];
    self.img_ifNoCard.layer.cornerRadius=4;
    [self.btn_emailAd setTitle:up.user_email forState:UIControlStateNormal];
    
    [self searchBarCancelButtonClicked:nil];
    
    if (self.alreadyLoading==YES)
      [self getAccessToken:NO];
    
   }



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.img_backimg.alpha=0.0;
    self.img_backimg.hidden=YES;
    self.img_backimg.userInteractionEnabled=NO;
    self.view_sidePanel.hidden=YES;
    self.view_sidePanel.transform=CGAffineTransformMakeTranslation(-self.view_sidePanel.frame.size.width, 0.0);

    if ([[[ NSUserDefaults standardUserDefaults]valueForKey:@"cmgFromSyncScreen"]isEqualToString:@"1"])
    {
        UIAlertView *alert4=[[UIAlertView alloc]initWithTitle:@"" message:@"Gift Cards Shared" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert4.tag=4;
        [alert4 show];
    }
    
    
    
    
    for(UIView *subView in self.searchBar.subviews){
        if([subView isKindOfClass:UITextField.class]){
            [(UITextField*)subView setTextColor:[UIColor whiteColor]];
        }
    }
    
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UILabel appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor whiteColor]];
    
    [[UIBarButtonItem appearanceWhenContainedIn: [UISearchBar class], nil] setTintColor:[UIColor whiteColor]];
    
    [[UITextField appearanceWhenContainedIn: [UISearchBar class], nil]
     setFont: [UIFont systemFontOfSize: 15]];
    
    [self.searchBar setImage:[UIImage imageNamed:@"ic_search_white-1"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [self.searchBar setImage:[UIImage imageNamed:@"ic_cross_white"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    [self.searchBar setImage:[UIImage imageNamed:@"ic_cross_white"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateSelected];
    
    self.view_sidePanel.hidden=YES;
    [self viewHelper];
    
//    [self.view_sidePanel addObserver:self
//                          forKeyPath:@"transform"
//                             options: NSKeyValueObservingOptionNew
//                             context:nil];
    

}

-(void)viewWillDisappear:(BOOL)animated
{
      [self.view endEditing:YES];
      self.searchBar.text=@"";
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view_sidePanel.transform=CGAffineTransformMakeTranslation(-self.view_sidePanel.frame.size.width, 0.0);
    } completion:^(BOOL finished) {
        self.view_sidePanel.hidden=YES;
        self.img_backimg.hidden=YES;
    }];
//    [self.view_sidePanel removeObserver:self forKeyPath:@"transform"];

}


/*!
 *  @brief  api to get cards will be hit
 *
 *  @param isLoaderActive bool value will be yes if want to show loader
 */
-(void)getAccessToken:(BOOL)isLoaderActive
{
    AppDelegate  *App=(AppDelegate*)[UIApplication sharedApplication].delegate;
    if (isLoaderActive==YES){
        [App StartAnimating];
       self.view.userInteractionEnabled=NO;
    }
   // SCLAlertView *alert=[[SCLAlertView alloc]init];
    AlertView *alert=[[AlertView alloc]init];
    UserProfile *ud=[[UserProfile alloc]init];
    ud=[UserProfile getProfile];
    [self.view endEditing:YES];
    [self resignFirstResponder];
    
    NSDictionary *dict = [NSDictionary dictionary];
       dict=[[NSDictionary alloc]initWithObjectsAndKeys:ud.user_access_token,@"access_token",nil];
    
    [IOSRequest uploadData:Url_myCards parameters:dict imageData:nil success:^(NSDictionary *responseStr)
     {
         [App StopAnimating];
        self.view.userInteractionEnabled=YES;
         
         if ([[responseStr valueForKey:@"success"]integerValue]==1)
         {
             [CardDetails saveCardsInfo:[responseStr valueForKey:@"cards"]];
             if (isLoaderActive==YES) {
                [self GetCards:NO];
             }
             else if(isLoaderActive==NO)
             {
                 [self GetCards:YES];
             }
             
             [[NSUserDefaults standardUserDefaults]setValue:[responseStr valueForKey:@"total"] forKey:@"total"];
             [[NSUserDefaults standardUserDefaults]synchronize];
             
            self.lbl_total.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"total"];
         
         
         }
        else if([[responseStr valueForKey:@"success"]integerValue]==2)
         {
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Token expired! Please login." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             alert1.tag=2;
            if (isLoaderActive==NO)
                [alert1 show];
            
            }
         else
         {
             [alert showStaticAlertWithTitle:@"" AndMessage:[responseStr valueForKey:@"msg"]];
         }
         
         if (self.MyCards.count==0)
         {
             self.mycollectionView.hidden=YES;
             self.img_ifNoCard.hidden=NO;
             
         }
         else
         {
             self.mycollectionView.hidden=NO;
             self.img_ifNoCard.hidden=YES;
             
         }
       }
         failure:^(NSError *error)
     {
         [App StopAnimating];
        self.view.userInteractionEnabled=YES;
         if (isLoaderActive==NO)
        [alert showStaticAlertWithTitle:@"" AndMessage:@"Please check your Internet Connection!"];
    }];
}




/*!
 *  @brief  Function to fetch Cards
 */
-(void)GetCards:(BOOL)isreloaded
{
    self.MyCards=[CardDetails getCardsInfo];
    self.FilteredCards=[[CardDetails getCardsInfo] mutableCopy];
    
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
   
    
    self.lbl_cards_count.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.MyCards.count ];
    [[NSUserDefaults standardUserDefaults]setValue:self.lbl_cards_count.text forKey:@"NoOfCards"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
        self.lbl_total.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"total"];
   // [self.mycollectionView reloadData];
    
    if (isreloaded==YES) {
        
        [self.mycollectionView performSelectorOnMainThread:@selector(reloadData)
                                                withObject:nil
                                             waitUntilDone:NO];
    }
    

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

             
             
            ///////facebook token clearance
             [[FBSDKLoginManager new] logOut];
          
             self.img_backimg.hidden=YES;
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

#pragma mark-CollectionView Handling

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.MyCards.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    mainCollectionCell *cell = (mainCollectionCell *)[self.mycollectionView dequeueReusableCellWithReuseIdentifier:@"mainCollectionCell" forIndexPath:indexPath];
        [cell ConfigureCell:[self.MyCards objectAtIndex:indexPath.row]];
    
        return cell;
 }

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.currentOffset = scrollView.contentOffset;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //float height=(([UIScreen mainScreen].bounds.size.width-16)*5)/9;
    float height=(([UIScreen mainScreen].bounds.size.width-16)*9)/16;

    return CGSizeMake([UIScreen mainScreen].bounds.size.width-16 ,height+16);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.btn_add.hidden=NO;
    self.btn_search.hidden=NO;
    self.btn_menu.hidden=NO;
    self.searchBar.hidden=YES;
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ParticularGiftCardViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"ParticularGiftCardViewController"];
    
    CardDetails *cd=[[CardDetails alloc]init];
    cd=[self.MyCards objectAtIndex:indexPath.row];
    controller.cdet=cd;
    
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark-Button Handling
- (IBAction)btn_wallet_pressed:(id)sender
{
    self.alreadyLoading=NO;
        [UIView animateWithDuration:0.3 animations:^{
        self.view_sidePanel.transform=CGAffineTransformMakeTranslation(-self.view_sidePanel.frame.size.width, 0.0);
        } completion:^(BOOL finished)
    {
        self.view_sidePanel.hidden=YES;
        self.img_backimg.hidden=YES;
        
        self.img_backimg.alpha=0.0;
        self.img_backimg.userInteractionEnabled=NO;
     
    }];

    [self viewHelper];

}

- (IBAction)btn_map_pressed:(id)sender
{
    self.alreadyLoading=NO;
    [UIView animateWithDuration:0.3 animations:^{
         self.view_sidePanel.transform=CGAffineTransformMakeTranslation(-self.view_sidePanel.frame.size.width, 0.0);
    } completion:^(BOOL finished) {
        
        self.view_sidePanel.hidden=YES;
        self.img_backimg.hidden=YES;
        self.img_backimg.alpha=0.0;
        self.img_backimg.userInteractionEnabled=NO;

    }];
    
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FullScreenMapViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"FullScreenMapViewController"];
//    controller.cardDet=self.cdet;
    controller.cmngFromMainViewController=YES;
//    controller.BrandNames=self.PlacesNames;
//    controller.BrandTypes=self.PlacesTypes;
    controller.NamesArrayFromMain=self.filteredPlacesNames;
    controller.TypesArrayFromMain=self.filteredPlacesTypes;
    
    
    [[NSUserDefaults standardUserDefaults]setValue:self.filteredPlacesNames forKey:@"PlacesNames"];
    [[NSUserDefaults standardUserDefaults]setValue:self.filteredPlacesTypes forKey:@"PlacesTypes"];
        [[NSUserDefaults standardUserDefaults]synchronize];

    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)btn_giftCard_pressed:(id)sender
{
    self.alreadyLoading=NO;
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddGiftCardViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"AddGiftCardViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)btn_logout_pressed:(id)sender
{
    self.alreadyLoading=NO;
   // SCLAlertView *alert=[[SCLAlertView alloc]init];
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Do you want to sign out?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
}


- (IBAction)btn_addCard_pressed:(id)sender
{
    self.alreadyLoading=NO;
    self.view_sidePanel.hidden=YES;
    self.img_backimg.hidden=YES;
    self.lbl_NoResult.hidden=YES;
    
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddGiftCardViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"AddGiftCardViewController"];
     [self.navigationController pushViewController:controller animated:YES];
}


-(void)AddGiftCard
{
    self.alreadyLoading=NO;
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddGiftCardViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"AddGiftCardViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)btn_menu_pressed:(id)sender
{
    
    [UIView animateWithDuration:0.3 animations:^{
       self.view_sidePanel.transform=CGAffineTransformIdentity;
        self.img_backimg.alpha=0.7;
        self.img_backimg.userInteractionEnabled=YES;
        self.view_sidePanel.hidden=NO;
        self.img_backimg.hidden=NO;
        
    } completion:nil];
 }

- (IBAction)btn_search_pressed:(id)sender
{
    self.alreadyLoading=NO;
    
    self.searchBar.showsCancelButton = YES;
    self.view_sidePanel.hidden=YES;
    self.img_backimg.hidden=YES;
    self.btn_add.hidden=YES;
    self.btn_search.hidden=YES;
    self.btn_menu.hidden=YES;
    self.searchBar.hidden=NO;
    
    [self.searchBar becomeFirstResponder];
        [UIView animateWithDuration:0.3 animations:^{
        self.cnst_ldngSrch.constant=0;
        //[self.view layoutIfNeeded];
    } completion:nil];
    
}
- (IBAction)btn_add_pressed:(id)sender
{
    self.alreadyLoading=NO;
    
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddGiftCardViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"AddGiftCardViewController"];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (IBAction)btn_familyShare_Pressed:(id)sender {
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FamilyShareViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"FamilyShareViewController"];
    
    [self.navigationController pushViewController:controller animated:YES];
    
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


/*!
 *  @brief  To check direction of gesture
 *
 *  @param gesture current gesture
 */
-(void)handleGesture:(UISwipeGestureRecognizer *)gesture
{
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft)
         [UIView animateWithDuration:0.3 animations:^{
            self.view_sidePanel.transform=CGAffineTransformMakeTranslation(-self.view_sidePanel.frame.size.width, 0.0);

            } completion:^(BOOL finished) {
            self.view_sidePanel.hidden=YES;
            self.img_backimg.hidden=YES;
            
            self.img_backimg.alpha=0.0;
            self.img_backimg.userInteractionEnabled=NO;

        }];
        
 }


#pragma mark-Search Handling
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.img_ifNoCard.hidden=YES;
    
    self.searchBar.showsCancelButton = YES;
    NSString* filter = @"%K CONTAINS[cd] %@";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:filter, @"brandDet.bDet_name", searchText];
    self.MyCards = [[self.FilteredCards filteredArrayUsingPredicate:predicate] mutableCopy];
    //[self.mycollectionView reloadData];
    [self.mycollectionView performSelectorOnMainThread:@selector(reloadData)
                                     withObject:nil
                                  waitUntilDone:NO];
    
    self.lbl_NoResult.hidden=(self.MyCards.count==0)?NO:YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    [self resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.alreadyLoading=NO;
    self.lbl_NoResult.hidden=YES;
    self.btn_add.hidden=NO;
    self.btn_search.hidden=NO;
    self.btn_menu.hidden=NO;
    self.searchBar.hidden=YES;
    [UIView animateWithDuration:0.3 animations:^{
     self.cnst_ldngSrch.constant= [UIScreen mainScreen].bounds.size.width;

    } completion:nil];
    [self.view endEditing:YES];
     self.searchBar.text=@"";
    [self getAccessToken:NO];
}

/*!
 *  @brief  Func to show Side Panel on Menu button click
 */


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
        if (buttonIndex==0) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cmgFromSyncScreen"];
            [[NSUserDefaults standardUserDefaults]synchronize];
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


#pragma mark - gesture handler
-(void)moveViewWithGestureRecognizer:(UIPanGestureRecognizer *)gesture{
    //    NSLog(@"pan");
    
    
    self.img_backimg.hidden=NO;
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
                self.img_backimg.hidden=YES;
            }];
            
        }
    }
    
}


- (void)handleLeftEdgeGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    //    NSLog(@"edge");
   // [self.ViewObj.view setHidden:NO];
    //self.ViewObj.overLayView.hidden=NO;
    self.view_sidePanel.hidden=NO;
    self.img_backimg.hidden=NO;
    self.img_backimg.alpha=0.7;
    self.img_backimg.userInteractionEnabled=YES;

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
                self.img_backimg.hidden=YES;
                self.img_backimg.alpha=0.0;
                self.img_backimg.userInteractionEnabled=NO;
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
        self.img_backimg.hidden=YES;
        self.img_backimg.alpha=0.0;
        self.img_backimg.userInteractionEnabled=NO;
        
    }];
}



#pragma mark-unwind Function
/*!
 *  @brief  To Return back to this Controller from other Controller
 *
 *  @param unwindSegue <#unwindSegue description#>
 */
-(IBAction)unwindMainViewController:(UIStoryboardSegue*)unwindSegue
{
    UIViewController* sourceViewController = unwindSegue.sourceViewController;
    if ([sourceViewController isKindOfClass:[AddCodeToSyncViewController class]])
    {
        NSLog(@"Coming from AddCodeToSyncViewController!");
    }
}



/*!
 *  @brief  if you don't want to implement the native back option in particular view controller then use this
 *
 *  @param BOOL yes mean implement
 *
 *  @return <#return value description#>
 */

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//        
//        if (!([[self.navigationController.viewControllers lastObject] isKindOfClass:[TabViewController class]] || [[self.navigationController.viewControllers lastObject] isKindOfClass:[LoginViewController class]] || [[self.navigationController.viewControllers lastObject] isKindOfClass:[MainChatViewController class]])) {
//                return true;
//            }
//    
//        return false;
//}

/*!
 *  @brief  this to give side panel a bouncy effect
 *
 *  @return <#return value description#>
 */
//#pragma mark-SidePanel
//-(void)toggleMenu:(BOOL)shouldOpenMenu
//{
//    [self.animator removeAllBehaviors];
//    CGFloat gravityDirectionX = (shouldOpenMenu) ? 1.0 : -1.0;
//    CGFloat pushMagnitude = (shouldOpenMenu) ? 30.0 : -30.0;
//    CGFloat boundaryPointX = (shouldOpenMenu) ? 280.0 : -280.0;
//    
//    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.view_sidePanel]];
//    gravityBehavior.gravityDirection = CGVectorMake(gravityDirectionX, 0.0);
//    [self.animator addBehavior:gravityBehavior];
//    
//    
//    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.view_sidePanel]];
//    [collisionBehavior addBoundaryWithIdentifier:@"menuBoundary"
//                                       fromPoint:CGPointMake(boundaryPointX, 0.0)
//                                         toPoint:CGPointMake(boundaryPointX,([UIScreen mainScreen].bounds.size.height))];
//    
//    [self.animator addBehavior:collisionBehavior];
//    
//    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.view_sidePanel]
//                                                                    mode:UIPushBehaviorModeInstantaneous];
//    pushBehavior.magnitude = pushMagnitude;
//    [self.animator addBehavior:pushBehavior];
//    
//    UIDynamicItemBehavior *menuViewBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.view_sidePanel]];
//    menuViewBehavior.elasticity = 0.0;
//    [self.animator addBehavior:menuViewBehavior];
//    
//    self.img_backimg.alpha = (shouldOpenMenu) ? 0.7 : 0.0;
//    
//    self.img_backimg.userInteractionEnabled=(shouldOpenMenu) ? YES:NO;
//}

//  /////
//    self.UnsortedplacesNames=[[NSArray alloc]init];
//    self.UnsortedplacesNames=arr;
//
//    self.filteredPlacesNames = [[NSMutableArray alloc] init];
//    NSSet *set= (NSSet*)[NSOrderedSet orderedSetWithArray:arr];
//    self.filteredPlacesNames = [[set allObjects] mutableCopy];
//
//    self.UnsortedplacesTypes=[[NSMutableArray alloc]init];
//    self.UnsortedplacesTypes=arr2;
//
//    self.filteredPlacesTypes= [[NSMutableArray alloc] init];
//    NSSet *set2= (NSSet*)[NSOrderedSet orderedSetWithArray:arr2];
//    self.filteredPlacesTypes = [[set2 allObjects] mutableCopy];
//

//    self.PlacesNames=[[NSString alloc]init];
//    self.PlacesNames=[NSString stringWithFormat:@"%@", [self.filteredPlacesNames componentsJoinedByString:@ "|"]] ;

//    self.PlacesTypes=[[NSString alloc]init];
//    self.PlacesTypes=[NSString stringWithFormat:@"%@",[self.filteredPlacesTypes componentsJoinedByString:@"|"]];

@end
