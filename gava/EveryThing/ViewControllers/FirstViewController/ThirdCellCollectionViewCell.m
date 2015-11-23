//
//  ThirdCellCollectionViewCell.m
//  gava
//
//  Created by RICHA on 11/3/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "ThirdCellCollectionViewCell.h"

@implementation ThirdCellCollectionViewCell
-(void)configureCell:(NSString*)imgName1 :(NSString*)imgName2 :(NSString*)title
{
    self.img_card.image=[UIImage imageNamed:imgName1];
    self.img_scannerLine.image=[UIImage imageNamed:imgName2];
    self.lbl_title.text=title;
    
}

@end
