//
//  ThirdCellCollectionViewCell.h
//  gava
//
//  Created by RICHA on 11/3/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdCellCollectionViewCell : UICollectionViewCell
-(void)configureCell:(NSString*)imgName1 :(NSString*)imgName2 :(NSString*)title;

@property BOOL hasAnimated;
@property (strong, nonatomic) IBOutlet UILabel *lbl_title;
@property (strong, nonatomic) IBOutlet UIImageView *img_card;
@property (strong, nonatomic) IBOutlet UIImageView *img_scannerLine;
@property (strong, nonatomic) IBOutlet UIView *view_price_back;

@property (strong, nonatomic) IBOutlet UILabel *lbl_first;

@property (strong, nonatomic) IBOutlet UILabel *lbl_second;





@end
