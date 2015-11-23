//
//  imgCollectionCell.h
//  gava
//
//  Created by RICHA on 9/4/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface imgCollectionCell : UICollectionViewCell

@property BOOL hasAnimated;
@property (strong, nonatomic) IBOutlet UIImageView *img_logos;

@property (strong, nonatomic) IBOutlet UILabel *lbl_title;

-(void)configureCell:(NSString*)imgsName :(NSString*)imgName2 :(NSString*)title;
@property (strong, nonatomic) IBOutlet UIImageView *img_popup;

@property(nonatomic,retain)NSArray *images;



@end
