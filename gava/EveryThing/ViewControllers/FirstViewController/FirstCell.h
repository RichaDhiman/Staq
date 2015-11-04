//
//  FirstCell.h
//  gava
//
//  Created by RICHA on 11/3/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstCell : UICollectionViewCell
-(void)configureCell:(NSString*)imgName1 :(NSString*)imgName2 :(NSString*)imgName3 :(NSString*)title;
@property (strong, nonatomic) IBOutlet UIView *view_imgs_back;


@property (strong, nonatomic) IBOutlet UIImageView *last_img;
@property (strong, nonatomic) IBOutlet UIImageView *Sec_img;
@property (strong, nonatomic) IBOutlet UIImageView *first_img;
@property (strong, nonatomic) IBOutlet UILabel *lbl_title;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cnst_img3_leadng;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cnst_img2_leadng;




@end
