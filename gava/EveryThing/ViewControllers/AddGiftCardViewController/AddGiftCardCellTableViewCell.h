//
//  AddGiftCardCellTableViewCell.h
//  gava
//
//  Created by RICHA on 9/5/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import <SCSkypeActivityIndicatorView.h>
#import "Constants.h"

@interface AddGiftCardCellTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *img_brand;

@property (strong, nonatomic) IBOutlet UILabel *lbl_brandName;
-(void)configure:(UserProfile*)upObj;



@end
