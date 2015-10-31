//
//  ContactsHeaderView.h
//  gava
//
//  Created by RICHA on 10/20/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsHeaderView : UIView
@property (strong) IBOutlet UIImageView *img_userPic;
@property (strong, nonatomic) IBOutlet UILabel *lbl_user_name;

@property (strong) IBOutlet UIButton *btn_AllOption;
- (IBAction)btn_AllOption_pressed:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lbl_ifNoPIc;
@property (strong, nonatomic) IBOutlet UIButton *btn_iconImg;

@end
