//
//  FamilyShareCell.h
//  gava
//
//  Created by RICHA on 11/4/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyShareCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *img_familyShare;
@property (strong, nonatomic) IBOutlet UILabel *lbl_title;

-(void)configureCell:(NSString*)imgsName :(NSString*)title;

@end
