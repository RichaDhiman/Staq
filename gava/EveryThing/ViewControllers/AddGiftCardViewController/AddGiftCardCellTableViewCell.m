//
//  AddGiftCardCellTableViewCell.m
//  gava
//
//  Created by RICHA on 9/5/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "AddGiftCardCellTableViewCell.h"

@implementation AddGiftCardCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.contentView.transform=CGAffineTransformIdentity;
    // Configure the view for the selected state
}

#pragma mark-ConfigureCell
-(void)configure:(UserProfile*)upObj
{
    UserProfile *ud=[[UserProfile alloc]init];
    ud=upObj;
    self.lbl_brandName.text=ud.bDet_name;
     [self.img_brand setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%d",Url_pics,ud.bDet_minlogo,(int)(DISPLAYSCALE*self.img_brand.frame.size.width)]] placeholderImage:nil options:SDWebImageTransformAnimatedImage progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
         
     } completed:nil usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //self.contentView.transform=CGAffineTransformMakeTranslation(0,self.contentView.frame.size.height);
   }


@end
