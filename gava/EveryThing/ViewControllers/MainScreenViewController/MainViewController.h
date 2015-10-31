//
//  MainViewController.h
//  gava
//
//  Created by RICHA on 9/4/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainCollectionCell.h"
#import "UserProfile.h"
#import "Constants.h"
#import "IOSRequest.h"
#import "CardDetails.h"
#import <UIImageView+WebCache.h>
#import <SCLAlertView.h>
#import "AddGiftCardViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ParticularGiftCardViewController.h"
#import "AppDelegate.h"
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import <SCSkypeActivityIndicatorView.h>
#import "Animations.h"
#import "FullScreenMapViewController.h"
#import "AlertView.h"
#import <Facebook-iOS-SDK/FBSDKCoreKit/FBSDKCoreKit.h>
#import <Facebook-iOS-SDK/FBSDKLoginKit/FBSDKLoginKit.h>
#import <Facebook-iOS-SDK/FBSDKShareKit/FBSDKShareKit.h>
#import "FamilyShareViewController.h"
#import "AddCodeToSyncViewController.h"

@interface MainViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,CLLocationManagerDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *mycollectionView;

@property (strong, nonatomic) IBOutlet UIImageView *img_ifNoCard;
@property (strong, nonatomic) IBOutlet UIImageView *img_addCHere;
@property (strong, nonatomic) IBOutlet UIButton *btn_wallet;
- (IBAction)btn_wallet_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_map;
- (IBAction)btn_map_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_giftCard;
- (IBAction)btn_giftCard_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_logout;
- (IBAction)btn_logout_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_emailAd;

////SidePanel
@property (strong, nonatomic) IBOutlet UIView *view_sidePanel;
@property (strong, nonatomic) IBOutlet UIImageView *img_backimg;
@property (strong, nonatomic) IBOutlet UILabel *lbl_cards_count;
@property (strong, nonatomic) IBOutlet UILabel *lbl_total;

////navbar buttons
@property (strong, nonatomic) IBOutlet UIButton *btn_menu;
- (IBAction)btn_menu_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_search;
- (IBAction)btn_search_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_add;
- (IBAction)btn_add_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cnst_ldngSrch;
@property (strong, nonatomic) IBOutlet UILabel *lbl_NoResult;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cnst_tralng_sidepanel;
@property (strong, nonatomic) IBOutlet UILabel *lbl_versionNum;

/*!
 *  @brief  Location Manager class object
 */
@property(nonatomic,retain)CLLocationManager *locationManager;
@property(nonatomic)NSString *lat;
@property(nonatomic)NSString * lng;
/*!
 *  @brief  Array to store cards
 */
@property(nonatomic,retain)NSArray *MyCards;
/*!
 *  @brief  array to store filtered card on search
 */
@property(nonatomic,retain)NSMutableArray *FilteredCards;
@property (strong, nonatomic) IBOutlet UIButton *btn_familyShare;
- (IBAction)btn_familyShare_Pressed:(id)sender;

@end
