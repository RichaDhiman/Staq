//
//  AddCardInfoViewController.h
//  gava
//
//  Created by RICHA on 9/7/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertView.h"
#import "IOSRequest.h"
#import "Constants.h"
#import "MainViewController.h"
#import <SCLAlertView.h>
#import "UserProfile.h"
#import "AppDelegate.h"
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import <SCSkypeActivityIndicatorView.h>


@interface AddCardInfoViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lbl_brandName;

@property (strong, nonatomic) IBOutlet UITextField *tf_cardNumber;

@property (strong, nonatomic) IBOutlet UITextField *tf_pinNumber;

@property(nonatomic,retain)NSString* BrandName;
@property(nonatomic,retain)NSString* Brandid;
@property(nonatomic,retain)NSString* BrandImageName;
@property(nonatomic,retain)NSString* Brand_is_valid;
@property(nonatomic)BOOL is_OtherBrand;

@property (strong, nonatomic) IBOutlet UIButton *btn_back;
- (IBAction)btn_back_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_done;
@property (strong, nonatomic) IBOutlet UIImageView *img_cardLogo;

@property (strong, nonatomic) IBOutlet UIButton *btn_done2;

- (IBAction)btn_done2_pressed:(id)sender;
@property(nonatomic,retain)SCSkypeActivityIndicatorView *ld;
@property (strong, nonatomic) IBOutlet UILabel *lbl_verify;
@property (strong, nonatomic) IBOutlet UITextField *tf_remainingBal;
@property (strong, nonatomic) IBOutlet UIView *view_BotmLine;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cnst_Line4Leading;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cnst_Line4btmToSuperView;
@property (strong, nonatomic) IBOutlet UITextField *tf_brandName;

@property (strong, nonatomic) IBOutlet UILabel *lbl_dollar;

@end
