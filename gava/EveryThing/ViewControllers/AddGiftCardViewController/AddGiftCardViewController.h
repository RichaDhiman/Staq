//
//  AddGiftCardViewController.h
//  gava
//
//  Created by RICHA on 9/5/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddGiftCardCellTableViewCell.h"
#import "IOSRequest.h"
#import "Constants.h"
#import "UserProfile.h"
#import <UIImageView+WebCache.h>
#import "AddCardInfoViewController.h"
#import <SCLAlertView.h>
#import "AppDelegate.h"
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "Animations.h"

@interface AddGiftCardViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UISearchBarDelegate,UIScrollViewDelegate,UIAlertViewDelegate>



@property (strong, nonatomic) IBOutlet UISearchBar *mysearchBar;


@property (strong, nonatomic) IBOutlet UITableView *tbl_retailers;

@property(nonatomic,retain)NSArray* MyBrands;

@property (strong, nonatomic) IBOutlet UIButton *btn_back;

- (IBAction)btn_back_pressed:(id)sender;
@property(nonatomic,retain)NSMutableArray *FilteredBrand;
@property (strong, nonatomic) IBOutlet UILabel *lbl_giftCard;

@property (strong, nonatomic) IBOutlet UILabel *lbl_noResult;

@property (strong, nonatomic) IBOutlet UIView *view_footer_view;
@property (strong, nonatomic) IBOutlet UIImageView *img_footerImg;
@property (strong, nonatomic) IBOutlet UILabel *lbl_footerText;
@property (strong, nonatomic) IBOutlet UIButton *btn_footer;
- (IBAction)btn_footer_pressed:(id)sender;


@end
