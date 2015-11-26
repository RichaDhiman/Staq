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

//-(void)configureCell:(NSString*)imgsName :(NSString*)title;

@property (strong, nonatomic) IBOutlet UIView *view_imgs_back;
@property BOOL hasAnimated;


@property (strong, nonatomic) IBOutlet UIImageView *last_img;
@property (strong, nonatomic) IBOutlet UIImageView *Sec_img;
@property (strong, nonatomic) IBOutlet UIImageView *first_img;
@property (strong, nonatomic) IBOutlet UILabel *lbl_title;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cnst_img3_leadng;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cnst_img2_leadng;


//Cnst
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cnst_lastimg_ld;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cnst_lastimg_tr;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cnst_secimg_ld;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cnst_secimg_tr;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cnst_firstimg_ld;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cnst_firstimg_tr;



@end
