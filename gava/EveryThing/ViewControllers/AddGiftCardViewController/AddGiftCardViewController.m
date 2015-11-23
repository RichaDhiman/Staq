
//
//  AddGiftCardViewController.m
//  gava
//
//  Created by RICHA on 9/5/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "AddGiftCardViewController.h"

@interface AddGiftCardViewController ()
/*!
 *  @brief  To show loader once on api hit.No to show loader
 */
@property(nonatomic)BOOL alreadyLoading;
/*!
 *  @brief  Check current offset of table scroll
 */
@property(nonatomic)CGPoint currentOffset;
/*!
 *  @brief  To check last contentOffset
 */
@property(nonatomic)CGPoint lastContentOffset;
/*!
 *  @brief  flag to stop animation when performing search
 */
@property(nonatomic)BOOL noAniSearch;
@end

@implementation AddGiftCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbl_noResult.hidden=YES;
    [self getBrands:YES];
    self.alreadyLoading=YES;
    [self BrandsInfo:NO];
   

    [self.img_footerImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%d",Url_pics,[[NSUserDefaults standardUserDefaults]valueForKeyPath:@"custom.minlogo" ],(int)(DISPLAYSCALE*self.img_footerImg.frame.size.width)]] placeholderImage:nil options:SDWebImageTransformAnimatedImage progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
         
     } completed:nil usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
}

/*!
 *  @brief   Did everything that i want to do before appearance of viewcontroller
 */
-(void)viewHelper
{
    
    
    self.FilteredBrand=[[NSMutableArray alloc]init];
    self.title=@"Add Gift Card";
    [self.tbl_retailers setTableFooterView:self.view_footer_view];
    if (self.alreadyLoading==NO)
    [self getBrands:NO];
    
    
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [[UILabel appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor lightGrayColor]];
    [[UITextField appearanceWhenContainedIn: [UISearchBar class], nil]
     setFont: [UIFont systemFontOfSize: 16]];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    [self viewHelper];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    self.mysearchBar.text=@"";
}

/*!
 *  @brief  api to get brands will be hit
 *
 *  @param isLoaderActive bool value will be yes if want to show loader
 */
-(void)getBrands:(BOOL)isLoaderActive
{
    AppDelegate *App=[UIApplication sharedApplication].delegate;
    if (isLoaderActive==YES){
    [App StartAnimating];
    self.view.userInteractionEnabled=NO;
    }
    AlertView *alert=[[AlertView alloc]init];
    [self.view endEditing:YES];
    [IOSRequest fetchJsonData:Url_myBrands success:^(NSDictionary *responseDict) {
         [App StopAnimating];
        self.view.userInteractionEnabled=YES;
        if([[responseDict valueForKey:@"success"] integerValue] == 1)
        {
            [[NSUserDefaults standardUserDefaults]setValue:[responseDict valueForKey:@"custom"] forKey:@"custom"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        [self.img_footerImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%d",Url_pics,[[NSUserDefaults standardUserDefaults]valueForKeyPath:@"custom.minlogo" ],(int)(DISPLAYSCALE*self.img_footerImg.frame.size.width)]] placeholderImage:nil options:SDWebImageTransformAnimatedImage progress:^(NSInteger receivedSize, NSInteger expectedSize)
                 {
            
                 } completed:nil usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            
            [UserProfile saveBrandsInfo:[responseDict valueForKey:@"brand"]];
            
            
            if (isLoaderActive==YES) {
            
                
                   [self BrandsInfo:NO];
                [self.tbl_retailers reloadData];
            }
            else
            {
                 [self BrandsInfo:YES];
                [self.tbl_retailers reloadData];

            }
         
            

         
            
        }
        else if([[responseDict valueForKey:@"success"]integerValue]==2)
        {
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Token expired! Please login." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert1.tag=2;
            [alert1 show];
        }
        else
        {
            [alert showStaticAlertWithTitle:@"" AndMessage:[responseDict valueForKey:@"msg"]];
        }
        
          } failure:^(NSError *error) {
            self.view.userInteractionEnabled=YES;
        NSLog(@"%@",[error description]);
            [alert showStaticAlertWithTitle:@"" AndMessage:@"Please check your Internet Connection!"];
              [App StopAnimating];
          }];
  }

-(void)BrandsInfo:(BOOL)isreloaded
{
    self.MyBrands=[[NSArray alloc]init];
    self.MyBrands=[UserProfile getBrandsInfo];
    self.FilteredBrand=[[UserProfile getBrandsInfo] mutableCopy];
   // [self.tbl_retailers reloadData];
    
    if (isreloaded==YES) {
        [self.tbl_retailers performSelectorOnMainThread:@selector(reloadData)
                                             withObject:nil
                                          waitUntilDone:NO];

    }
    
}


#pragma mark-TableView Handling
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.MyBrands.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddGiftCardCellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AddGiftCardCellTableViewCell" forIndexPath:indexPath];
    [cell configure:[self.MyBrands objectAtIndex:indexPath.row]];
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.alreadyLoading=NO;
    UserProfile *ud=[[UserProfile alloc]init];
    ud=[self.MyBrands objectAtIndex:indexPath.row];
    
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddCardInfoViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"AddCardInfoViewController"];
    controller.BrandName=ud.bDet_name;
    controller.Brandid=ud.bDet_brand_id;
    controller.BrandImageName=ud.bDet_minlogo;
    controller.Brand_is_valid=ud.bDet_brand_is_valid_id;
    controller.is_OtherBrand=NO;
    
    
    [self.navigationController pushViewController:controller animated:YES];
   }

#pragma mark-Search Handling
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if (searchText.length == 0) {
        
         [self BrandsInfo:YES];
    }
    else
    {
        self.mysearchBar.showsCancelButton = YES;
        
        NSString* filter = @"%K beginswith[c] %@";
        NSPredicate* predicate = [NSPredicate predicateWithFormat:filter, @"bDet_name", searchText];
        
        
        
        self.MyBrands = [[self.FilteredBrand filteredArrayUsingPredicate:predicate] mutableCopy];
        
        [self.tbl_retailers performSelectorOnMainThread:@selector(reloadData)
                                             withObject:nil
                                          waitUntilDone:NO];
        
        self.lbl_noResult.hidden=(self.MyBrands.count==0)? NO:YES;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.noAniSearch=NO;
    self.lbl_noResult.hidden=YES;
    [self.view endEditing:YES];
    self.mysearchBar.text=@"";
    [self getBrands:NO];
}


#pragma mark-Button Actions
- (IBAction)btn_back_pressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.currentOffset = scrollView.contentOffset;
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

/*!
 *  @brief  to check whether scrolling is upward or downward
 *
 *  @return <#return value description#>
 */
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (self.currentOffset.y > self.lastContentOffset.y)
//        [Animations bounceLeft:cell.contentView];                    //downward
//    self.lastContentOffset = self.currentOffset;
// }

- (IBAction)btn_footer_pressed:(id)sender {
    
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddCardInfoViewController *controller=[mainStoryboard instantiateViewControllerWithIdentifier:@"AddCardInfoViewController"];
    controller.BrandName=@"";
    controller.Brandid=@"";
    controller.BrandImageName=[[NSUserDefaults standardUserDefaults]valueForKeyPath:@"custom.minlogo"];
    controller.Brand_is_valid=@"0";
    controller.is_OtherBrand=YES;
    [self.navigationController pushViewController:controller animated:YES];
}
@end
