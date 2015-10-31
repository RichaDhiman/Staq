//
//  FullScreenMapViewController.m
//  gava
//
//  Created by RICHA on 9/30/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "FullScreenMapViewController.h"
#define url_showLocationOnApp [NSString stringWithFormat:@"%@%@",googleMapsAppBasePath,@"?q=%f,%f"]
#define url_showLocationOnWebpage @"http://maps.google.com/?q=%f,%f"
#define googleMapsAppBasePath @"comgooglemaps://"

//AppleMaps
#define AppleMapsAppBasePath @"comapplemaps://"
#define url_showAppleLocationOnWebpage @"http://maps.apple.com/?q=%f"
#define url_showAppleLocationOnApp [NSString stringWithFormat:@"%@%@",AppleMapsAppBasePath,@"?q=%f,%f"]


@interface FullScreenMapViewController ()
@property(nonatomic,retain)NSMutableArray *GoogleLocs;
@property(nonatomic)CLLocationCoordinate2D DlocPM;

@end

@implementation FullScreenMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if([CLLocationManager locationServicesEnabled] &&
       [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        // show the map
    }
else
{
     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Turn On Location Services to allow 'STAQ' to determine your location." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alert.tag=3;
    [alert show];
}


    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate=self;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        
        //    [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
    self.lat= [NSString stringWithFormat:@"%f",self.locationManager.location.coordinate.latitude ];
    self.lng = [NSString stringWithFormat:@"%f",self.locationManager.location.coordinate.longitude ];
    
    [[NSUserDefaults standardUserDefaults]setValue:self.lat forKey:@"lat"];
    [[NSUserDefaults standardUserDefaults]setValue:self.lng forKey:@"lng"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.cnst_detailsView_botttom.constant=-self.view_detailView.frame.size.height;
        
    } completion:nil];

    [self setNeedsStatusBarAppearanceUpdate];
     self.GoogleLocs=[[NSMutableArray alloc]init];

    self.lbl_brandName.preferredMaxLayoutWidth=[UIScreen mainScreen].bounds.size.width-90;
    // Do any additional setup after loading the view.
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.lbl_brandName.preferredMaxLayoutWidth=[UIScreen mainScreen].bounds.size.width-90;
    
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    [self viewHelper];
    [self.myMapView
     setShowsUserLocation:YES];
   
}

- (void)viewWillDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [super viewWillDisappear:animated];
}

-(void)viewHelper
{
    self.btn_done.layer.cornerRadius=4;
    self.btn_done.clipsToBounds=YES;
    self.btn_direction.layer.cornerRadius=self.btn_direction.frame.size.width/2;
    self.btn_direction.clipsToBounds=YES;
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    
    if (self.locationManager.location!=nil)
    {
        self.lat= [NSString stringWithFormat:@"%f",self.locationManager.location.coordinate.latitude ];
        self.lng = [NSString stringWithFormat:@"%f",self.locationManager.location.coordinate.longitude ];
        
        [[NSUserDefaults standardUserDefaults]setValue:self.lat forKey:@"lat"];
        [[NSUserDefaults standardUserDefaults]setValue:self.lng forKey:@"lng"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.locationManager stopUpdatingLocation];
        [self mapWork];
    }
}




- (IBAction)btn_done_pressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btn_direction_pressed:(id)sender
{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"http://maps.google.com/maps?saddr=Current+Location&daddr=%f,%f",self.DlocPM.latitude,self.DlocPM.longitude]]];
    
    BOOL canHandle = [[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:googleMapsAppBasePath]];
    if (canHandle) {
        // Google maps installed
        NSString* url = [NSString stringWithFormat:url_showLocationOnApp,self.DlocPM.latitude,self.DlocPM.longitude];
[[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    } else
    {
        
        NSString* url = [NSString stringWithFormat:@"http://maps.apple.com/maps?saddr=%f,%f&daddr=%f,%f",[self.lat doubleValue], [self.lng doubleValue], self.DlocPM.latitude,self.DlocPM.longitude];
        
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
        
    }
    // Use Safari
    // NSString *url = [NSString stringWithFormat:url_showLocationOnWebpage,self.DlocPM.latitude,self.DlocPM.longitude];
    //[self.delegate openWebViewWithUrl:[NSURL URLWithString: url]];
    
    //        NSString* url = [NSString stringWithFormat:url_showAppleLocationOnApp,self.DlocPM.latitude,self.DlocPM.longitude];
    //        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];

    
}




-(void)mapWork
{
    [self.myMapView setMapType:MKMapTypeStandard];
    [self.myMapView setShowsUserLocation:YES];
    
    [self.myMapView setZoomEnabled:YES];
    
    [self.myMapView setScrollEnabled:YES];
    [self.myMapView setDelegate:self];
    
    
    ///Search
    
    
    if (self.GLocs.count==0)
    {
       [self googleNearestLoc];
    }
    else
    {
        self.GoogleLocs=self.GLocs;
        [self plotPositions:self.GoogleLocs];
    }
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    [UIView animateWithDuration:0.3 animations:^{
        self.cnst_detailsView_botttom.constant=0;
    } completion:nil];
    NSLog(@"Tapped on: %@", view.annotation.title);

    
    
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:[view.annotation.title capitalizedString]];
    NSInteger _stringLength=[attString length];
    
    [attString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:20.0f] range:NSMakeRange(0, _stringLength)];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0] range:NSMakeRange(0, _stringLength)];
    
    
    NSString *str=[[NSString alloc]init];
    str=view.annotation.subtitle;
    
    
    NSMutableAttributedString *attString2=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@",str ]];
    NSInteger _stringLength2=[str length];
    //Helvetica-Light
    
    UIFont *font2=[UIFont fontWithName:@"Helvetica" size:12.0f];
    [attString2 addAttribute:NSFontAttributeName value:font2 range:NSMakeRange(0, _stringLength2+1)];
    [attString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0] range:NSMakeRange(0, _stringLength2+1)];
    
    NSMutableAttributedString *NotiComment = [[NSMutableAttributedString alloc] initWithAttributedString:attString];
    
    [NotiComment appendAttributedString:attString2];
    
    self.lbl_brandName.attributedText = NotiComment;

    self.DlocPM=[view.annotation coordinate];
}


-(void)googleNearestLoc
{
    NSString *url=[[NSString alloc]init];
    
     if (self.cmngFromMainViewController==YES && [self.BrandNames length]>0)
    {
        url=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&key=AIzaSyBY5AWF0BwMMD_oxmm1KHSvEZkAuQLAx0Q&keyword=%@&types=%@&rankby=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"lat"], [[NSUserDefaults standardUserDefaults]valueForKey:@"lng"],self.BrandNames,self.BrandTypes,@"distance"];
   
            self.cmngFromMainViewController=NO;
//        for (int i=0; i<self.NamesArrayFromMain.count; i++) {
//            
//            url=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&key=AIzaSyBY5AWF0BwMMD_oxmm1KHSvEZkAuQLAx0Q&keyword=%@&types=%@&rankby=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"lat"], [[NSUserDefaults standardUserDefaults]valueForKey:@"lng"],[self.NamesArrayFromMain objectAtIndex:i],[self.TypesArrayFromMain objectAtIndex:i],@"distance"];
//            
//            [IOSRequest fetchJsonData:url success:^(NSDictionary *responseDict)
//             {
//                 self.GoogleLocs=[[NSMutableArray alloc]init];
//                // self.GoogleLocs=[responseDict valueForKey:@"results"];
//                 [self.GoogleLocs addObjectsFromArray:[responseDict valueForKey:@"results"]];
//                 
//                 
//             } failure:^(NSError *error) {
//                 
//             }];
//        
//        }
        //[self plotPositions:self.GoogleLocs];
   
    }
    else if([self.BrandNames length]<=0 && self.cmngFromMainViewController==YES)
    {
        
    }
    else if(self.CmngFromParGiftCrd==YES)
    {
        url=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&key=AIzaSyBY5AWF0BwMMD_oxmm1KHSvEZkAuQLAx0Q&keyword=%@&types=%@&rankby=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"lat"], [[NSUserDefaults standardUserDefaults]valueForKey:@"lng"],self.cardDet.brandDet.bDet_name,self.cardDet.brandDet.bDet_brand_type ,@"distance"];
        
    }
    
    [IOSRequest fetchJsonData:url success:^(NSDictionary *responseDict)
     {
         self.GoogleLocs=[[NSMutableArray alloc]init];
         self.GoogleLocs=[responseDict valueForKey:@"results"];
         
         [self plotPositions:self.GoogleLocs];
         
     } failure:^(NSError *error) {
         
     }];

    
}

-(void)plotPositions:(NSArray *)data {
    // 1 - Remove any existing custom annotations but not the user location blue dot.
    for (id<MKAnnotation> annotation in self.myMapView.annotations) {
        if ([annotation isKindOfClass:[MapPoint class]]) {
            [self.myMapView removeAnnotation:annotation];
        }
    }
    
    if([self.GoogleLocs count]==0)
    {
        [self.myMapView setCenterCoordinate:self.locationManager.location.coordinate];
        
    }
    else
    {
        //2 - Loop through the array of places returned from the Google API.
        for (int i=0; i<[self.GoogleLocs count]; i++) {
            //Retrieve the NSDictionary object in each index of the array.
            NSDictionary* place = [self.GoogleLocs objectAtIndex:i];
            // 3 - There is a specific NSDictionary object that gives us the location info.
            NSDictionary *geo = [place objectForKey:@"geometry"];
            // Get the lat and long for the location.
            NSDictionary *loc = [geo objectForKey:@"location"];
            // 4 - Get your name and address info for adding to a pin.
            NSString *name=[place objectForKey:@"name"];
            NSString *vicinity=[place objectForKey:@"vicinity"];
            // Create a special variable to hold this coordinate info.
            CLLocationCoordinate2D placeCoord;
            // Set the lat and long.
            placeCoord.latitude=[[loc objectForKey:@"lat"] doubleValue];
            placeCoord.longitude=[[loc objectForKey:@"lng"] doubleValue];
            // 5 - Create a new annotation.
            MapPoint *placeObject = [[MapPoint alloc] initWithName:name address:vicinity coordinate:placeCoord];
            [self.myMapView addAnnotation:placeObject];
            if (i==0)
            {
                
                MKCoordinateSpan zoom;
                zoom.latitudeDelta = .1f; //the zoom level in degrees
                zoom.longitudeDelta = .1f;//the zoom level in degrees
                [self.myMapView setCenterCoordinate:[placeObject coordinate] animated:YES];
                MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([placeObject  coordinate],500, 500);
                region.span=zoom;
                [self.myMapView setRegion:region];
                
                [self.myMapView selectAnnotation:placeObject animated:YES];
            }
        }

    }
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    // Define your reuse identifier.
    static NSString *identifier = @"MapPoint";
    
    if ([annotation isKindOfClass:[MapPoint class]]) {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.myMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        return annotationView;
    } 
    return nil;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==3)
    {
        if (buttonIndex==0)
        {
            [self.navigationController popViewControllerAnimated:YES];
           
        }
    }
    
}


- (IBAction)btn_myLoc_pressed:(id)sender {
    
    MKCoordinateSpan zoom;
    zoom.latitudeDelta = .1f; //the zoom level in degrees
    zoom.longitudeDelta = .1f;//the zoom level in degrees
    [self.myMapView setCenterCoordinate:[self.locationManager.location coordinate] animated:YES];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([self.locationManager.location  coordinate], 200, 200);
    region.span=zoom;
    [self.myMapView setRegion:region];

}
@end
