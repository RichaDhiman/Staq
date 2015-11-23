//
//  FamilyShareCell.m
//  gava
//
//  Created by RICHA on 11/4/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "FamilyShareCell.h"

@implementation FamilyShareCell
-(void)configureCell:(NSString*)imgName1 :(NSString*)imgName2 :(NSString*)imgName3 :(NSString*)title
{

    self.lbl_title.text=title;
     self.imgPer1.image=[UIImage imageNamed:imgName1];
    self.imgPer2.image=[UIImage imageNamed:imgName2];
    self.imgPer3.image=[UIImage imageNamed:imgName3];
    

    }
@end
