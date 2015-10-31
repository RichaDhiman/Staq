//
//  FamilyShareTableCell.m
//  gava
//
//  Created by RICHA on 10/19/15.
//  Copyright (c) 2015 Richa. All rights reserved.
//

#import "FamilyShareTableCell.h"

@implementation FamilyShareTableCell

- (void)awakeFromNib {
    // Initialization code
    self.img_syncFrnd.layer.cornerRadius=self.img_syncFrnd.frame.size.width/2;
    self.img_syncFrnd.clipsToBounds=YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark-ConfigureCell
-(void)configure:(UserProfile*)upObj
{
    UserProfile *ud=[[UserProfile alloc]init];
    ud=upObj;
    self.lbl_FrndName.text=[NSString stringWithFormat:@"%@ %@",ud.user_first_name,ud.user_last_name];
    
    NSMutableString * firstCharacters = [NSMutableString string];
    NSArray * words = [self.lbl_FrndName.text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    for (NSString * word in words) {
        if ([word length] > 0) {
            NSString * firstLetter = [word substringToIndex:1];
            [firstCharacters appendString:[firstLetter uppercaseString]];
            
        }
        self.lbl_name_initials.text=firstCharacters;
    }

    
    
    
//    [self.img_brand setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%d",Url_pics,ud.bDet_minlogo,(int)(DISPLAYSCALE*self.img_brand.frame.size.width)]] placeholderImage:nil options:SDWebImageTransformAnimatedImage progress:^(NSInteger receivedSize, NSInteger expectedSize)
//     {
//         
//     } completed:nil usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}


@end
