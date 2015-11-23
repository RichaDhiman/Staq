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

@property BOOL hasAnimated;
-(void)configureCell:(NSString*)imgName1 :(NSString*)imgName2 :(NSString*)imgName3 :(NSString*)title;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cnst_trailing;

@property (strong, nonatomic) IBOutlet UIImageView *imgPer1;
@property (strong, nonatomic) IBOutlet UIImageView *imgPer3;
@property (strong, nonatomic) IBOutlet UIImageView *imgPer2;


@end
