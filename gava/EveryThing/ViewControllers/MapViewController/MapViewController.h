//
//  MapViewController.h
//  gava
//
//  Created by RICHA on 9/15/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<MKMapViewDelegate,UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *mywebview;

@property (strong, nonatomic) IBOutlet UIButton *btn_done;
- (IBAction)btn_done_pressed:(id)sender;



//@property(nonatomic,retain)MKPlacemark *Dloc;
@property(nonatomic)CLLocationCoordinate2D Dloc;
@property(nonatomic,retain)NSString* link;


@end
