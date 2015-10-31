//
//  AlertView.h
//  gava
//
//  Created by RICHA on 10/6/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Facebook-iOS-SDK/FBSDKCoreKit/FBSDKCoreKit.h>
#import <Facebook-iOS-SDK/FBSDKLoginKit/FBSDKLoginKit.h>
#import <Facebook-iOS-SDK/FBSDKShareKit/FBSDKShareKit.h>

@interface AlertView : UIView<UIAlertViewDelegate>
-(void)showStaticAlertWithTitle : (NSString *)title AndMessage : (NSString *)msg;
-(void)showAlertWithOptions : (NSString *)title AndMessage : (NSString *)msg :(NSArray*)options;

@end
