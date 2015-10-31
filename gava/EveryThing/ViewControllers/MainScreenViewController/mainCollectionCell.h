//
//  mainCollectionCell.h
//  gava
//
//  Created by RICHA on 9/5/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardDetails.h"
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import <SCSkypeActivityIndicatorView.h>
#import "Constants.h"

@interface mainCollectionCell : UICollectionViewCell

@property(nonatomic,retain)SCSkypeActivityIndicatorView *ld;
@property (strong, nonatomic) IBOutlet UIImageView *img_card;

@property (strong, nonatomic) IBOutlet UILabel *lbl_cost;

@property(nonatomic,retain)UIActivityIndicatorView *actInd;

-(void)ConfigureCell:(CardDetails*)cardDet;
@property (strong, nonatomic) IBOutlet UIView *view_forShadow;
@property (strong, nonatomic) IBOutlet UIVisualEffectView *blurview;
@property (strong, nonatomic) IBOutlet UILabel *lbl_otherCardName;

@end
