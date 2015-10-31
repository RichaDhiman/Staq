//
//  FamilyShareTableCell.h
//  gava
//
//  Created by RICHA on 10/19/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWTableViewCell.h>
#import "UserProfile.h"

@interface FamilyShareTableCell : SWTableViewCell
-(void)configure:(UserProfile*)upObj;
@property (strong, nonatomic) IBOutlet UIImageView *img_syncFrnd;

@property (strong, nonatomic) IBOutlet UILabel *lbl_FrndName;

@property (strong, nonatomic) IBOutlet UILabel *lbl_name_initials;


@end
