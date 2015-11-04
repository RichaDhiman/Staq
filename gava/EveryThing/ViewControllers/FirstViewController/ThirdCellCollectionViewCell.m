//
//  ThirdCellCollectionViewCell.m
//  gava
//
//  Created by RICHA on 11/3/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "ThirdCellCollectionViewCell.h"

@implementation ThirdCellCollectionViewCell
-(void)configureCell:(NSString*)imgName1 :(NSString*)title
{
    self.lbl_title.preferredMaxLayoutWidth=[[UIScreen mainScreen] bounds].size.width-60;

    self.img_card.image=[UIImage imageNamed:imgName1];
    self.lbl_title.text=title;
}

@end
