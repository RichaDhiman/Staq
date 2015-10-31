//
//  AddCodeToSyncViewController.h
//  gava
//
//  Created by RICHA on 10/19/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AlertView.h"
#import "UserProfile.h"
#import "CardDetails.h"


@interface AddCodeToSyncViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *lbl_AddCode;
@property (strong, nonatomic) IBOutlet UITextField *tf_code;

@property (strong, nonatomic) IBOutlet UIButton *btn_back;
- (IBAction)btn_back_pressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn_sync;

- (IBAction)btn_sync_pressed:(id)sender;

@end
