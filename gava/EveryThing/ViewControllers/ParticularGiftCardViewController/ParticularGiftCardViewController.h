//
//  ParticularGiftCardViewController.h
//  gava
//
//  Created by RICHA on 9/9/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"
#import "CardDetails.h"
#import <UIImageView+WebCache.h>
#import <SCLAlertView.h>
#import <QuartzCore/QuartzCore.h>
#import <Facebook-iOS-SDK/FBSDKCoreKit/FBSDKCoreKit.h>
#import <Facebook-iOS-SDK/FBSDKLoginKit/FBSDKLoginKit.h>
#import <Facebook-iOS-SDK/FBSDKShareKit/FBSDKShareKit.h>
#import "Constants.h"
#import "IOSRequest.h"
#import "UserProfile.h"
#import <NKDCode39Barcode.h>
#import <Foundation/Foundation.h>
#import <UIImage-NKDBarcode.h>
#import <NKDCode128Barcode.h>
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import "MapViewController.h"
#import "TermsConditons&RedemptionViewController.h"
#import "FullScreenMapViewController.h"
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import <SCSkypeActivityIndicatorView.h>
#import "MapPoint.h"
#import <NKDUPCABarcode.h>
#import <ZXingObjC.h>
#import "AlertView.h"
#import "MapViewController.h"

@interface ParticularGiftCardViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIButton *btn_edit;
- (IBAction)btn_edit_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_back;
- (IBAction)btn_back_pressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *img_card_img;
@property (strong, nonatomic) IBOutlet UILabel *lbl_card_num;


@property (strong, nonatomic) IBOutlet UIButton *btn_tapcopy;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *widthConstant;
@property (strong, nonatomic) IBOutlet UIButton *btn_tapCopy_pressed;
@property (strong, nonatomic) IBOutlet UILabel *lbl_pin_num;
@property (strong, nonatomic) IBOutlet UIImageView *img_barcode;

@property (strong, nonatomic) IBOutlet UIButton *btn_tc;


- (IBAction)btn_tc_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *view_center;

- (IBAction)btn_inst_pressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn_arrow;
- (IBAction)btn_arrow_pressed:(id)sender;

@property(nonatomic,retain)CardDetails *cdet;

@property (strong, nonatomic) IBOutlet UILabel *lbl_price;
@property (strong, nonatomic) IBOutlet UIButton *btn_refresh;
- (IBAction)btn_refresh_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;


@property(nonatomic,retain)CLLocationManager *locationManager1;
@property(nonatomic)NSString *lat;
@property(nonatomic)NSString * lng;


@property(nonatomic,retain)SCSkypeActivityIndicatorView *ld;
@property (strong, nonatomic) IBOutlet UILabel *nav_title;
@property (strong, nonatomic) IBOutlet UIView *view_forEdit;
@property (strong, nonatomic) IBOutlet UIView *view_actionSheet;

@property (strong, nonatomic) IBOutlet UIButton *btn_removeCard;
- (IBAction)btn_removeCard_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_cancel;
- (IBAction)btn_cancel_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *img_forEdit;

@property (strong, nonatomic) IBOutlet UIView *view_mainBack;
@property (strong, nonatomic) IBOutlet UIButton *btn_link;
- (IBAction)btn_link_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_copy;

- (IBAction)btn_copy_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cnst_pinNo_ht;

@property (strong, nonatomic) IBOutlet UIImageView *img_refresh;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cnst_toHidePinNo;
@property (strong, nonatomic) IBOutlet UIButton *btn_Locator;
- (IBAction)btn_locator_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_myLoc;

- (IBAction)btn_myLoc_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *view_spacerView;
@property (strong, nonatomic) IBOutlet UIView *view_upper;
@property (strong, nonatomic) IBOutlet UITextField *tf_price;
@property (strong, nonatomic) IBOutlet UIButton *btn_redemp;

@property (strong, nonatomic) IBOutlet UILabel *lbl_map_above;
@property (strong, nonatomic) IBOutlet UILabel *lbl_map_bottom;

@property (strong, nonatomic) IBOutlet UILabel *lbl_otherCardName;

@end
