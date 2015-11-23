//
//  FirstCell.m
//  gava
//
//  Created by RICHA on 11/3/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "FirstCell.h"

@implementation FirstCell

-(void)configureCell:(NSString*)imgName1 :(NSString*)imgName2 :(NSString*)imgName3 :(NSString*)title
{
    self.first_img.image=[UIImage imageNamed:imgName1];
    self.Sec_img.image=[UIImage imageNamed:imgName2];
    self.last_img.image=[UIImage imageNamed:imgName3];
    self.lbl_title.text=title;
}
//-(void)configureCell:(NSString*)imgsName :(NSString*)title;
//{
//    self.lbl_title.preferredMaxLayoutWidth=[[UIScreen mainScreen] bounds].size.width-60;
//    self.first_img.image=[UIImage imageNamed:imgsName];
//    
//    self.lbl_title.text=title;
//}

@end
