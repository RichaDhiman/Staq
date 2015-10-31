//
//  mainCollectionCell.m
//  gava
//
//  Created by RICHA on 9/5/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "mainCollectionCell.h"

@implementation mainCollectionCell
-(void) awakeFromNib
{
   self.view_forShadow.hidden=YES;
}
/*!
 *  @brief  cell configuration
 *
 *  @param cardDet card details modal passed
 */
-(void)ConfigureCell:(CardDetails*)cardDet
{
    CardDetails  *cd=[[CardDetails alloc]init];
    cd=cardDet;
    
    if ([cd.card_is_custom isEqualToString:@"1"]) {
        self.lbl_otherCardName.hidden=NO;
        self.lbl_otherCardName.text=cd.card_brand_name;
    }
    else
    {
        self.lbl_otherCardName.hidden=YES;

    }
    
    self.lbl_cost.text=cd.card_price;
    //__weak mainCollectionCell *weakSelf = self;
    [self.img_card setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%f",Url_pics,cd.brandDet.bDet_logo,([UIScreen mainScreen].bounds.size.width-16)*DISPLAYSCALE]] placeholderImage:nil options:SDWebImageTransformAnimatedImage progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.ld startAnimating];
        
    } completed:nil usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    

}

@end
