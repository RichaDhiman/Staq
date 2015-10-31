//
//  FamilyShareViewController.h
//  gava
//
//  Created by RICHA on 10/17/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FullScreenMapViewController.h"
#import "AddGiftCardViewController.h"
#import "FamilyShareTableCell.h"
#import "ContactsViewController.h"
#import "SyncGiftCards.h"
#import "AddCodeToSyncViewController.h"
#import "UserProfile.h"
#import "Constants.h"
#import "AppDelegate.h"

@interface FamilyShareViewController : UIViewController<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate>


@property (strong, nonatomic) IBOutlet UIImageView *img_back_img;
@property (strong, nonatomic) IBOutlet UIButton *btn_menu;
- (IBAction)btn_menu_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lbl_navTitle;

@property (strong, nonatomic) IBOutlet UIView *view_top;
@property (strong, nonatomic) IBOutlet UIView *view_middle;

@property (strong, nonatomic) IBOutlet UIView *view_bottom;
@property (strong, nonatomic) IBOutlet UILabel *lbl_notice;
@property (strong, nonatomic) IBOutlet UIImageView *img_pics;

@property (strong, nonatomic) IBOutlet UIImageView *img_cardPic;
@property (strong, nonatomic) IBOutlet UILabel *lbl_notice2;

- (IBAction)btn_addFamily_pressed:(id)sender;
- (IBAction)btn_sync_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_AddFamily;
@property (strong, nonatomic) IBOutlet UIButton *btn_Sync;
//Side Panel Outlets

@property (strong, nonatomic) IBOutlet UIView *view_sidePanel;
@property (strong, nonatomic) IBOutlet UIButton *btn_wallet;
- (IBAction)btn_wallet_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_addGiftCard;
- (IBAction)btn_addGiftCard_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_familyShare;
- (IBAction)btn_familyShare_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *lbl_email;
@property (strong, nonatomic) IBOutlet UILabel *lbl_total;

@property (strong, nonatomic) IBOutlet UILabel *lbl_NoofCards;

@property (strong, nonatomic) IBOutlet UIButton *btn_map;
- (IBAction)btn_map_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_logout;

- (IBAction)btn_logout_pressed:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *lbl_versionNo;

@property (strong, nonatomic) IBOutlet UITableView *tbl_familyShare;


@end
