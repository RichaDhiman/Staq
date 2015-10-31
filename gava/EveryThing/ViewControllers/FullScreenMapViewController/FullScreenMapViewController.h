//
//  FullScreenMapViewController.h
//  gava
//
//  Created by RICHA on 9/30/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import <MapKit/MapKit.h>
#import "MapViewController.h"
#import "CardDetails.h"
#import "MapPoint.h"
#import <QuartzCore/QuartzCore.h>
#import "AlertView.h"

@interface FullScreenMapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *myMapView;

@property (strong, nonatomic) IBOutlet UIButton *btn_done;
- (IBAction)btn_done_pressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *view_detailView;
@property (strong, nonatomic) IBOutlet UILabel *lbl_brandName;
@property (strong, nonatomic) IBOutlet UITextView *lbl_Locaddress;

@property (strong, nonatomic) IBOutlet UIButton *btn_direction;

- (IBAction)btn_direction_pressed:(id)sender;

@property(nonatomic,retain)CLLocationManager *locationManager;
@property(nonatomic)NSString *lat;
@property(nonatomic)NSString * lng;

@property(nonatomic,retain)CardDetails *cardDet;
@property(nonatomic,retain)MKLocalSearchResponse *locations;
@property(nonatomic,retain)NSArray* GLocs;
@property(nonatomic)BOOL cmngFromMainViewController;
@property(nonatomic,retain)NSString *BrandNames;
@property(nonatomic,retain)NSString *BrandTypes;
@property(nonatomic)BOOL CmngFromParGiftCrd;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cnst_detailsView_botttom;
@property (strong, nonatomic) IBOutlet UIButton *btn_myLoc;
- (IBAction)btn_myLoc_pressed:(id)sender;


@property(nonatomic,retain)NSArray *NamesArrayFromMain;
@property(nonatomic,retain)NSArray *TypesArrayFromMain;

@end
