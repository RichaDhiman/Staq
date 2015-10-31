//
//  FirstViewController.m
//  gava
//
//  Created by RICHA on 9/4/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
/*!
 *  @brief  A array for images names
 */
@property(nonatomic,retain)NSArray* imgsArr;
/*!
 *  @brief A array for images titles
 */
@property(nonatomic,retain)NSArray* titlesArr;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.interactivePopGestureRecognizer setDelegate:self];
    self.lbl_title.preferredMaxLayoutWidth=200;
    
    if ([[NSUserDefaults standardUserDefaults  ]valueForKey:@"user"]!=nil)
    {
        UserProfile *up=[[UserProfile alloc]init];
        up=[UserProfile getProfile];
                
        if ([up.user_id isEqualToString:@""]||up.user_id!=nil)
        {
            UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MainViewController *controller=(MainViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"MainViewController"];
            
            [self.navigationController pushViewController:controller animated:NO];
        }
    }

    
    [[UIApplication sharedApplication]setStatusBarHidden:NO];

   }


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.myPageControl.currentPage=0;
    [self viewHelper];
    
}

#pragma mark-setupui

/*!
 *  @brief  Did everything that i want to do before appearance of viewcontroller like initializaton of objects etc
 */
-(void)viewHelper
{
    self.lbl_title.preferredMaxLayoutWidth=200;
    self.myPageControl.currentPage=0;

    self.btn_fbSignUp.layer.cornerRadius=3;
    self.btn_fbSignUp.clipsToBounds=YES;
    
    self.btn_email.layer.cornerRadius=3;
    self.btn_email.clipsToBounds=YES;
    
    self.imgsArr=[[NSArray alloc]init];
    self.titlesArr=[[NSArray alloc]init];
    
    self.imgsArr=@[@"logo_intro1",@"logo_intro2",@"logo_intro3"];
    self.titlesArr=@[@"Store all your gift cards on your mobile device for easy accesss.",@"Find nearby retailers for cards that you have stored in STAQ.",@"Use your gift cards and make purchases right in the store from the STAQ app."];
    

}


#pragma mark-collectionViewControler handling

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    imgCollectionCell *cell = (imgCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"imgCollectionCell" forIndexPath:indexPath];
   
    [cell cofigureCell:[self.imgsArr objectAtIndex:indexPath.row] :[self.titlesArr objectAtIndex:indexPath.row]];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.view.frame.size.width ,self.myCollectionView.frame.size.height);
}

/*!
 *  @brief To set the pagecontrol page on scroll
 *
 *  @param scrollView scrollview Object
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth/2) / pageWidth)+1;
    self.myPageControl.currentPage = page;
    

}

#pragma mark-Button Actions

/*!
 *  @brief  Action to Signup by email
 *
 *  @param sender  is btn_email
 */
- (IBAction)btn_email_pressed:(id)sender
{
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SignupViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"SignupViewController"];
     [self.navigationController pushViewController:controller animated:YES];
}

/*!
 *  @brief  Action to request for  read permissions like your public_profile,birthday,email
 *
 *  @param sender is Btn_fbSignup
 */
- (IBAction)btn_fbSignUp_pressed:(id)sender
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
    AppDelegate *App = (AppDelegate *)[UIApplication sharedApplication].delegate;

    [self.view endEditing:YES];
    [self resignFirstResponder];
    [App StartAnimating];
    self.view.userInteractionEnabled=NO;
    
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
         NSLog(@"%@",[error description]);
         [App StopAnimating];
     }];

}



#pragma mark-unwind Function
/*!
 *  @brief  To Return back to this Controller from other Controller
 *
 *  @param unwindSegue <#unwindSegue description#>
 */
-(IBAction)unwindFirstViewController:(UIStoryboardSegue*)unwindSegue
{
    UIViewController* sourceViewController = unwindSegue.sourceViewController;
    if ([sourceViewController isKindOfClass:[MainViewController class]])
    {
        NSLog(@"Coming from MainViewController!");
    }
}


//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    imgCollectionCell *cell1 =(imgCollectionCell*)cell;
//
//    [UIView animateWithDuration:0.8 animations:^{
//
//        cell1.img_logos.transform = CGAffineTransformMakeScale(-1, 1); //Flipped
//        cell1.img_logos.transform=CGAffineTransformMakeRotation(M_PI*2);
//
//    } completion:^(BOOL finished) {
//
//    }];
//
//
//}


@end
