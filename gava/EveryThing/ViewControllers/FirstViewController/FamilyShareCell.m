//
//  FamilyShareCell.m
//  gava
//
//  Created by RICHA on 11/4/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "FamilyShareCell.h"

@implementation FamilyShareCell
-(void)configureCell:(NSString*)imgName :(NSString*)title
{
    self.lbl_title.preferredMaxLayoutWidth=[[UIScreen mainScreen] bounds].size.width-60;
    
    self.img_familyShare.image=[UIImage imageNamed:imgName];
    self.lbl_title.text=title;
}
@end
