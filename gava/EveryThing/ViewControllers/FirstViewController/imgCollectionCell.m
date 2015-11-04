//
//  imgCollectionCell.m
//  gava
//
//  Created by RICHA on 9/4/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "imgCollectionCell.h"

@implementation imgCollectionCell
/*!
 *  @brief  To configure cell
 *  @param imgName Name Of the image 
 *  @param title   title of image
 */
-(void)configureCell:(NSString*)imgName :(NSString*)title
{
    self.lbl_title.preferredMaxLayoutWidth=[[UIScreen mainScreen] bounds].size.width-60;

    self.img_logos.image=[UIImage imageNamed:imgName];
    self.lbl_title.text=title;
}
@end
