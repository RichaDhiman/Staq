//
//  FirstViewController.h
//  gava
//
//  Created by RICHA on 9/4/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "imgCollectionCell.h"
#import "IOSRequest.h"
#import "LoginViewController.h"
#import "SignupViewController.h"
#import <SCLAlertView.h>
#import <Facebook-iOS-SDK/FBSDKCoreKit/FBSDKCoreKit.h>
#import <Facebook-iOS-SDK/FBSDKLoginKit/FBSDKLoginKit.h>
#import <Facebook-iOS-SDK/FBSDKShareKit/FBSDKShareKit.h>
#import "MainViewController.h"
#import "AppDelegate.h"
#import "AlertView.h"

@interface FirstViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *img_logo;
@property (strong, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (strong, nonatomic) IBOutlet UIButton *btn_fbSignUp;
- (IBAction)btn_fbSignUp_pressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn_email;

- (IBAction)btn_email_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIPageControl *myPageControl;
@property (strong, nonatomic) IBOutlet UILabel *lbl_title;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cnst_titleBottom;

/*!
 *  @brief  these are to store facebook details i.e. id,email,name,dob
 */
@property(nonatomic,retain)NSString *fb_id;
@property(nonatomic,retain)NSString* fb_email;
@property(nonatomic,retain)NSString* fb_name;
@property(nonatomic,retain)NSString* fb_dob;

@end
